import AdventureServices
import SwiftUI

struct ProfileView: View {
    @Environment(RewardsStore.self) private var store
    @StateObject private var authService = AuthenticationService.shared
    @State private var isSigningOut = false

    var body: some View {
        NavigationStack {
            List {
                if let profile = store.profile {
                    Section {
                        HStack(spacing: 16) {
                            Image(systemName: "person.crop.circle.fill")
                                .font(.system(size: 56))
                                .foregroundStyle(Theme.accentGold)
                            VStack(alignment: .leading, spacing: 4) {
                                Text(profile.name)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundStyle(Theme.textPrimary)
                                Text("ID: \(profile.memberID)")
                                    .font(.caption)
                                    .foregroundStyle(Theme.textSecondary)
                                Text("Member since \(profile.memberSince.mediumDate)")
                                    .font(.caption)
                                    .foregroundStyle(Theme.textSecondary)
                                if store.usesLiveData {
                                    Text("Live account")
                                        .font(.caption2)
                                        .foregroundStyle(Theme.success)
                                }
                            }
                        }
                        .padding(.vertical, 8)
                        .listRowBackground(Theme.backgroundCard)
                    }
                }

                Section("Learn") {
                    NavigationLink {
                        HowItWorksView()
                    } label: {
                        Label("How It Works", systemImage: "lightbulb.fill")
                    }
                    .listRowBackground(Theme.backgroundCard)

                    NavigationLink {
                        DividendsView()
                    } label: {
                        Label("Dividends", systemImage: "banknote.fill")
                    }
                    .listRowBackground(Theme.backgroundCard)
                }

                Section("Support") {
                    Link(destination: URL(string: "https://xrewards.app/rules")!) {
                        Label("Reward Rules", systemImage: "doc.text.fill")
                    }
                    .listRowBackground(Theme.backgroundCard)
                    Link(destination: URL(string: "https://xrewards.app/faq")!) {
                        Label("FAQ", systemImage: "questionmark.circle.fill")
                    }
                    .listRowBackground(Theme.backgroundCard)
                    Link(destination: URL(string: "mailto:support@xrewards.app")!) {
                        Label("Contact Support", systemImage: "envelope.fill")
                    }
                    .listRowBackground(Theme.backgroundCard)
                }

                Section("Settings") {
                    HStack {
                        Label("Language", systemImage: "globe")
                        Spacer()
                        Text("English")
                            .foregroundStyle(Theme.textSecondary)
                    }
                    .listRowBackground(Theme.backgroundCard)
                    .opacity(0.6)

                    Button {
                        Task { await signOut() }
                    } label: {
                        HStack {
                            Label("Sign Out", systemImage: "rectangle.portrait.and.arrow.right")
                            Spacer()
                            if isSigningOut {
                                ProgressView()
                            }
                        }
                    }
                    .listRowBackground(Theme.backgroundCard)
                }
            }
            .scrollContentBackground(.hidden)
            .foregroundStyle(Theme.textPrimary)
            .screenBackground()
            .navigationTitle("Profile")
        }
    }

    private func signOut() async {
        isSigningOut = true
        defer { isSigningOut = false }
        try? await authService.signOut()
    }
}

#Preview {
    ProfileView()
        .environment(RewardsStore())
}
