import SwiftUI

struct HomeView: View {
    @Environment(\.appLanguage) private var lang
    @Environment(RewardsStore.self) private var store
    @State private var showHowItWorks = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: Theme.cardSpacing) {
                    if store.isGuestPreview {
                        guestBanner
                    }

                    greetingHeader

                    if let dashboard = store.dashboard {
                        PointBalanceCard(
                            totalPoints: dashboard.totalPoints,
                            title: L10n.totalPoints(lang: lang),
                            footnote: L10n.pointsPermanent(lang: lang)
                        )

                        DividendEstimateCard(
                            amount: dashboard.estimatedMonthlyDividend,
                            poolPercent: 40,
                            title: L10n.estimatedThisMonth(lang: lang),
                            subtitle: L10n.basedOnCurrentPool(lang: lang),
                            poolFootnote: L10n.rewardPoolPercent(40, lang: lang)
                        )

                        StatCard(
                            title: L10n.pendingPoints(lang: lang),
                            value: dashboard.pendingPoints.pointsString,
                            icon: "clock.fill"
                        )

                        activeStreamsSection(dashboard.activeCategories)

                        Button {
                            showHowItWorks = true
                        } label: {
                            HStack {
                                Text(L10n.howPassiveIncomeWorks(lang: lang))
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .foregroundStyle(Theme.accentGold)
                            .padding()
                            .background(Theme.backgroundCard)
                            .clipShape(RoundedRectangle(cornerRadius: Theme.tileCornerRadius))
                        }
                    } else if store.isLoading {
                        ProgressView()
                            .tint(Theme.accentGold)
                            .frame(maxWidth: .infinity, minHeight: 200)
                    }
                }
                .padding(Theme.horizontalPadding)
            }
            .screenBackground()
            .navigationTitle(L10n.dashboard(lang: lang))
            .navigationBarTitleDisplayMode(.large)
            .navigationDestination(isPresented: $showHowItWorks) {
                HowItWorksView()
            }
        }
    }

    private var guestBanner: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: "eye.fill")
                .foregroundStyle(Theme.accentGold)
            Text(L10n.guestPreviewBanner(lang: lang))
                .font(.footnote)
                .foregroundStyle(Theme.textSecondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Theme.backgroundCard)
        .clipShape(RoundedRectangle(cornerRadius: Theme.tileCornerRadius))
    }

    private var greetingHeader: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(L10n.welcomeBack(lang: lang))
                .font(.subheadline)
                .foregroundStyle(Theme.textSecondary)
            Text(store.profile?.name ?? L10n.member(lang: lang))
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(Theme.textPrimary)
        }
        .padding(.bottom, 4)
    }

    private func activeStreamsSection(_ categories: [RevenueCategory]) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(L10n.activeRevenueStreams(lang: lang))
                .font(.headline)
                .foregroundStyle(Theme.textPrimary)

            FlowLayout(spacing: 8) {
                ForEach(categories) { category in
                    HStack(spacing: 6) {
                        Image(systemName: category.icon)
                        Text(category.displayName(for: lang))
                    }
                    .font(.caption)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Theme.backgroundCard)
                    .foregroundStyle(Theme.textPrimary)
                    .clipShape(Capsule())
                }
            }
        }
    }
}

#Preview {
    HomeView()
        .environment(RewardsStore.preview())
        .environment(\.appLanguage, .zh)
}

private struct FlowLayout: Layout {
    var spacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = arrange(proposal: proposal, subviews: subviews)
        return result.size
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = arrange(proposal: proposal, subviews: subviews)
        for (index, position) in result.positions.enumerated() {
            subviews[index].place(
                at: CGPoint(x: bounds.minX + position.x, y: bounds.minY + position.y),
                proposal: .unspecified
            )
        }
    }

    private func arrange(proposal: ProposedViewSize, subviews: Subviews) -> (size: CGSize, positions: [CGPoint]) {
        let maxWidth = proposal.width ?? .infinity
        var positions: [CGPoint] = []
        var x: CGFloat = 0
        var y: CGFloat = 0
        var rowHeight: CGFloat = 0

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            if x + size.width > maxWidth, x > 0 {
                x = 0
                y += rowHeight + spacing
                rowHeight = 0
            }
            positions.append(CGPoint(x: x, y: y))
            rowHeight = max(rowHeight, size.height)
            x += size.width + spacing
        }

        return (CGSize(width: maxWidth, height: y + rowHeight), positions)
    }
}
