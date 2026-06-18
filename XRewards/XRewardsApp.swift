//
//  XRewardsApp.swift
//  XRewards
//

import AdventureServices
import SwiftUI

@main
struct XRewardsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    @StateObject private var authService = AuthenticationService.shared

    init() {
        FirebaseBootstrap.configure()
        XRewardsSecrets.configure()
        Task {
            await AppCheckWarmup.prepare()
        }
    }

    var body: some Scene {
        WindowGroup {
            Group {
                if authService.isAuthenticated {
                    MainTabView()
                } else {
                    XRewardsAuthenticationView()
                }
            }
            .preferredColorScheme(.dark)
        }
    }
}
