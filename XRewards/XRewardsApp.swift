//
//  XRewardsApp.swift
//  XRewards
//

import AdventureServices
import GoogleSignIn
import SwiftUI

@main
struct XRewardsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

    var body: some Scene {
        WindowGroup {
            XRewardsRootView()
        }
    }
}

private struct XRewardsRootView: View {
    @StateObject private var authService: AuthenticationService
    @State private var isAppCheckReady = false

    init() {
        _authService = StateObject(wrappedValue: AuthenticationService.shared)
    }

    var body: some View {
        Group {
            if !isAppCheckReady {
                ProgressView("Preparing secure connection…")
            } else if authService.isAuthenticated {
                MainTabView()
            } else {
                XRewardsAuthenticationView()
            }
        }
        .preferredColorScheme(.dark)
        .onOpenURL { url in
            _ = GIDSignIn.sharedInstance.handle(url)
        }
        .task {
            await AppCheckWarmup.prepare()
            isAppCheckReady = true
        }
    }
}
