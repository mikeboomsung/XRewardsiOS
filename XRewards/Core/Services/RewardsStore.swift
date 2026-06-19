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

    func load(isAuthenticated: Bool) async {
        isLoading = true
        usesLiveData = isAuthenticated
        defer { isLoading = false }

        guard isAuthenticated else {
            clear()
            return
        }

        await liveService.refresh()

        async let profileTask = liveService.fetchProfile()
        async let dashboardTask = liveService.fetchDashboard()
        async let transactionsTask = liveService.fetchTransactions()
        async let dividendsTask = liveService.fetchDividends()
        async let currentDividendTask = liveService.fetchCurrentDividend()
        async let teamTask = liveService.fetchTeam()
        async let referralsTask = liveService.fetchReferrals()

        profile = await profileTask
        dashboard = await dashboardTask
        transactions = await transactionsTask
        dividends = await dividendsTask
        currentDividend = await currentDividendTask
        team = await teamTask
        referrals = await referralsTask
    }

    func refreshAfterReferral(isAuthenticated: Bool) async {
        guard isAuthenticated else { return }
        await load(isAuthenticated: true)
    }

    private func clear() {
        profile = nil
        dashboard = nil
        transactions = []
        dividends = []
        currentDividend = nil
        team = nil
        referrals = []
    }
}

extension RewardsStore {
    static func preview() -> RewardsStore {
        let store = RewardsStore()
        store.profile = UserProfile(name: "Alex Chen", memberID: "XR-10482", memberSince: .now)
        store.dashboard = DashboardSummary(
            totalPoints: 12_450,
            pendingPoints: 800,
            estimatedMonthlyDividend: 186.75,
            rewardPoolPercentRange: 30...50,
            lastSettlementDate: nil,
            activeCategories: [.insurance, .appEcosystem],
            poolAmount: 7_500,
            totalPlatformPoints: 500_000
        )
        store.usesLiveData = false
        return store
    }
}
