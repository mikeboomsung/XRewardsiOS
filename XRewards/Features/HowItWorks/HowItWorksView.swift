import SwiftUI

struct HowItWorksView: View {
    @Environment(\.appLanguage) private var lang

    private var steps: [WorkflowStep] { PreviewData.workflowSteps(for: lang) }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Theme.cardSpacing) {
                Text(L10n.howItWorksSubtitle(lang: lang))
                    .font(.subheadline)
                    .foregroundStyle(Theme.textSecondary)

                ForEach(Array(steps.enumerated()), id: \.element.id) { index, step in
                    WorkflowStepView(
                        step: step,
                        isLast: index == steps.count - 1
                    )
                }

                RewardPoolDiagramView(poolPercentRange: 30...50)
                RetentionChartView()

                Text(L10n.fivePillars(lang: lang))
                    .font(.headline)
                    .foregroundStyle(Theme.textPrimary)

                ForEach(PreviewData.pillars(for: lang)) { pillar in
                    ValuePillarRow(pillar: pillar)
                }
            }
            .padding(Theme.horizontalPadding)
        }
        .screenBackground()
        .navigationTitle(L10n.howItWorks(lang: lang))
    }
}

#Preview {
    NavigationStack {
        HowItWorksView()
            .environment(\.appLanguage, .zh)
    }
}
