import Foundation

@Observable
@MainActor
final class RewardsStore {
    var profile: UserProfile?
    var dashboard: DashboardSummary?
    var transactions: [PointTransaction] = []
    var dividends: [DividendPeriod] = []
    var currentDividend: DividendPeriod?
    var team: TeamSummary?
    var isLoading = false

    private let service: RewardsService

    init(service: RewardsService = MockRewardsService()) {
        self.service = service
    }

    func load() async {
        isLoading = true
        defer { isLoading = false }

        async let profileTask = service.fetchProfile()
        async let dashboardTask = service.fetchDashboard()
        async let transactionsTask = service.fetchTransactions()
        async let dividendsTask = service.fetchDividends()
        async let currentDividendTask = service.fetchCurrentDividend()
        async let teamTask = service.fetchTeam()

        profile = await profileTask
        dashboard = await dashboardTask
        transactions = await transactionsTask
        dividends = await dividendsTask
        currentDividend = await currentDividendTask
        team = await teamTask
    }
}
