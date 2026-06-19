import SwiftUI

struct EarnView: View {
    @Environment(\.appLanguage) private var lang

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text(L10n.earnSubtitle(lang: lang))
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
            .navigationTitle(L10n.earnTitle(lang: lang))
            .navigationDestination(for: RevenueCategory.self) { category in
                CategoryDetailView(category: category)
            }
        }
    }
}

#Preview {
    EarnView()
        .environment(\.appLanguage, .zh)
}
