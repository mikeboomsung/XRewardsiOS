import FirebaseAppCheck
import Foundation

enum AppCheckWarmup {
    /// Prefetch an App Check token so the first Cloud Function call is not rejected as UNAUTHENTICATED.
    static func prepare() async {
        do {
            let token = try await fetchToken(forceRefresh: false)
            #if DEBUG
            if let debugToken = token.debugToken {
                print("🔐 [XRewards] App Check debug token (register in Firebase Console): \(debugToken)")
            } else {
                print("🔐 [XRewards] App Check token ready (expires \(token.expirationDate))")
            }
            #endif
        } catch {
            print("⚠️ [XRewards] App Check warmup failed: \(error.localizedDescription)")
        }
    }

    static func fetchToken(forceRefresh: Bool) async throws -> AppCheckToken {
        try await withCheckedThrowingContinuation { continuation in
            AppCheck.appCheck().token(forcingRefresh: forceRefresh) { token, error in
                if let error {
                    continuation.resume(throwing: error)
                    return
                }
                guard let token else {
                    continuation.resume(
                        throwing: NSError(
                            domain: "XRewards.AppCheck",
                            code: -1,
                            userInfo: [NSLocalizedDescriptionKey: "App Check token was nil"]
                        )
                    )
                    return
                }
                continuation.resume(returning: token)
            }
        }
    }
}

private extension AppCheckToken {
    /// Debug provider exposes the token UUID in the JWT payload for Console registration.
    var debugToken: String? {
        let parts = token.split(separator: ".")
        guard parts.count >= 2 else { return nil }

        var payload = String(parts[1])
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        while payload.count % 4 != 0 {
            payload.append("=")
        }

        guard
            let data = Data(base64Encoded: payload),
            let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
            let subject = json["sub"] as? String
        else {
            return nil
        }

        return subject
    }
}
