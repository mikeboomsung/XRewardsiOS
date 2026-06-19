import AdventureServices
import SwiftUI

struct CategoryDetailView: View {
    @Environment(\.appLanguage) private var lang
    @Environment(RewardsStore.self) private var store
    let category: RevenueCategory

    @StateObject private var session = XRewardsSession.shared
    @State private var showReferralForm = false
    @State private var showGuestAlert = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Theme.cardSpacing) {
                HStack(spacing: 16) {
                    Image(systemName: category.icon)
                        .font(.largeTitle)
                        .foregroundStyle(Theme.accentGold)
                    VStack(alignment: .leading, spacing: 4) {
                        Text(category.displayName(for: lang))
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(Theme.textPrimary)
                        Text("\(category.pointRangeLabel) pts")
                            .font(.subheadline)
                            .foregroundStyle(Theme.textSecondary)
                    }
                }

                Text(category.summary(for: lang))
                    .font(.body)
                    .foregroundStyle(Theme.textSecondary)

                Text(L10n.pointTable(lang: lang))
                    .font(.headline)
                    .foregroundStyle(Theme.textPrimary)

                ForEach(Array(category.actions(for: lang).enumerated()), id: \.offset) { _, action in
                    HStack {
                        Text(action.name)
                            .foregroundStyle(Theme.textPrimary)
                        Spacer()
                        Text("\(action.range) pts")
                            .foregroundStyle(Theme.accentGold)
                            .fontWeight(.semibold)
                    }
                    .padding()
                    .background(Theme.backgroundCard)
                    .clipShape(RoundedRectangle(cornerRadius: Theme.tileCornerRadius))
                }

                PrimaryButton(title: L10n.startEarning(lang: lang)) {
                    if session.isGuest {
                        showGuestAlert = true
                    } else {
                        showReferralForm = true
                    }
                }
                .padding(.top, 8)

                Text(L10n.submitReferralHint(lang: lang))
                    .font(.caption)
                    .foregroundStyle(Theme.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding(Theme.horizontalPadding)
        }
        .screenBackground()
        .navigationTitle(category.displayName(for: lang))
        .navigationBarTitleDisplayMode(.inline)
        .alert(L10n.guestCannotEarn(lang: lang), isPresented: $showGuestAlert) {
            Button(L10n.ok(lang: lang), role: .cancel) {}
        }
        .sheet(isPresented: $showReferralForm) {
            ReferralSubmissionView(category: category) {
                Task {
                    await store.refreshAfterReferral(isMember: session.isMember)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        CategoryDetailView(category: .insurance)
            .environment(RewardsStore.preview())
            .environment(\.appLanguage, .zh)
    }
}
