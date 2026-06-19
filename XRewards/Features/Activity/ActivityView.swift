import SwiftUI

struct ActivityView: View {
    @Environment(\.appLanguage) private var lang
    @Environment(RewardsStore.self) private var store
    @State private var filter: ActivityFilter = .all

    enum ActivityFilter: CaseIterable {
        case all, referrals, pending, confirmed

        func label(lang: AppUILanguage) -> String {
            switch self {
            case .all: return L10n.filterAll(lang: lang)
            case .referrals: return L10n.filterReferrals(lang: lang)
            case .pending: return L10n.filterPending(lang: lang)
            case .confirmed: return L10n.filterConfirmed(lang: lang)
            }
        }
    }

    private var filteredTransactions: [PointTransaction] {
        switch filter {
        case .all:
            return store.transactions
        case .referrals:
            return store.transactions.filter { $0.action.localizedCaseInsensitiveContains("referral") || $0.action.localizedCaseInsensitiveContains("推荐") }
        case .pending:
            return store.transactions.filter { $0.status == .pending }
        case .confirmed:
            return store.transactions.filter { $0.status == .confirmed }
        }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Picker("Filter", selection: $filter) {
                    ForEach(ActivityFilter.allCases, id: \.self) { option in
                        Text(option.label(lang: lang)).tag(option)
                    }
                }
                .pickerStyle(.segmented)
                .padding()

                if filter == .referrals {
                    referralsList
                } else if filteredTransactions.isEmpty {
                    ContentUnavailableView(
                        L10n.noActivity(lang: lang),
                        systemImage: "tray",
                        description: Text(L10n.noActivityDesc(lang: lang))
                    )
                    .foregroundStyle(Theme.textSecondary)
                } else {
                    List(filteredTransactions) { transaction in
                        TransactionRow(transaction: transaction)
                            .listRowBackground(Theme.backgroundCard)
                            .listRowSeparatorTint(Theme.textSecondary.opacity(0.2))
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
            }
            .screenBackground()
            .navigationTitle(L10n.activity(lang: lang))
        }
    }

    private var referralsList: some View {
        Group {
            if store.referrals.isEmpty {
                ContentUnavailableView(
                    L10n.noReferrals(lang: lang),
                    systemImage: "person.badge.plus",
                    description: Text(L10n.noReferralsDesc(lang: lang))
                )
                .foregroundStyle(Theme.textSecondary)
            } else {
                List(store.referrals) { referral in
                    ReferralRow(referral: referral)
                        .listRowBackground(Theme.backgroundCard)
                        .listRowSeparatorTint(Theme.textSecondary.opacity(0.2))
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }
        }
    }
}

struct ReferralRow: View {
    @Environment(\.appLanguage) private var lang
    let referral: ReferralRecord

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(referral.inviteeName)
                    .font(.headline)
                    .foregroundStyle(Theme.textPrimary)
                Spacer()
                Text("+\(referral.pointsAwarded.pointsString)")
                    .font(.headline)
                    .foregroundStyle(Theme.accentGold)
            }
            Text(referral.inviteeEmail)
                .font(.caption)
                .foregroundStyle(Theme.textSecondary)
            HStack {
                Text(referral.inviteePhone)
                Spacer()
                Text(referral.category.displayName(for: lang))
                StatusBadge(status: referral.status)
            }
            .font(.caption)
            .foregroundStyle(Theme.textSecondary)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    ActivityView()
        .environment(RewardsStore.preview())
        .environment(\.appLanguage, .zh)
}
