import FirebaseAppCheck
import Foundation

enum AppCheckWarmup {
    /// Prefetch an App Check token so the first Cloud Function call is not rejected as UNAUTHENTICATED.
    static func prepare() async {
        do {
            let token = try await fetchToken(forceRefresh: false)
            print("🔐 [XRewards] App Check warmup OK: \(token.token.prefix(24))… (expires \(token.expirationDate))")
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
