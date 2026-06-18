import FirebaseFunctions
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
    private let functions = Functions.functions(region: "us-central1")

    private init() {}

    func submitReferral(
        category: RevenueCategory,
        inviteeName: String,
        inviteePhone: String,
        inviteeEmail: String
    ) async throws -> Int {
        let callable = functions.httpsCallable("submitReferral")
        let result = try await callable.call([
            "category": category.rawValue,
            "inviteeName": inviteeName,
            "inviteePhone": inviteePhone,
            "inviteeEmail": inviteeEmail,
        ])

        guard
            let data = result.data as? [String: Any],
            let success = data["success"] as? Bool,
            success,
            let points = data["pointsAwarded"] as? Int
        else {
            let message = (result.data as? [String: Any])?["message"] as? String
            throw ReferralServiceError.server(message ?? "Could not submit referral.")
        }

        return points
    }
}

enum ReferralServiceError: LocalizedError {
    case server(String)

    var errorDescription: String? {
        switch self {
        case .server(let message): message
        }
    }
}
