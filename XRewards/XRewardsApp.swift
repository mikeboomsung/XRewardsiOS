//
//  XRewardsApp.swift
//  XRewards
//

import SwiftUI

@main
struct XRewardsApp: App {
    init() {
        FirebaseBootstrap.configure()
    }

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .preferredColorScheme(.dark)
        }
    }
}
