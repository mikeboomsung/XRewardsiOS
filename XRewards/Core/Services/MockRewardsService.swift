import Foundation

final class MockRewardsService: RewardsService {
    private let calendar = Calendar.current

    func fetchProfile() async -> UserProfile {
        UserProfile(
            name: "Alex Chen",
            memberID: "XR-10482",
            memberSince: date(2025, 3, 15)
        )
    }

    func fetchDashboard() async -> DashboardSummary {
        DashboardSummary(
            totalPoints: 12_450,
            pendingPoints: 800,
            estimatedMonthlyDividend: 186.75,
            rewardPoolPercentRange: 30...50,
            lastSettlementDate: date(2026, 6, 1),
            activeCategories: [.insurance, .appEcosystem, .loans],
            poolAmount: 7_500,
            totalPlatformPoints: 500_000
        )
    }

    func fetchTransactions() async -> [PointTransaction] {
        [
            PointTransaction(
                id: UUID(),
                category: .insurance,
                action: "Insurance Sale",
                points: 2_500,
                status: .confirmed,
                createdAt: date(2026, 6, 1),
                confirmedAt: date(2026, 6, 2)
            ),
            PointTransaction(
                id: UUID(),
                category: .appEcosystem,
                action: "App Paid User",
                points: 200,
                status: .confirmed,
                createdAt: date(2026, 6, 10),
                confirmedAt: date(2026, 6, 10)
            ),
            PointTransaction(
                id: UUID(),
                category: .loans,
                action: "Loan Referral",
                points: 500,
                status: .pending,
                createdAt: date(2026, 6, 14),
                confirmedAt: nil
            ),
            PointTransaction(
                id: UUID(),
                category: .content,
                action: "Published Lead",
                points: 350,
                status: .confirmed,
                createdAt: date(2026, 5, 22),
                confirmedAt: date(2026, 5, 24)
            ),
            PointTransaction(
                id: UUID(),
                category: .training,
                action: "Attend Event",
                points: 600,
                status: .confirmed,
                createdAt: date(2026, 5, 8),
                confirmedAt: date(2026, 5, 8)
            )
        ]
    }

    func fetchCurrentDividend() async -> DividendPeriod {
        DividendPeriod(
            id: UUID(),
            month: date(2026, 6, 1),
            poolAmount: 7_500,
            totalPlatformPoints: 500_000,
            userPoints: 12_450,
            userShare: Decimal(string: "0.0249")!,
            payoutAmount: 186.75,
            status: .estimated
        )
    }

    func fetchDividends() async -> [DividendPeriod] {
        [
            DividendPeriod(
                id: UUID(),
                month: date(2026, 5, 1),
                poolAmount: 6_800,
                totalPlatformPoints: 485_000,
                userPoints: 11_200,
                userShare: Decimal(string: "0.0231")!,
                payoutAmount: 157.08,
                status: .paid
            ),
            DividendPeriod(
                id: UUID(),
                month: date(2026, 4, 1),
                poolAmount: 6_200,
                totalPlatformPoints: 460_000,
                userPoints: 9_800,
                userShare: Decimal(string: "0.0213")!,
                payoutAmount: 132.06,
                status: .paid
            ),
            DividendPeriod(
                id: UUID(),
                month: date(2026, 3, 1),
                poolAmount: 5_500,
                totalPlatformPoints: 420_000,
                userPoints: 8_100,
                userShare: Decimal(string: "0.0193")!,
                payoutAmount: 106.15,
                status: .paid
            )
        ]
    }

    func fetchTeam() async -> TeamSummary {
        TeamSummary(directMembers: 8, totalDownline: 34, teamPoints: 48_200)
    }

    func fetchReferrals() async -> [ReferralRecord] {
        [
            ReferralRecord(
                id: "preview-1",
                inviteeName: "Jane Doe",
                inviteePhone: "+1 555-0100",
                inviteeEmail: "jane@example.com",
                category: .insurance,
                pointsAwarded: 10,
                status: .pending,
                createdAt: date(2026, 6, 12)
            ),
            ReferralRecord(
                id: "preview-2",
                inviteeName: "Bob Smith",
                inviteePhone: "+1 555-0101",
                inviteeEmail: "bob@example.com",
                category: .loans,
                pointsAwarded: 10,
                status: .confirmed,
                createdAt: date(2026, 6, 5)
            ),
        ]
    }

    private func date(_ year: Int, _ month: Int, _ day: Int) -> Date {
        calendar.date(from: DateComponents(year: year, month: month, day: day)) ?? .now
    }
}
