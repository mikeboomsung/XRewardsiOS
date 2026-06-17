import SwiftUI

struct TeamView: View {
    @Environment(RewardsStore.self) private var store
    @State private var showShareSheet = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: Theme.cardSpacing) {
                    Text("Build your team and grow collective points.")
                        .font(.subheadline)
                        .foregroundStyle(Theme.textSecondary)

                    if let team = store.team {
                        HStack(spacing: 12) {
                            TeamStatCard(title: "Direct Members", value: "\(team.directMembers)")
                            TeamStatCard(title: "Total Team", value: "\(team.totalDownline)")
                            TeamStatCard(title: "Team Points", value: team.teamPoints.pointsString)
                        }
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Team Structure")
                            .font(.headline)
                            .foregroundStyle(Theme.textPrimary)

                        ContentUnavailableView(
                            "Org Chart Coming Soon",
                            systemImage: "point.3.connected.trianglepath.dotted",
                            description: Text("Member list and hierarchy will appear in a future update.")
                        )
                        .frame(minHeight: 160)
                    }
                    .cardStyle()

                    PrimaryButton(title: "Invite Members") {
                        showShareSheet = true
                    }

                    Text("Share your referral link when the invite flow launches.")
                        .font(.caption)
                        .foregroundStyle(Theme.textSecondary)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .padding(Theme.horizontalPadding)
            }
            .screenBackground()
            .navigationTitle("Team")
            .sheet(isPresented: $showShareSheet) {
                ShareInviteSheet()
            }
        }
    }
}

struct ShareInviteSheet: View {
    @Environment(\.dismiss) private var dismiss

    private let message = """
    Join me on XRewards — earn permanent points and monthly dividends from real business activities. \
    Download the app and start earning: https://xrewards.app/invite
    """

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Image(systemName: "person.badge.plus")
                    .font(.system(size: 48))
                    .foregroundStyle(Theme.accentGold)

                Text("Invite friends to grow your team and unlock more earning opportunities.")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Theme.textSecondary)
                    .padding(.horizontal)

                ShareLink(item: message) {
                    Text("Share Invite")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Theme.accentGold)
                        .foregroundStyle(Theme.backgroundPrimary)
                        .clipShape(RoundedRectangle(cornerRadius: Theme.tileCornerRadius))
                }
                .padding(.horizontal)
            }
            .padding()
            .screenBackground()
            .navigationTitle("Invite")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") { dismiss() }
                        .foregroundStyle(Theme.accentGold)
                }
            }
        }
        .presentationDetents([.medium])
    }
}

#Preview {
    TeamView()
        .environment(RewardsStore())
}
