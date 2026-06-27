import SwiftUI

struct PointBalanceCard: View {
    let totalPoints: Int
    var title: String = "Total Points"
    var footnote: String = "Permanent · Never expire"

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline)
                .foregroundStyle(Theme.textSecondary)

            Text(totalPoints.pointsString)
                .font(.system(size: 44, weight: .bold, design: .rounded))
                .foregroundStyle(Theme.accentGold)
                .accessibilityLabel("Total points \(totalPoints)")

            Text(footnote)
                .font(.caption)
                .foregroundStyle(Theme.textSecondary)
        }
        .cardStyle()
    }
}

struct DividendEstimateCard: View {
    let amount: Decimal
    let poolPercent: Int
    var title: String = "Estimated This Month"
    var subtitle: String = "Based on current pool"
    var poolFootnote: String = "Reward pool: 40% of platform profit"

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "banknote.fill")
                    .foregroundStyle(Theme.accentGold)
                Text(title)
                    .font(.headline)
                    .foregroundStyle(Theme.textPrimary)
            }

            Text(amount.currencyString)
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(Theme.textPrimary)

            Text(subtitle)
                .font(.caption)
                .foregroundStyle(Theme.textSecondary)

            Text(poolFootnote)
                .font(.caption2)
                .foregroundStyle(Theme.textSecondary)
        }
        .cardStyle()
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let icon: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundStyle(Theme.accentGold)
                Text(title)
                    .font(.subheadline)
                    .foregroundStyle(Theme.textSecondary)
            }
            Text(value)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(Theme.textPrimary)
        }
        .cardStyle()
    }
}

struct CategoryTile: View {
    @Environment(\.appLanguage) private var lang
    let category: RevenueCategory

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: category.icon)
                .font(.title2)
                .foregroundStyle(Theme.accentGold)

            Text(category.displayName(for: lang))
                .font(.headline)
                .foregroundStyle(Theme.textPrimary)
                .multilineTextAlignment(.leading)

            Text("\(category.pointRangeLabel) pts")
                .font(.caption)
                .foregroundStyle(Theme.textSecondary)
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 120, alignment: .topLeading)
        .background(Theme.backgroundCard)
        .clipShape(RoundedRectangle(cornerRadius: Theme.tileCornerRadius))
    }
}

struct TransactionRow: View {
    let transaction: PointTransaction

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: transaction.category.icon)
                .font(.title3)
                .foregroundStyle(Theme.accentGold)
                .frame(width: 36)

            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.action)
                    .font(.headline)
                    .foregroundStyle(Theme.textPrimary)
                Text(transaction.createdAt.mediumDate)
                    .font(.caption)
                    .foregroundStyle(Theme.textSecondary)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text("+\(transaction.points.pointsString)")
                    .font(.headline)
                    .foregroundStyle(Theme.accentGold)
                StatusBadge(status: transaction.status)
            }
        }
        .padding(.vertical, 8)
    }
}

struct StatusBadge: View {
    @Environment(\.appLanguage) private var lang
    let status: TransactionStatus

    var body: some View {
        Text(status.displayName(for: lang))
            .font(.caption2)
            .fontWeight(.semibold)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(status.color.opacity(0.2))
            .foregroundStyle(status.color)
            .clipShape(Capsule())
    }
}

struct WorkflowStepView: View {
    @Environment(\.appLanguage) private var lang
    let step: WorkflowStep
    let isLast: Bool

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            VStack(spacing: 0) {
                ZStack {
                    Circle()
                        .fill(Theme.accentGold.opacity(0.2))
                        .frame(width: 44, height: 44)
                    Image(systemName: step.icon)
                        .foregroundStyle(Theme.accentGold)
                }
                if !isLast {
                    Rectangle()
                        .fill(Theme.textSecondary.opacity(0.3))
                        .frame(width: 2, height: 40)
                }
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(L10n.stepNumber(step.id, lang: lang))
                    .font(.caption)
                    .foregroundStyle(Theme.accentGold)
                Text(step.title)
                    .font(.headline)
                    .foregroundStyle(Theme.textPrimary)
                Text(step.description)
                    .font(.subheadline)
                    .foregroundStyle(Theme.textSecondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.bottom, isLast ? 0 : 16)
        }
    }
}

struct ValuePillarRow: View {
    let pillar: ValuePillar

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: pillar.icon)
                .font(.title2)
                .foregroundStyle(Theme.accentGold)
                .frame(width: 32)

            VStack(alignment: .leading, spacing: 4) {
                Text(pillar.title)
                    .font(.headline)
                    .foregroundStyle(Theme.textPrimary)
                Text(pillar.subtitle)
                    .font(.subheadline)
                    .foregroundStyle(Theme.textSecondary)
            }
            Spacer()
        }
        .padding()
        .background(Theme.backgroundCard)
        .clipShape(RoundedRectangle(cornerRadius: Theme.tileCornerRadius))
    }
}

struct DividendRow: View {
    @Environment(\.appLanguage) private var lang
    let period: DividendPeriod

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(period.month.monthYear)
                    .font(.headline)
                    .foregroundStyle(Theme.textPrimary)
                Text(period.status.displayName(for: lang))
                    .font(.caption)
                    .foregroundStyle(Theme.textSecondary)
            }
            Spacer()
            Text(period.payoutAmount.currencyString)
                .font(.headline)
                .foregroundStyle(Theme.accentGold)
        }
        .padding()
        .background(Theme.backgroundCard)
        .clipShape(RoundedRectangle(cornerRadius: Theme.tileCornerRadius))
    }
}

struct PrimaryButton: View {
    let title: String
    let action: () -> Void

    init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }

    init(title: LocalizedStringResource, action: @escaping () -> Void) {
        self.title = String(localized: title)
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Theme.accentGold)
                .foregroundStyle(Theme.backgroundPrimary)
                .clipShape(RoundedRectangle(cornerRadius: Theme.tileCornerRadius))
        }
    }
}
