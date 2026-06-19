import FirebaseAppCheck
import FirebaseCore

enum FirebaseBootstrap {
    /// Configures Firebase and App Check before any other Firebase SDK is used.
    ///
    /// Physical device (Debug or Release): App Attest — same as NewStart / KidsAdventure.
    /// Simulator only: App Check debug provider (register the printed token in Firebase Console).
    static func configure() {
        if FirebaseApp.app() != nil {
            print("⚠️ [XRewards] Firebase was already configured before App Check — callable requests may fail with UNAUTHENTICATED")
            return
        }

        AppCheck.setAppCheckProviderFactory(XRewardsAppCheckProviderFactory())
        FirebaseApp.configure()

        AppCheck.appCheck().token(forcingRefresh: false) { token, error in
            if let error {
                print("❌ [XRewards] App Check token error: \(error.localizedDescription)")
            } else if let token {
                print("✅ [XRewards] App Check token ready: \(token.token.prefix(24))… (expires \(token.expirationDate))")
            }
        }
    }
}
