import AdventureServices
import SwiftUI

struct ProfileView: View {
    @AppStorage(AppUILanguage.storageKey) private var uiLanguage = AppUILanguage.default.rawValue
    @Environment(RewardsStore.self) private var store
    @StateObject private var authService = AuthenticationService.shared
    @StateObject private var session = XRewardsSession.shared
    @State private var isSigningOut = false
    @State private var isEditingName = false
    @State private var editedName = ""
    @State private var isSavingName = false
    @State private var nameError: String?
    @State private var showDeleteConfirm = false
    @State private var isDeletingAccount = false
    @State private var deleteError: String?

    private var lang: AppUILanguage { uiLanguage.appLanguage }

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
                                if session.isGuest {
                                    Text(L10n.guestAccountLabel(lang: lang))
                                        .font(.caption)
                                        .foregroundStyle(Theme.pending)
                                }
                                Text(L10n.memberIDLabel(profile.memberID, lang: lang))
                                    .font(.caption)
                                    .foregroundStyle(Theme.textSecondary)
                                if !session.isGuest {
                                    Text(L10n.memberSince(profile.memberSince.mediumDate, lang: lang))
                                        .font(.caption)
                                        .foregroundStyle(Theme.textSecondary)
                                }
                            }
                        }
                        .padding(.vertical, 8)
                        .listRowBackground(Theme.backgroundCard)

                        if store.usesLiveData, !session.isGuest {
                            Button {
                                editedName = profile.name == "Member" ? "" : profile.name
                                nameError = nil
                                isEditingName = true
                            } label: {
                                Label(L10n.editName(lang: lang), systemImage: "pencil")
                            }
                            .listRowBackground(Theme.backgroundCard)
                        }

                        if session.isGuest {
                            Button {
                                Task { await signOut() }
                            } label: {
                                Label(L10n.signInToEarn(lang: lang), systemImage: "person.badge.key.fill")
                            }
                            .listRowBackground(Theme.backgroundCard)
                        }
                    }
                }

                Section(L10n.learn(lang: lang)) {
                    NavigationLink {
                        HowItWorksView()
                    } label: {
                        Label(L10n.howItWorks(lang: lang), systemImage: "lightbulb.fill")
                    }
                    .listRowBackground(Theme.backgroundCard)

                    NavigationLink {
                        DividendsView()
                    } label: {
                        Label(L10n.dividends(lang: lang), systemImage: "banknote.fill")
                    }
                    .listRowBackground(Theme.backgroundCard)
                }

                Section(L10n.support(lang: lang)) {
                    NavigationLink {
                        XRewardsPrivacyPolicyReadView()
                    } label: {
                        Label(L10n.privacyPolicy(lang: lang), systemImage: "hand.raised.fill")
                    }
                    .listRowBackground(Theme.backgroundCard)

                    Link(destination: URL(string: "mailto:support@xrewards.app")!) {
                        Label(L10n.contactSupport(lang: lang), systemImage: "envelope.fill")
                    }
                    .listRowBackground(Theme.backgroundCard)
                }

                Section(L10n.settings(lang: lang)) {
                    HStack {
                        Label(L10n.language(lang: lang), systemImage: "globe")
                        Spacer()
                        LanguagePickerMenu()
                    }
                    .listRowBackground(Theme.backgroundCard)

                    if session.isMember {
                        Button(role: .destructive) {
                            showDeleteConfirm = true
                        } label: {
                            HStack {
                                Label(L10n.deleteAccount(lang: lang), systemImage: "trash.fill")
                                Spacer()
                                if isDeletingAccount {
                                    ProgressView()
                                }
                            }
                        }
                        .disabled(isDeletingAccount || authService.isLoading)
                        .listRowBackground(Theme.backgroundCard)
                    }

                    Button {
                        Task { await signOut() }
                    } label: {
                        HStack {
                            Label(
                                session.isGuest ? L10n.exitGuest(lang: lang) : L10n.signOut(lang: lang),
                                systemImage: "rectangle.portrait.and.arrow.right"
                            )
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
            .navigationTitle(L10n.profile(lang: lang))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    LanguageToggleButton()
                }
            }
            .sheet(isPresented: $isEditingName) {
                editNameSheet
            }
            .alert(L10n.deleteAccountTitle(lang: lang), isPresented: $showDeleteConfirm) {
                Button(L10n.cancel(lang: lang), role: .cancel) {}
                Button(L10n.delete(lang: lang), role: .destructive) {
                    Task { await deleteAccount() }
                }
            } message: {
                Text(L10n.deleteAccountMessage(lang: lang))
            }
            .alert(L10n.deleteAccount(lang: lang), isPresented: Binding(
                get: { deleteError != nil },
                set: { if !$0 { deleteError = nil } }
            )) {
                Button(L10n.ok(lang: lang)) { deleteError = nil }
            } message: {
                Text(deleteError ?? "")
            }
            .onChange(of: uiLanguage) { _, _ in
                if session.isGuest {
                    Task { await store.loadGuestPreview(language: lang) }
                }
            }
        }
    }

    private var editNameSheet: some View {
        NavigationStack {
            Form {
                Section(L10n.displayName(lang: lang)) {
                    TextField(L10n.yourName(lang: lang), text: $editedName)
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
            .navigationTitle(L10n.editName(lang: lang))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(L10n.cancel(lang: lang)) { isEditingName = false }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(L10n.save(lang: lang)) {
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
            await store.loadMember()
            isEditingName = false
        } catch {
            nameError = error.localizedDescription
        }
    }

    private func deleteAccount() async {
        isDeletingAccount = true
        deleteError = nil
        defer { isDeletingAccount = false }

        do {
            store.clear()
            try await authService.deleteAccount()
            XRewardsSession.shared.refresh()
        } catch {
            deleteError = error.localizedDescription
        }
    }

    private func signOut() async {
        isSigningOut = true
        defer { isSigningOut = false }
        store.clear()
        try? await authService.signOut()
    }
}

#Preview {
    ProfileView()
        .environment(RewardsStore.preview())
        .environment(\.appLanguage, .zh)
}
