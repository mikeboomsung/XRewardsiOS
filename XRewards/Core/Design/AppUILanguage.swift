import Foundation
import SwiftUI

enum AppUILanguage: String, CaseIterable, Identifiable {
    case zh
    case zhHant = "zh-Hant"
    case en
    case es

    var id: String { rawValue }

    static let storageKey = "xrewards.ui.language"
    static let `default`: AppUILanguage = .zh

    /// Native name shown in the language picker.
    var nativeName: String {
        switch self {
        case .zh: "简体中文"
        case .zhHant: "繁體中文"
        case .en: "English"
        case .es: "Español"
        }
    }
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

struct LanguagePickerMenu: View {
    @AppStorage(AppUILanguage.storageKey) private var uiLanguage = AppUILanguage.default.rawValue

    private var lang: AppUILanguage { uiLanguage.appLanguage }

    var body: some View {
        Menu {
            ForEach(AppUILanguage.allCases) { option in
                Button {
                    uiLanguage = option.rawValue
                } label: {
                    if option == lang {
                        Label(option.nativeName, systemImage: "checkmark")
                    } else {
                        Text(option.nativeName)
                    }
                }
            }
        } label: {
            HStack(spacing: 4) {
                Image(systemName: "globe")
                Text(lang.nativeName)
                    .font(.footnote.weight(.semibold))
            }
            .foregroundStyle(Theme.accentGold)
        }
    }
}

/// Compact globe menu for toolbars (auth, privacy).
struct LanguageToggleButton: View {
    var body: some View {
        LanguagePickerMenu()
    }
}

/// Shows the active UI language label in settings rows.
struct CurrentLanguageLabel: View {
    @AppStorage(AppUILanguage.storageKey) private var uiLanguage = AppUILanguage.default.rawValue

    private var lang: AppUILanguage { uiLanguage.appLanguage }

    var body: some View {
        Text(lang.nativeName)
            .font(.subheadline)
            .foregroundStyle(Theme.textSecondary)
    }
}
