import SwiftUI
import WebKit

enum PrivacyPolicyStorage {
    static let acceptedKey = "xrewards.privacy.accepted"

    static var hasAccepted: Bool {
        UserDefaults.standard.bool(forKey: acceptedKey)
    }

    static func markAccepted() {
        UserDefaults.standard.set(true, forKey: acceptedKey)
        UserDefaults.standard.set(Date(), forKey: "xrewards.privacy.acceptedAt")
    }
}

/// First-launch consent gate — user must scroll to the bottom before agreeing.
struct XRewardsPrivacyConsentView: View {
    @AppStorage(AppUILanguage.storageKey) private var uiLanguage = AppUILanguage.default.rawValue
    @State private var canAgree = false

    let onAgree: () -> Void

    private var lang: AppUILanguage { uiLanguage.appLanguage }

    var body: some View {
        VStack(spacing: 0) {
            header
            Divider().overlay(Theme.textSecondary.opacity(0.2))

            PrivacyPolicyWebView(lang: lang) {
                canAgree = true
            }

            Divider().overlay(Theme.textSecondary.opacity(0.2))
            footer
        }
        .screenBackground()
        .interactiveDismissDisabled(true)
    }

    private var header: some View {
        VStack(spacing: 10) {
            HStack {
                Spacer()
                LanguageToggleButton()
            }
            Text(L10n.privacyPolicy(lang: lang))
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(Theme.textPrimary)
            Text(L10n.privacyPolicyAgreePrompt(lang: lang))
                .font(.footnote)
                .foregroundStyle(Theme.textSecondary)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
    }

    private var footer: some View {
        VStack(spacing: 10) {
            PrimaryButton(title: L10n.privacyPolicyAgree(lang: lang)) {
                PrivacyPolicyStorage.markAccepted()
                onAgree()
            }
            .disabled(!canAgree)
            .opacity(canAgree ? 1 : 0.5)

            if !canAgree {
                Text(L10n.privacyPolicyScrollHint(lang: lang))
                    .font(.caption)
                    .foregroundStyle(Theme.textSecondary)
                    .multilineTextAlignment(.center)
            }
        }
        .padding(20)
    }
}

/// Read-only policy viewer (e.g. from Profile).
struct XRewardsPrivacyPolicyReadView: View {
    @AppStorage(AppUILanguage.storageKey) private var uiLanguage = AppUILanguage.default.rawValue

    private var lang: AppUILanguage { uiLanguage.appLanguage }

    var body: some View {
        PrivacyPolicyWebView(lang: lang, requireScroll: false)
            .screenBackground()
            .navigationTitle(L10n.privacyPolicy(lang: lang))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    LanguageToggleButton()
                }
            }
    }
}

private struct PrivacyPolicyWebView: View {
    let lang: AppUILanguage
    var requireScroll: Bool = true
    var onScrollToBottom: (() -> Void)?

    init(lang: AppUILanguage, requireScroll: Bool = true, onScrollToBottom: (() -> Void)? = nil) {
        self.lang = lang
        self.requireScroll = requireScroll
        self.onScrollToBottom = onScrollToBottom
    }

    var body: some View {
        Group {
            if let url = policyURL {
                PolicyHTMLWebView(url: url, requireScroll: requireScroll, onScrollToBottom: onScrollToBottom)
            } else {
                Text(L10n.privacyPolicyLoadFailed(lang: lang))
                    .foregroundStyle(Theme.textSecondary)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }

    private var policyURL: URL? {
        let name: String
        switch lang {
        case .zh: name = "privacy-policy"
        case .zhHant: name = "privacy-policy-zh-hant"
        case .en: name = "privacy-policy-en"
        case .es: name = "privacy-policy-es"
        }
        for sub in ["PrivacyPolicy", "Resources/PrivacyPolicy", nil] {
            if let url = Bundle.main.url(forResource: name, withExtension: "html", subdirectory: sub) {
                return url
            }
        }
        return nil
    }
}

private struct PolicyHTMLWebView: UIViewRepresentable {
    let url: URL
    let requireScroll: Bool
    var onScrollToBottom: (() -> Void)?

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.isOpaque = false
        webView.backgroundColor = .clear
        webView.scrollView.delegate = context.coordinator
        context.coordinator.webView = webView
        webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        if context.coordinator.loadedURL != url {
            context.coordinator.loadedURL = url
            context.coordinator.hasNotified = false
            webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(requireScroll: requireScroll, onScrollToBottom: onScrollToBottom)
    }

    final class Coordinator: NSObject, UIScrollViewDelegate {
        let requireScroll: Bool
        var onScrollToBottom: (() -> Void)?
        weak var webView: WKWebView?
        var hasNotified = false
        var loadedURL: URL?

        init(requireScroll: Bool, onScrollToBottom: (() -> Void)?) {
            self.requireScroll = requireScroll
            self.onScrollToBottom = onScrollToBottom
        }

        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            guard requireScroll, !hasNotified else { return }
            let offset = scrollView.contentOffset.y
            guard offset >= 100 else { return }
            let visibleBottom = offset + scrollView.frame.size.height
            if visibleBottom >= scrollView.contentSize.height - 100 {
                hasNotified = true
                DispatchQueue.main.async { self.onScrollToBottom?() }
            }
        }
    }
}
