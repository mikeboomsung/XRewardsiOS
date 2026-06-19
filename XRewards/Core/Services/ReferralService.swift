import Foundation

struct ReferralRecord: Identifiable, Hashable {
    let id: String
    let inviteeName: String
    let inviteePhone: String
    let inviteeEmail: String
    let category: RevenueCategory
    let pointsAwarded: Int
    let status: TransactionStatus
    let createdAt: Date
}

@MainActor
final class ReferralService {
    static let shared = ReferralService()

    private init() {}

    func submitReferral(
        category: RevenueCategory,
        inviteeName: String,
        inviteePhone: String,
        inviteeEmail: String
    ) async throws -> Int {
        try await CallableSupport.ensureUserProfile()

        let data = try await CallableSupport.call(
            "submitReferral",
            data: [
                "category": category.rawValue,
                "inviteeName": inviteeName,
                "inviteePhone": inviteePhone,
                "inviteeEmail": inviteeEmail,
            ]
        )

        guard let points = data["pointsAwarded"] as? Int else {
            throw CallableSupportError.server(code: "INVALID_RESPONSE", message: "Could not submit referral.")
        }

        return points
    }
}
