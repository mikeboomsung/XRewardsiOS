import Foundation

actor UserProfileEnsureGate {
    static let shared = UserProfileEnsureGate()
    private var inFlight: Task<Void, Error>?

    func ensure(_ operation: @Sendable @escaping () async throws -> Void) async throws {
        if let inFlight {
            try await inFlight.value
            return
        }

        let task = Task {
            try await operation()
        }
        inFlight = task
        defer { inFlight = nil }
        try await task.value
    }
}
