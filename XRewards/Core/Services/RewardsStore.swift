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
    var referrals: [ReferralRecord] = []
    var isLoading = false
    var usesLiveData = false

    private let liveService = LiveRewardsService()
    private let mockService = MockRewardsService()

    func load(isAuthenticated: Bool) async {
        isLoading = true
        usesLiveData = isAuthenticated
        defer { isLoading = false }

        let service: any RewardsService = isAuthenticated ? liveService : mockService

        if isAuthenticated {
            await liveService.refresh()
        }

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
        referrals = isAuthenticated ? await liveService.fetchReferrals() : []
    }

    func refreshAfterReferral(isAuthenticated: Bool) async {
        guard isAuthenticated else { return }
        await load(isAuthenticated: true)
    }
}
