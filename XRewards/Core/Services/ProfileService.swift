import Foundation

@MainActor
final class ProfileService {
    static let shared = ProfileService()

    private init() {}

    func updateDisplayName(_ name: String) async throws -> String {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard trimmed.count >= 2 else {
            throw CallableSupportError.server(code: "INVALID_INPUT", message: "Enter a name with at least 2 characters.")
        }

        try await CallableSupport.ensureUserProfile()

        let data = try await CallableSupport.call(
            "updateProfile",
            data: ["displayName": trimmed]
        )
        return data["displayName"] as? String ?? trimmed
    }
}
