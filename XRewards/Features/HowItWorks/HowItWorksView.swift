import SwiftUI

struct HowItWorksView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Theme.cardSpacing) {
                Text("Your path from action to passive income")
                    .font(.subheadline)
                    .foregroundStyle(Theme.textSecondary)

                ForEach(Array(PreviewData.workflowSteps.enumerated()), id: \.element.id) { index, step in
                    WorkflowStepView(
                        step: step,
                        isLast: index == PreviewData.workflowSteps.count - 1
                    )
                }

                RewardPoolDiagramView(poolPercentRange: 30...50)
                RetentionChartView()

                Text("Five Value Pillars")
                    .font(.headline)
                    .foregroundStyle(Theme.textPrimary)

                ForEach(PreviewData.pillars) { pillar in
                    ValuePillarRow(pillar: pillar)
                }
            }
            .padding(Theme.horizontalPadding)
        }
        .screenBackground()
        .navigationTitle("How It Works")
    }
}

#Preview {
    NavigationStack {
        HowItWorksView()
    }
}
