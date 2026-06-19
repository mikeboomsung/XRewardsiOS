import AdventureServices
import SwiftUI

struct MainTabView: View {
    @State private var store = RewardsStore()
    @StateObject private var authService = AuthenticationService.shared

    var body: some View {
        TabView {
            HomeView()
                .tabItem { Label("Home", systemImage: "house.fill") }

            EarnView()
                .tabItem { Label("Earn", systemImage: "square.grid.2x2.fill") }

            ActivityView()
                .tabItem { Label("Activity", systemImage: "list.bullet.rectangle") }

            TeamView()
                .tabItem { Label("Team", systemImage: "person.3.fill") }

            ProfileView()
                .tabItem { Label("Profile", systemImage: "person.crop.circle") }
        }
        .tint(Theme.accentGold)
        .environment(store)
        .task(id: authService.isAuthenticated) {
            guard authService.isAuthenticated else {
                await store.load(isAuthenticated: false)
                return
            }
            try? await CallableSupport.ensureUserProfile()
            await store.load(isAuthenticated: true)
        }
    }
}

#Preview {
    MainTabView()
}
