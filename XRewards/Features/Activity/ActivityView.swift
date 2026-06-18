import SwiftUI

struct ActivityView: View {
    @Environment(RewardsStore.self) private var store
    @State private var filter: ActivityFilter = .all

    enum ActivityFilter: String, CaseIterable {
        case all = "All"
        case referrals = "Referrals"
        case pending = "Pending"
        case confirmed = "Confirmed"
    }

    private var filteredTransactions: [PointTransaction] {
        switch filter {
        case .all:
            return store.transactions
        case .referrals:
            return store.transactions.filter { $0.action.localizedCaseInsensitiveContains("referral") }
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
                        Text(option.rawValue).tag(option)
                    }
                }
                .pickerStyle(.segmented)
                .padding()

                if filter == .referrals {
                    referralsList
                } else if filteredTransactions.isEmpty {
                    ContentUnavailableView(
                        "No Activity",
                        systemImage: "tray",
                        description: Text("Transactions matching this filter will appear here.")
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
            .navigationTitle("Activity")
        }
    }

    private var referralsList: some View {
        Group {
            if store.referrals.isEmpty {
                ContentUnavailableView(
                    "No Referrals Yet",
                    systemImage: "person.badge.plus",
                    description: Text("Submit invitee details from Earn → Start Earning to earn 10 points per referral.")
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
                Text(referral.category.displayName)
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
        .environment(RewardsStore())
}
