import SwiftUI

struct ActivityView: View {
    @Environment(RewardsStore.self) private var store
    @State private var filter: ActivityFilter = .all

    enum ActivityFilter: String, CaseIterable {
        case all = "All"
        case pending = "Pending"
        case confirmed = "Confirmed"
    }

    private var filteredTransactions: [PointTransaction] {
        switch filter {
        case .all:
            return store.transactions
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

                if filteredTransactions.isEmpty {
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
}

#Preview {
    ActivityView()
        .environment(RewardsStore())
}
