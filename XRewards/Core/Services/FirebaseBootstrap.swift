import FirebaseAppCheck
import FirebaseCore

enum FirebaseBootstrap {
    /// Configures Firebase and App Check before any other Firebase SDK is used.
    ///
    /// Production / release posture:
    /// - **Physical iPhone:** App Attest (matches `appattest-environment` = production in entitlements)
    /// - **Simulator (Debug only):** debug provider — register the printed token in Firebase Console → App Check
    static func configure() {
        #if targetEnvironment(simulator) && DEBUG
        AppCheck.setAppCheckProviderFactory(AppCheckDebugProviderFactory())
        #else
        AppCheck.setAppCheckProviderFactory(AppAttestProviderFactory())
        #endif

        FirebaseApp.configure()
    }
}
