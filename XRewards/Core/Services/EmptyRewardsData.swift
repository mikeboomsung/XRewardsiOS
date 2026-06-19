import Foundation

/// Zero-state rewards data for signed-in users before live data loads or on fetch failure.
enum EmptyRewardsData {
    static func profile(memberID: String = "—") -> UserProfile {
        UserProfile(name: "Member", memberID: memberID, memberSince: .now)
    }

    static var dashboard: DashboardSummary {
        DashboardSummary(
            totalPoints: 0,
            pendingPoints: 0,
            estimatedMonthlyDividend: 0,
            rewardPoolPercentRange: 30...50,
            lastSettlementDate: nil,
            activeCategories: [],
            poolAmount: 0,
            totalPlatformPoints: 0
        )
    }

    static var team: TeamSummary {
        TeamSummary(directMembers: 0, totalDownline: 0, teamPoints: 0)
    }

    static var estimatedDividend: DividendPeriod {
        DividendPeriod(
            id: UUID(),
            month: .now,
            poolAmount: 0,
            totalPlatformPoints: 0,
            userPoints: 0,
            userShare: 0,
            payoutAmount: 0,
            status: .estimated
        )
    }
}
