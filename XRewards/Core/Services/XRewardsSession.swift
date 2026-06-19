import AdventureServices
import Combine
import Foundation

#if canImport(FirebaseAuth)
import FirebaseAuth
#endif

/// Tracks member vs guest access for XRewards (guest = Firebase anonymous preview).
@MainActor
final class XRewardsSession: ObservableObject {
    static let shared = XRewardsSession()

    @Published private(set) var isGuest = false
    @Published private(set) var isMember = false

    var canUseApp: Bool { isGuest || isMember }

    private var authHandle: AuthStateDidChangeListenerHandle?

    private init() {
        refresh()
        #if canImport(FirebaseAuth)
        authHandle = Auth.auth().addStateDidChangeListener { [weak self] _, _ in
            Task { @MainActor in
                self?.refresh()
            }
        }
        #endif
    }

    func refresh() {
        #if canImport(FirebaseAuth)
        let user = Auth.auth().currentUser
        isGuest = user?.isAnonymous == true
        isMember = AuthenticationService.shared.isAuthenticated && !isGuest
        #else
        isGuest = false
        isMember = false
        #endif
    }
}
