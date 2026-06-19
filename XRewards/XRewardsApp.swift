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
    @AppStorage(AppUILanguage.storageKey) private var uiLanguage = AppUILanguage.default.rawValue
    @StateObject private var authService: AuthenticationService
    @StateObject private var session = XRewardsSession.shared
    @State private var isAppCheckReady = false
    @State private var hasAcceptedPrivacyPolicy = PrivacyPolicyStorage.hasAccepted

    private var lang: AppUILanguage { uiLanguage.appLanguage }

    init() {
        _authService = StateObject(wrappedValue: AuthenticationService.shared)
    }

    var body: some View {
        Group {
            if !hasAcceptedPrivacyPolicy {
                XRewardsPrivacyConsentView {
                    hasAcceptedPrivacyPolicy = true
                }
            } else if !isAppCheckReady {
                ProgressView(L10n.preparingConnection(lang: lang))
            } else if session.canUseApp {
                MainTabView()
            } else {
                XRewardsAuthenticationView()
            }
        }
        .id(uiLanguage)
        .environment(\.appLanguage, lang)
        .preferredColorScheme(.dark)
        .onOpenURL { url in
            _ = GIDSignIn.sharedInstance.handle(url)
        }
        .task {
            await AppCheckWarmup.prepare()
            isAppCheckReady = true
            session.refresh()
        }
        .onChange(of: authService.isAuthenticated) { _, _ in
            session.refresh()
        }
    }
}
