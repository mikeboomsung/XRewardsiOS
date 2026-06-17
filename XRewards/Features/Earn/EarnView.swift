import SwiftUI

struct EarnView: View {
    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Choose a revenue stream and start earning permanent points.")
                        .font(.subheadline)
                        .foregroundStyle(Theme.textSecondary)

                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(RevenueCategory.allCases) { category in
                            NavigationLink(value: category) {
                                CategoryTile(category: category)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding(Theme.horizontalPadding)
            }
            .screenBackground()
            .navigationTitle("Earn")
            .navigationDestination(for: RevenueCategory.self) { category in
                CategoryDetailView(category: category)
            }
        }
    }
}

#Preview {
    EarnView()
}
