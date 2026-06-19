import Foundation
import SwiftUI

enum AppUILanguage: String, CaseIterable {
    case zh
    case en

    static let storageKey = "xrewards.ui.language"
    static let `default`: AppUILanguage = .zh
}

extension String {
    var appLanguage: AppUILanguage {
        AppUILanguage(rawValue: self) ?? .default
    }
}

private struct AppLanguageKey: EnvironmentKey {
    static let defaultValue: AppUILanguage = .default
}

extension EnvironmentValues {
    var appLanguage: AppUILanguage {
        get { self[AppLanguageKey.self] }
        set { self[AppLanguageKey.self] = newValue }
    }
}

struct LanguageToggleButton: View {
    @AppStorage(AppUILanguage.storageKey) private var uiLanguage = AppUILanguage.default.rawValue

    private var lang: AppUILanguage { uiLanguage.appLanguage }
    /// NewStart-style: show the language you can switch *to*.
    private var toggleLabel: String { lang == .zh ? "En" : "中文" }

    var body: some View {
        Button(toggleLabel) {
            uiLanguage = (lang == .zh ? AppUILanguage.en.rawValue : AppUILanguage.zh.rawValue)
        }
        .font(.footnote.weight(.semibold))
        .foregroundStyle(Theme.accentGold)
    }
}

/// Shows the active UI language label (简体中文 / English).
struct CurrentLanguageLabel: View {
    @AppStorage(AppUILanguage.storageKey) private var uiLanguage = AppUILanguage.default.rawValue

    private var lang: AppUILanguage { uiLanguage.appLanguage }

    var body: some View {
        Text(lang == .zh ? L10n.languageChinese(lang: lang) : L10n.languageEnglish(lang: lang))
            .font(.subheadline)
            .foregroundStyle(Theme.textSecondary)
    }
}
