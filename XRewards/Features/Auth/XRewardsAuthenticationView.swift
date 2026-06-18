import AdventureAuthUI
import SwiftUI
import UIKit

struct XRewardsAuthenticationView: View {
    private static let config = AuthUIConfig(
        appDisplayName: "XRewards",
        tagline: "Build points. Share rewards. Grow together.",
        promoText: "Earn 10 points for every member referral",
        logoProvider: { UIImage(named: "AppLogo") }
    )

    var body: some View {
        AdventureAuthUI.AuthenticationView(config: Self.config)
    }
}

#Preview {
    XRewardsAuthenticationView()
}
