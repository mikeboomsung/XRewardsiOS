import AdventureServices
import SwiftUI

struct ProfileView: View {
    @Environment(RewardsStore.self) private var store
    @StateObject private var authService = AuthenticationService.shared
    @State private var isSigningOut = false
    @State private var isEditingName = false
    @State private var editedName = ""
    @State private var isSavingName = false
    @State private var nameError: String?

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
                            }
                        }
                        .padding(.vertical, 8)
                        .listRowBackground(Theme.backgroundCard)

                        if store.usesLiveData {
                            Button {
                                editedName = profile.name == "Member" ? "" : profile.name
                                nameError = nil
                                isEditingName = true
                            } label: {
                                Label("Edit Name", systemImage: "pencil")
                            }
                            .listRowBackground(Theme.backgroundCard)
                        }
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
            .sheet(isPresented: $isEditingName) {
                editNameSheet
            }
        }
    }

    private var editNameSheet: some View {
        NavigationStack {
            Form {
                Section("Display name") {
                    TextField("Your name", text: $editedName)
                        .textInputAutocapitalization(.words)
                        .autocorrectionDisabled()
                }

                if let nameError {
                    Section {
                        Text(nameError)
                            .foregroundStyle(.red)
                            .font(.footnote)
                    }
                }
            }
            .navigationTitle("Edit Name")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { isEditingName = false }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        Task { await saveName() }
                    }
                    .disabled(isSavingName || editedName.trimmingCharacters(in: .whitespacesAndNewlines).count < 2)
                }
            }
        }
        .presentationDetents([.medium])
    }

    private func saveName() async {
        isSavingName = true
        nameError = nil
        defer { isSavingName = false }

        do {
            _ = try await ProfileService.shared.updateDisplayName(editedName)
            await store.load(isAuthenticated: authService.isAuthenticated)
            isEditingName = false
        } catch {
            nameError = error.localizedDescription
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
        .environment(RewardsStore.preview())
}
