import Foundation

enum AppLaunch {
    static func runIfNeeded() {
        _ = didConfigure
    }

    static let didConfigure: Void = {
        FirebaseBootstrap.configure()
        XRewardsSecrets.configure()
    }()
}

// Run before UIApplicationDelegate / @StateObject touch Firebase.
private let _xRewardsLaunchBootstrap: Void = {
    AppLaunch.runIfNeeded()
}()
