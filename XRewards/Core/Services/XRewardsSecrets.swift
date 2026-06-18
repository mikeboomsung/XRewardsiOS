import AdventureSupport
import Foundation

/// XRewards runtime configuration — production app identity for shared Adventure packages.
enum XRewardsSecrets {
    private static let provider = XRewardsSecretsProvider()

    static func configure() {
        EnvironmentSecrets.configure(with: provider)
    }
}

private final class XRewardsSecretsProvider: SecureSecretsProviderProtocol {
    func getSecret(_ key: String) -> String? {
        switch key {
        case "APP_ID":
            return "xrewards"
        case "ENV":
            return "prod"
        default:
            return nil
        }
    }

    func setSecret(_ key: String, value: String) {
        // XRewards uses fixed production identity; no mutable local secrets.
    }
}
