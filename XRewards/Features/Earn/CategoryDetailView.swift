import SwiftUI

struct CategoryDetailView: View {
    let category: RevenueCategory

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Theme.cardSpacing) {
                HStack(spacing: 16) {
                    Image(systemName: category.icon)
                        .font(.largeTitle)
                        .foregroundStyle(Theme.accentGold)
                    VStack(alignment: .leading, spacing: 4) {
                        Text(category.displayName)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(Theme.textPrimary)
                        Text("\(category.pointRangeLabel) pts")
                            .font(.subheadline)
                            .foregroundStyle(Theme.textSecondary)
                    }
                }

                Text(category.summary)
                    .font(.body)
                    .foregroundStyle(Theme.textSecondary)

                Text("Point Table")
                    .font(.headline)
                    .foregroundStyle(Theme.textPrimary)

                ForEach(category.actions) { action in
                    HStack {
                        Text(action.name)
                            .foregroundStyle(Theme.textPrimary)
                        Spacer()
                        Text("\(action.pointRange) pts")
                            .foregroundStyle(Theme.accentGold)
                            .fontWeight(.semibold)
                    }
                    .padding()
                    .background(Theme.backgroundCard)
                    .clipShape(RoundedRectangle(cornerRadius: Theme.tileCornerRadius))
                }

                PrimaryButton(title: "Start Earning") {}
                    .padding(.top, 8)

                Text("Referral flows coming in a future update.")
                    .font(.caption)
                    .foregroundStyle(Theme.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding(Theme.horizontalPadding)
        }
        .screenBackground()
        .navigationTitle(category.displayName)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        CategoryDetailView(category: .insurance)
    }
}
