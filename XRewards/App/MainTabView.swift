import AdventureServices
import SwiftUI

struct MainTabView: View {
    @AppStorage(AppUILanguage.storageKey) private var uiLanguage = AppUILanguage.default.rawValue
    @State private var store = RewardsStore()
    @StateObject private var authService = AuthenticationService.shared
    @StateObject private var session = XRewardsSession.shared

    private var lang: AppUILanguage { uiLanguage.appLanguage }

    var body: some View {
        TabView {
            HomeView()
                .tabItem { Label(L10n.tabHome(lang: lang), systemImage: "house.fill") }

            EarnView()
                .tabItem { Label(L10n.tabEarn(lang: lang), systemImage: "square.grid.2x2.fill") }

            ActivityView()
                .tabItem { Label(L10n.tabActivity(lang: lang), systemImage: "list.bullet.rectangle") }

            ProfileView()
                .tabItem { Label(L10n.tabProfile(lang: lang), systemImage: "person.crop.circle") }
        }
        .id(uiLanguage)
        .tint(Theme.accentGold)
        .environment(store)
        .environment(\.appLanguage, lang)
        .task(id: sessionTaskID) {
            if session.isMember {
                try? await CallableSupport.ensureUserProfile()
                await store.loadMember()
            } else if session.isGuest {
                await store.loadGuestPreview(language: lang)
            } else {
                store.clear()
            }
        }
        .onChange(of: uiLanguage) { _, _ in
            if session.isGuest {
                Task { await store.loadGuestPreview(language: lang) }
            }
        }
    }

    private var sessionTaskID: String {
        "\(session.isMember)-\(session.isGuest)-\(uiLanguage)"
    }
}

#Preview {
    MainTabView()
        .environment(\.appLanguage, .zh)
}
