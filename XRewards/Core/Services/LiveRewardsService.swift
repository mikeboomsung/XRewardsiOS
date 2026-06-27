import Foundation

@MainActor
final class LiveRewardsService: RewardsService {
    func fetchProfile() async -> UserProfile {
        await loadPayload()?.profile ?? EmptyRewardsData.profile()
    }

    func fetchDashboard() async -> DashboardSummary {
        await loadPayload()?.dashboard ?? EmptyRewardsData.dashboard
    }

    func fetchTransactions() async -> [PointTransaction] {
        await loadPayload()?.transactions ?? []
    }

    func fetchDividends() async -> [DividendPeriod] {
        await loadPayload()?.dividends ?? []
    }

    func fetchCurrentDividend() async -> DividendPeriod {
        await loadPayload()?.currentDividend ?? EmptyRewardsData.estimatedDividend
    }

    func fetchReferrals() async -> [ReferralRecord] {
        await loadPayload()?.referrals ?? []
    }

    private struct Payload {
        let profile: UserProfile
        let dashboard: DashboardSummary
        let transactions: [PointTransaction]
        let dividends: [DividendPeriod]
        let currentDividend: DividendPeriod?
        let referrals: [ReferralRecord]
    }

    private var cachedPayload: Payload?
    private var loadingPayloadTask: Task<Payload?, Never>?

    func refresh() async {
        cachedPayload = await loadPayload(force: true)
    }

    private func loadPayload(force: Bool = false) async -> Payload? {
        if !force, let cachedPayload { return cachedPayload }
        if !force, let loadingPayloadTask {
            return await loadingPayloadTask.value
        }

        let task = Task { @MainActor [self] in
            await fetchPayload()
        }
        loadingPayloadTask = task
        let payload = await task.value
        loadingPayloadTask = nil
        return payload
    }

    private func fetchPayload() async -> Payload? {
        do {
            let root = try await CallableSupport.call("getRewardsData")
            let payload = decodePayload(root)
            cachedPayload = payload
            return payload
        } catch let error as CallableSupportError {
            if case .server(let code, _) = error, code == "NOT_FOUND" {
                try? await CallableSupport.ensureUserProfile()
                if let root = try? await CallableSupport.call("getRewardsData") {
                    let payload = decodePayload(root)
                    cachedPayload = payload
                    return payload
                }
            }
            return nil
        } catch {
            return nil
        }
    }

    private func decodePayload(_ root: [String: Any]) -> Payload {
        Payload(
            profile: decodeProfile(root["profile"] as? [String: Any]),
            dashboard: decodeDashboard(root["dashboard"] as? [String: Any]),
            transactions: decodeTransactions(root["transactions"] as? [[String: Any]]),
            dividends: decodeDividends(root["dividends"] as? [[String: Any]]),
            currentDividend: decodeDividend(root["currentDividend"] as? [String: Any]),
            referrals: decodeReferrals(root["referrals"] as? [[String: Any]])
        )
    }

    private func decodeProfile(_ data: [String: Any]?) -> UserProfile {
        UserProfile(
            name: data?["name"] as? String ?? "Member",
            memberID: data?["memberID"] as? String ?? "—",
            memberSince: parseDate(data?["memberSince"] as? String) ?? .now
        )
    }

    private func decodeDashboard(_ data: [String: Any]?) -> DashboardSummary {
        let range = data?["rewardPoolPercentRange"] as? [Int] ?? [30, 50]
        let lower = range.first ?? 30
        let upper = range.count > 1 ? range[1] : 50
        let categories = (data?["activeCategories"] as? [String] ?? [])
            .compactMap(RevenueCategory.init(rawValue:))

        return DashboardSummary(
            totalPoints: data?["totalPoints"] as? Int ?? 0,
            pendingPoints: data?["pendingPoints"] as? Int ?? 0,
            estimatedMonthlyDividend: decimal(data?["estimatedMonthlyDividend"]),
            rewardPoolPercentRange: lower...upper,
            lastSettlementDate: parseDate(data?["lastSettlementDate"] as? String),
            activeCategories: categories,
            poolAmount: decimal(data?["poolAmount"]),
            totalPlatformPoints: data?["totalPlatformPoints"] as? Int ?? 0
        )
    }

    private func decodeTransactions(_ items: [[String: Any]]?) -> [PointTransaction] {
        (items ?? []).map { item in
            PointTransaction(
                id: UUID(uuidString: item["id"] as? String ?? "") ?? UUID(),
                category: RevenueCategory(rawValue: item["category"] as? String ?? "") ?? .insurance,
                action: item["action"] as? String ?? "Activity",
                points: item["points"] as? Int ?? 0,
                status: TransactionStatus(rawValue: item["status"] as? String ?? "") ?? .pending,
                createdAt: parseDate(item["createdAt"] as? String) ?? .now,
                confirmedAt: parseDate(item["confirmedAt"] as? String)
            )
        }
    }

    private func decodeDividends(_ items: [[String: Any]]?) -> [DividendPeriod] {
        (items ?? []).compactMap(decodeDividend)
    }

    private func decodeDividend(_ item: [String: Any]?) -> DividendPeriod? {
        guard let item else { return nil }
        return DividendPeriod(
            id: UUID(uuidString: item["id"] as? String ?? "") ?? UUID(),
            month: parseDate(item["month"] as? String) ?? .now,
            poolAmount: decimal(item["poolAmount"]),
            totalPlatformPoints: item["totalPlatformPoints"] as? Int ?? 0,
            userPoints: item["userPoints"] as? Int ?? 0,
            userShare: decimal(item["userShare"]),
            payoutAmount: decimal(item["payoutAmount"]),
            status: DividendStatus(rawValue: item["status"] as? String ?? "") ?? .estimated
        )
    }

    private func decodeReferrals(_ items: [[String: Any]]?) -> [ReferralRecord] {
        (items ?? []).map { item in
            ReferralRecord(
                id: item["id"] as? String ?? UUID().uuidString,
                inviteeName: item["inviteeName"] as? String ?? "",
                inviteePhone: item["inviteePhone"] as? String ?? "",
                inviteeEmail: item["inviteeEmail"] as? String ?? "",
                category: RevenueCategory(rawValue: item["category"] as? String ?? "") ?? .insurance,
                pointsAwarded: item["pointsAwarded"] as? Int ?? 0,
                status: TransactionStatus(rawValue: item["status"] as? String ?? "") ?? .pending,
                createdAt: parseDate(item["createdAt"] as? String) ?? .now
            )
        }
    }

    private func parseDate(_ value: String?) -> Date? {
        guard let value else { return nil }
        return ISO8601DateFormatter().date(from: value)
    }

    private func decimal(_ value: Any?) -> Decimal {
        if let number = value as? NSNumber { return number.decimalValue }
        if let double = value as? Double { return Decimal(double) }
        if let int = value as? Int { return Decimal(int) }
        return 0
    }
}
