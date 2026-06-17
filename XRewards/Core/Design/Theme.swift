import SwiftUI

enum Theme {
    static let backgroundPrimary = Color("BackgroundPrimary")
    static let backgroundCard = Color("BackgroundCard")
    static let accentGold = Color("AccentGold")
    static let textPrimary = Color("TextPrimary")
    static let textSecondary = Color("TextSecondary")
    static let success = Color("Success")
    static let pending = Color("Pending")

    static let cardCornerRadius: CGFloat = 16
    static let tileCornerRadius: CGFloat = 12
    static let horizontalPadding: CGFloat = 20
    static let cardSpacing: CGFloat = 16
}

extension View {
    func screenBackground() -> some View {
        background(Theme.backgroundPrimary.ignoresSafeArea())
    }

    func cardStyle() -> some View {
        self
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Theme.backgroundCard)
            .clipShape(RoundedRectangle(cornerRadius: Theme.cardCornerRadius))
    }
}
