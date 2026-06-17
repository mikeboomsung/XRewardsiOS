import SwiftUI

struct MainTabView: View {
    @State private var store = RewardsStore()

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
        .task { await store.load() }
    }
}

#Preview {
    MainTabView()
}
