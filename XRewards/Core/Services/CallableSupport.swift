import FirebaseAuth
import FirebaseFunctions
import Foundation

enum CallableSupportError: LocalizedError {
    case notSignedIn
    case server(code: String, message: String)

    var errorDescription: String? {
        switch self {
        case .notSignedIn:
            "Sign in to continue."
        case .server(_, let message):
            message
        }
    }
}

enum CallableSupport {
    private static let region = "us-central1"

    /// Ensures App Check and Firebase Auth tokens are ready before a callable request.
    static func ensurePrerequisites(forceRefresh: Bool = false) async throws {
        _ = try await AppCheckWarmup.fetchToken(forceRefresh: forceRefresh)
        guard let user = Auth.auth().currentUser else {
            throw CallableSupportError.notSignedIn
        }
        _ = try await user.getIDToken(forcingRefresh: forceRefresh)
    }

    /// Calls a Cloud Function with App Check + Auth prerequisites and one retry on UNAUTHENTICATED.
    static func call(_ name: String, data: [String: Any] = [:]) async throws -> [String: Any] {
        try await ensurePrerequisites()
        let callable = Functions.functions(region: region).httpsCallable(name)

        do {
            return try unwrapResponse(try await callable.call(data))
        } catch {
            guard isUnauthenticated(error) else { throw mapCallableError(error) }
            logCallableFailure(name: name, error: error, attempt: "initial")
            print("⚠️ [XRewards] Callable \(name) UNAUTHENTICATED — refreshing App Check/Auth tokens")
            try await ensurePrerequisites(forceRefresh: true)
            do {
                return try unwrapResponse(try await callable.call(data))
            } catch {
                logCallableFailure(name: name, error: error, attempt: "retry")
                throw mapCallableError(error)
            }
        }
    }

    /// Creates the Firestore user profile if it does not exist yet (required before referrals).
    static func ensureUserProfile() async throws {
        try await UserProfileEnsureGate.shared.ensure {
            guard let user = Auth.auth().currentUser else {
                throw CallableSupportError.notSignedIn
            }
            var payload: [String: Any] = [:]
            if let email = user.email {
                payload["email"] = email
            }
            _ = try await call("createUserDocument", data: payload)
        }
    }

    static func errorMessage(from data: [String: Any]) -> String {
        if let error = data["error"] as? [String: Any],
           let message = error["message"] as? String {
            return message
        }
        return (data["message"] as? String) ?? "Request failed."
    }

    private static func unwrapResponse(_ result: HTTPSCallableResult) throws -> [String: Any] {
        guard let root = result.data as? [String: Any] else {
            throw CallableSupportError.server(code: "INVALID_RESPONSE", message: "Invalid server response.")
        }
        if let success = root["success"] as? Bool, !success {
            let error = root["error"] as? [String: Any]
            let code = error?["code"] as? String ?? "UNKNOWN"
            let message = error?["message"] as? String ?? errorMessage(from: root)
            throw CallableSupportError.server(code: code, message: message)
        }
        return root
    }

    private static func isUnauthenticated(_ error: Error) -> Bool {
        let description = error.localizedDescription.uppercased()
        if description.contains("UNAUTHENTICATED") { return true }

        let nsError = error as NSError
        if nsError.domain == FunctionsErrorDomain,
           nsError.code == FunctionsErrorCode.unauthenticated.rawValue {
            return true
        }
        return false
    }

    private static func mapCallableError(_ error: Error) -> Error {
        if let callableError = error as NSError?,
           callableError.domain == FunctionsErrorDomain {
            let message = callableError.localizedDescription
            return CallableSupportError.server(code: "CALLABLE", message: message)
        }
        return error
    }

    private static func logCallableFailure(name: String, error: Error, attempt: String) {
        let nsError = error as NSError
        let uid = Auth.auth().currentUser?.uid ?? "nil"
        print("❌ [XRewards] Callable \(name) failed (\(attempt)) uid=\(uid) domain=\(nsError.domain) code=\(nsError.code) \(nsError.localizedDescription)")
        if !nsError.userInfo.isEmpty {
            print("❌ [XRewards] Callable \(name) userInfo: \(nsError.userInfo)")
        }
    }
}
