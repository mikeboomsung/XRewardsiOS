import SwiftUI

struct DividendsView: View {
    @Environment(RewardsStore.self) private var store

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: Theme.cardSpacing) {
                    if let current = store.currentDividend {
                        currentPeriodCard(current)
                    }

                    Text("History")
                        .font(.headline)
                        .foregroundStyle(Theme.textPrimary)

                    ForEach(store.dividends) { period in
                        DividendRow(period: period)
                    }

                    formulaFooter
                }
                .padding(Theme.horizontalPadding)
            }
            .screenBackground()
            .navigationTitle("Dividends")
        }
    }

    private func currentPeriodCard(_ period: DividendPeriod) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Current Period")
                .font(.headline)
                .foregroundStyle(Theme.textPrimary)

            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Estimated Payout")
                        .font(.caption)
                        .foregroundStyle(Theme.textSecondary)
                    Text(period.payoutAmount.currencyString)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(Theme.accentGold)
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 4) {
                    Text(period.status.displayName)
                        .font(.caption)
                        .foregroundStyle(Theme.pending)
                    Text("Settles Jul 1")
                        .font(.caption2)
                        .foregroundStyle(Theme.textSecondary)
                }
            }

            Divider().overlay(Theme.textSecondary.opacity(0.3))

            detailRow("Pool Size", value: period.poolAmount.currencyString)
            detailRow("Your Share", value: period.userShare.percentString)
            detailRow("Your Points", value: period.userPoints.pointsString)
        }
        .cardStyle()
    }

    private func detailRow(_ label: String, value: String) -> some View {
        HStack {
            Text(label)
                .font(.subheadline)
                .foregroundStyle(Theme.textSecondary)
            Spacer()
            Text(value)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundStyle(Theme.textPrimary)
        }
    }

    private var formulaFooter: some View {
        Text("Your monthly dividend = (your points ÷ total platform points) × reward pool. Amounts are estimates until settlement.")
            .font(.caption)
            .foregroundStyle(Theme.textSecondary)
            .padding(.top, 8)
    }
}

#Preview {
    DividendsView()
        .environment(RewardsStore())
}
