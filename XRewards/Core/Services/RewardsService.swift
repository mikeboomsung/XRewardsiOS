import Foundation

protocol RewardsService: Sendable {
    func fetchProfile() async -> UserProfile
    func fetchDashboard() async -> DashboardSummary
    func fetchTransactions() async -> [PointTransaction]
    func fetchDividends() async -> [DividendPeriod]
    func fetchCurrentDividend() async -> DividendPeriod
    func fetchTeam() async -> TeamSummary
}
