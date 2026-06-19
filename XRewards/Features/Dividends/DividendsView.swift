import SwiftUI

struct DividendsView: View {
    @Environment(\.appLanguage) private var lang
    @Environment(RewardsStore.self) private var store

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: Theme.cardSpacing) {
                    if let current = store.currentDividend {
                        currentPeriodCard(current)
                    }

                    Text(L10n.history(lang: lang))
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
            .navigationTitle(L10n.dividends(lang: lang))
        }
    }

    private func currentPeriodCard(_ period: DividendPeriod) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(L10n.currentPeriod(lang: lang))
                .font(.headline)
                .foregroundStyle(Theme.textPrimary)

            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(L10n.estimatedPayout(lang: lang))
                        .font(.caption)
                        .foregroundStyle(Theme.textSecondary)
                    Text(period.payoutAmount.currencyString)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(Theme.accentGold)
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 4) {
                    Text(period.status.displayName(for: lang))
                        .font(.caption)
                        .foregroundStyle(Theme.pending)
                    Text(L10n.settlesJuly1(lang: lang))
                        .font(.caption2)
                        .foregroundStyle(Theme.textSecondary)
                }
            }

            Divider().overlay(Theme.textSecondary.opacity(0.3))

            detailRow(L10n.poolSize(lang: lang), value: period.poolAmount.currencyString)
            detailRow(L10n.yourShare(lang: lang), value: period.userShare.percentString)
            detailRow(L10n.yourPoints(lang: lang), value: period.userPoints.pointsString)
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
        Text(L10n.dividendFormula(lang: lang))
            .font(.caption)
            .foregroundStyle(Theme.textSecondary)
            .padding(.top, 8)
    }
}

#Preview {
    DividendsView()
        .environment(RewardsStore.preview())
        .environment(\.appLanguage, .zh)
}
