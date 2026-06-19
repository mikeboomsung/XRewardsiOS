import FirebaseAppCheck
import FirebaseCore
import Foundation

/// Matches NewStart / KidsAdventure: App Attest on physical devices; debug provider on Simulator only.
@objc final class XRewardsAppCheckProviderFactory: NSObject, AppCheckProviderFactory {
    func createProvider(with app: FirebaseApp) -> AppCheckProvider? {
        #if DEBUG && targetEnvironment(simulator)
        print("🔐 [XRewards] App Check provider: debug (simulator)")
        return AppCheckDebugProvider(app: app)
        #else
        guard #available(iOS 14.0, *) else {
            print("❌ [XRewards] App Attest requires iOS 14+")
            return nil
        }
        do {
            print("🔐 [XRewards] App Check provider: App Attest")
            return try AppAttestProvider(app: app)
        } catch {
            print("❌ [XRewards] App Attest unavailable: \(error.localizedDescription)")
            print("⚠️ [XRewards] Enable App Attest for com.vaiholding.XRewards in Apple Developer + Firebase Console → App Check")
            return nil
        }
        #endif
    }
}
