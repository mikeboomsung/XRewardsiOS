import Foundation

@Observable
@MainActor
final class RewardsStore {
    var profile: UserProfile?
    var dashboard: DashboardSummary?
    var transactions: [PointTransaction] = []
    var dividends: [DividendPeriod] = []
    var currentDividend: DividendPeriod?
    var referrals: [ReferralRecord] = []
    var isLoading = false
    var usesLiveData = false
    var isGuestPreview = false

    private let liveService = LiveRewardsService()
    private let mockService = MockRewardsService()

    func loadMember() async {
        isLoading = true
        usesLiveData = true
        isGuestPreview = false
        defer { isLoading = false }

        await liveService.refresh()

        async let profileTask = liveService.fetchProfile()
        async let dashboardTask = liveService.fetchDashboard()
        async let transactionsTask = liveService.fetchTransactions()
        async let dividendsTask = liveService.fetchDividends()
        async let currentDividendTask = liveService.fetchCurrentDividend()
        async let referralsTask = liveService.fetchReferrals()

        profile = await profileTask
        dashboard = await dashboardTask
        transactions = await transactionsTask
        dividends = await dividendsTask
        currentDividend = await currentDividendTask
        referrals = await referralsTask
    }

    func loadGuestPreview(language: AppUILanguage) async {
        isLoading = true
        usesLiveData = false
        isGuestPreview = true
        defer { isLoading = false }

        async let profileTask = mockService.fetchProfile()
        async let dashboardTask = mockService.fetchDashboard()
        async let transactionsTask = mockService.fetchTransactions()
        async let dividendsTask = mockService.fetchDividends()
        async let currentDividendTask = mockService.fetchCurrentDividend()
        async let referralsTask = mockService.fetchReferrals()

        let mockProfile = await profileTask
        profile = UserProfile(
            name: L10n.guestProfileName(lang: language),
            memberID: L10n.guestMemberID(lang: language),
            memberSince: mockProfile.memberSince
        )
        dashboard = await dashboardTask
        transactions = await transactionsTask
        dividends = await dividendsTask
        currentDividend = await currentDividendTask
        referrals = await referralsTask
    }

    func refreshAfterReferral(isMember: Bool) async {
        guard isMember else { return }
        await loadMember()
    }

    func clear() {
        profile = nil
        dashboard = nil
        transactions = []
        dividends = []
        currentDividend = nil
        referrals = []
        usesLiveData = false
        isGuestPreview = false
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
