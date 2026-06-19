import SwiftUI

struct TeamView: View {
    @Environment(\.appLanguage) private var lang
    @Environment(RewardsStore.self) private var store
    @State private var showShareSheet = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: Theme.cardSpacing) {
                    Text(L10n.teamSubtitle(lang: lang))
                        .font(.subheadline)
                        .foregroundStyle(Theme.textSecondary)

                    if let team = store.team {
                        HStack(spacing: 12) {
                            TeamStatCard(title: L10n.directMembers(lang: lang), value: "\(team.directMembers)")
                            TeamStatCard(title: L10n.totalTeam(lang: lang), value: "\(team.totalDownline)")
                            TeamStatCard(title: L10n.teamPoints(lang: lang), value: team.teamPoints.pointsString)
                        }
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        Text(L10n.teamStructure(lang: lang))
                            .font(.headline)
                            .foregroundStyle(Theme.textPrimary)

                        ContentUnavailableView(
                            L10n.orgChartSoon(lang: lang),
                            systemImage: "point.3.connected.trianglepath.dotted",
                            description: Text(L10n.orgChartDesc(lang: lang))
                        )
                        .frame(minHeight: 160)
                    }
                    .cardStyle()

                    PrimaryButton(title: L10n.inviteMembers(lang: lang)) {
                        showShareSheet = true
                    }

                    Text(L10n.inviteHint(lang: lang))
                        .font(.caption)
                        .foregroundStyle(Theme.textSecondary)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .padding(Theme.horizontalPadding)
            }
            .screenBackground()
            .navigationTitle(L10n.team(lang: lang))
            .sheet(isPresented: $showShareSheet) {
                ShareInviteSheet()
            }
        }
    }
}

struct ShareInviteSheet: View {
    @Environment(\.appLanguage) private var lang
    @Environment(\.dismiss) private var dismiss

    private var message: String { L10n.inviteMessage(lang: lang) }

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Image(systemName: "person.badge.plus")
                    .font(.system(size: 48))
                    .foregroundStyle(Theme.accentGold)

                Text(L10n.inviteSheetBody(lang: lang))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Theme.textSecondary)
                    .padding(.horizontal)

                ShareLink(item: message) {
                    Text(L10n.shareInvite(lang: lang))
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
            .navigationTitle(L10n.inviteTitle(lang: lang))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(L10n.done(lang: lang)) { dismiss() }
                        .foregroundStyle(Theme.accentGold)
                }
            }
        }
        .presentationDetents([.medium])
    }
}

#Preview {
    TeamView()
        .environment(RewardsStore.preview())
        .environment(\.appLanguage, .zh)
}
