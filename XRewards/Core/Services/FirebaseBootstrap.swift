import FirebaseAppCheck
import FirebaseCore

enum FirebaseBootstrap {
    /// Configures Firebase and App Check before any other Firebase SDK is used.
    ///
    /// - **Simulator:** debug provider — copy the debug token from Xcode console into Firebase Console.
    /// - **Physical iPhone (Debug & Release):** App Attest — registers automatically after first run.
    static func configure() {
        #if targetEnvironment(simulator)
        AppCheck.setAppCheckProviderFactory(AppCheckDebugProviderFactory())
        #else
        AppCheck.setAppCheckProviderFactory(AppAttestProviderFactory())
        #endif

        FirebaseApp.configure()
    }
}
