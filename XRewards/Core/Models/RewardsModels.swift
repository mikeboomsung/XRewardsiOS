import Foundation
import SwiftUI

enum RevenueCategory: String, CaseIterable, Identifiable, Codable, Hashable {
    case insurance
    case loans
    case realEstate
    case appEcosystem
    case content
    case training

    var id: String { rawValue }

    var displayName: LocalizedStringResource {
        switch self {
        case .insurance: "Insurance"
        case .loans: "Loans"
        case .realEstate: "Real Estate"
        case .appEcosystem: "App Ecosystem"
        case .content: "Content Creation"
        case .training: "Training & Events"
        }
    }

    var icon: String {
        switch self {
        case .insurance: "umbrella.fill"
        case .loans: "building.columns.fill"
        case .realEstate: "house.fill"
        case .appEcosystem: "apps.iphone"
        case .content: "square.and.pencil"
        case .training: "person.3.fill"
        }
    }

    var pointRangeLabel: String {
        switch self {
        case .insurance: "100 – 5,000"
        case .loans: "200 – 10,000"
        case .realEstate: "2,000 – 20,000"
        case .appEcosystem: "5 – 500"
        case .content: "50 – 1,000"
        case .training: "100 – 5,000"
        }
    }

    var summary: LocalizedStringResource {
        switch self {
        case .insurance:
            "Earn points by referring customers or closing insurance policies. Higher rewards for completed sales."
        case .loans:
            "Refer loan applicants or assist with approved loan products to earn permanent points."
        case .realEstate:
            "Points are credited when property transactions close through your referral."
        case .appEcosystem:
            "Promote partner apps — earn when users download and convert to paid subscribers."
        case .content:
            "Create and share content that drives qualified leads and engagement."
        case .training:
            "Attend workshops or host training sessions to grow skills and earn points."
        }
    }

    var actions: [CategoryAction] {
        switch self {
        case .insurance:
            return [
                CategoryAction(name: "Insurance Referral", pointRange: "100 – 500"),
                CategoryAction(name: "Insurance Sale", pointRange: "500 – 5,000")
            ]
        case .loans:
            return [
                CategoryAction(name: "Loan Referral", pointRange: "200 – 1,000"),
                CategoryAction(name: "Loan Sale", pointRange: "1,000 – 10,000")
            ]
        case .realEstate:
            return [
                CategoryAction(name: "Property Sale", pointRange: "2,000 – 20,000")
            ]
        case .appEcosystem:
            return [
                CategoryAction(name: "App Download", pointRange: "5 – 20"),
                CategoryAction(name: "Paid Conversion", pointRange: "50 – 500")
            ]
        case .content:
            return [
                CategoryAction(name: "Share Content", pointRange: "50 – 200"),
                CategoryAction(name: "Published Lead", pointRange: "200 – 1,000")
            ]
        case .training:
            return [
                CategoryAction(name: "Attend Event", pointRange: "100 – 1,000"),
                CategoryAction(name: "Host Training", pointRange: "1,000 – 5,000")
            ]
        }
    }
}

struct CategoryAction: Identifiable {
    let id = UUID()
    let name: LocalizedStringResource
    let pointRange: String
}

enum TransactionStatus: String, Codable {
    case pending
    case confirmed
    case rejected

    var displayName: LocalizedStringResource {
        switch self {
        case .pending: "Pending"
        case .confirmed: "Confirmed"
        case .rejected: "Rejected"
        }
    }

    var color: Color {
        switch self {
        case .pending: Theme.pending
        case .confirmed: Theme.success
        case .rejected: Color.red.opacity(0.8)
        }
    }
}

enum DividendStatus: String, Codable {
    case estimated
    case processing
    case paid

    var displayName: LocalizedStringResource {
        switch self {
        case .estimated: "Estimated"
        case .processing: "Processing"
        case .paid: "Paid"
        }
    }
}

struct PointTransaction: Identifiable {
    let id: UUID
    let category: RevenueCategory
    let action: String
    let points: Int
    let status: TransactionStatus
    let createdAt: Date
    let confirmedAt: Date?
}

struct DividendPeriod: Identifiable {
    let id: UUID
    let month: Date
    let poolAmount: Decimal
    let totalPlatformPoints: Int
    let userPoints: Int
    let userShare: Decimal
    let payoutAmount: Decimal
    let status: DividendStatus
}

struct DashboardSummary {
    let totalPoints: Int
    let pendingPoints: Int
    let estimatedMonthlyDividend: Decimal
    let rewardPoolPercentRange: ClosedRange<Int>
    let lastSettlementDate: Date?
    let activeCategories: [RevenueCategory]
    let poolAmount: Decimal
    let totalPlatformPoints: Int
}

struct TeamSummary {
    let directMembers: Int
    let totalDownline: Int
    let teamPoints: Int
}

struct UserProfile {
    let name: String
    let memberID: String
    let memberSince: Date
}

struct ValuePillar: Identifiable {
    let id = UUID()
    let title: LocalizedStringResource
    let subtitle: LocalizedStringResource
    let icon: String
}

struct WorkflowStep: Identifiable {
    let id: Int
    let title: LocalizedStringResource
    let description: LocalizedStringResource
    let icon: String
}

enum PreviewData {
    static let pillars: [ValuePillar] = [
        ValuePillar(title: "Make Money", subtitle: "Visible income from every action", icon: "dollarsign.circle.fill"),
        ValuePillar(title: "Continuous Earning", subtitle: "Passive income that keeps growing", icon: "chart.line.uptrend.xyaxis"),
        ValuePillar(title: "Security & Fairness", subtitle: "Transparent rules and reward pool", icon: "shield.checkered"),
        ValuePillar(title: "Belonging", subtitle: "Grow together with your team", icon: "person.3.fill"),
        ValuePillar(title: "Growth", subtitle: "Training and events to level up", icon: "arrow.up.forward.circle.fill")
    ]

    static let workflowSteps: [WorkflowStep] = [
        WorkflowStep(id: 1, title: "Act", description: "Recommend a customer or create value — one action, permanent binding.", icon: "hand.tap.fill"),
        WorkflowStep(id: 2, title: "Confirm", description: "Transaction verified; points credited permanently to your account.", icon: "checkmark.seal.fill"),
        WorkflowStep(id: 3, title: "Pool", description: "Platform profit flows into the monthly reward pool.", icon: "drop.fill"),
        WorkflowStep(id: 4, title: "Dividend", description: "Monthly payout based on your share of total points.", icon: "banknote.fill"),
        WorkflowStep(id: 5, title: "Sustain", description: "Points never expire — income continues over time.", icon: "infinity")
    ]
}
