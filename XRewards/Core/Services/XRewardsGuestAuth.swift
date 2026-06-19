import Foundation

#if canImport(FirebaseAuth)
import FirebaseAuth
#endif

enum XRewardsGuestAuth {
    static var isGuest: Bool {
        #if canImport(FirebaseAuth)
        Auth.auth().currentUser?.isAnonymous == true
        #else
        false
        #endif
    }

    /// Firebase anonymous sign-in for preview-only guest mode.
    static func continueAsGuest() async -> Bool {
        #if canImport(FirebaseAuth)
        if Auth.auth().currentUser != nil {
            return true
        }
        do {
            _ = try await Auth.auth().signInAnonymously()
            return true
        } catch {
            print("❌ [XRewards] Guest sign-in failed: \(error.localizedDescription)")
            return false
        }
        #else
        return false
        #endif
    }
}
