import AdventureServices
import AuthenticationServices
import SwiftUI

struct XRewardsAuthenticationView: View {
    @AppStorage(AppUILanguage.storageKey) private var uiLanguage = AppUILanguage.default.rawValue
    @StateObject private var authService = AuthenticationService.shared
    @State private var showingSignUp = false
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var guestError: String?
    @State private var isGuestLoading = false

    private var lang: AppUILanguage { uiLanguage.appLanguage }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    HStack {
                        Spacer()
                        LanguageToggleButton()
                    }

                    VStack(spacing: 12) {
                        if let logo = UIImage(named: "AppLogo") {
                            Image(uiImage: logo)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120, height: 120)
                        }

                        Text("XRewards")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(Theme.textPrimary)

                        Text(L10n.authTagline(lang: lang))
                            .font(.subheadline)
                            .foregroundStyle(Theme.textSecondary)
                            .multilineTextAlignment(.center)

                        Text(L10n.authPromo(lang: lang))
                            .font(.system(size: 18, weight: .black, design: .rounded))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.yellow, .white, .mint],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity)
                            .background(
                                LinearGradient(
                                    colors: [Color(red: 0.98, green: 0.34, blue: 0.40), Color(red: 0.98, green: 0.60, blue: 0.20)],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                    }
                    .padding(.top, 8)

                    Text(L10n.authGuestNotice(lang: lang))
                        .font(.footnote)
                        .foregroundStyle(Theme.textSecondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 4)

                    if showingSignUp {
                        signUpForm
                    } else {
                        signInForm
                    }

                    if let guestError {
                        Text(guestError)
                            .font(.footnote)
                            .foregroundStyle(.red)
                            .multilineTextAlignment(.center)
                    } else if let error = authService.errorMessage, !error.isEmpty {
                        Text(error)
                            .font(.footnote)
                            .foregroundStyle(.red)
                            .multilineTextAlignment(.center)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
            .screenBackground()
        }
    }

    private var signInForm: some View {
        VStack(spacing: 20) {
            authFields

            Button(L10n.forgotPassword(lang: lang)) {
                // Password reset handled via AdventureAuthUI in a future pass.
            }
            .font(.caption)
            .foregroundStyle(Theme.accentGold)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .opacity(0.6)

            primaryButton(title: L10n.signIn(lang: lang)) {
                Task { try? await authService.signIn(email: email, password: password) }
            }
            .disabled(authService.isLoading || isGuestLoading || email.isEmpty || password.isEmpty)

            divider

            socialButtons

            Button(L10n.noAccountSignUp(lang: lang)) {
                withAnimation { showingSignUp = true }
            }
            .font(.caption)
            .foregroundStyle(Theme.textSecondary)
        }
    }

    private var signUpForm: some View {
        VStack(spacing: 20) {
            authFields
            secureField(L10n.confirmPassword(lang: lang), text: $confirmPassword)

            primaryButton(title: L10n.signUp(lang: lang)) {
                Task { try? await authService.signUp(email: email, password: password) }
            }
            .disabled(authService.isLoading || isGuestLoading || email.isEmpty || password.isEmpty || password != confirmPassword)

            divider
            socialButtons

            Button(L10n.hasAccountSignIn(lang: lang)) {
                withAnimation { showingSignUp = false }
            }
            .font(.caption)
            .foregroundStyle(Theme.textSecondary)
        }
    }

    private var authFields: some View {
        VStack(spacing: 12) {
            textField(L10n.email(lang: lang), text: $email, keyboard: .emailAddress)
            secureField(L10n.password(lang: lang), text: $password)
        }
    }

    private var divider: some View {
        HStack {
            Rectangle().fill(Theme.textSecondary.opacity(0.3)).frame(height: 1)
            Text(L10n.orDivider(lang: lang)).font(.caption).foregroundStyle(Theme.textSecondary)
            Rectangle().fill(Theme.textSecondary.opacity(0.3)).frame(height: 1)
        }
    }

    private var socialButtons: some View {
        VStack(spacing: 12) {
            Button {
                Task { try? await authService.signInWithGoogle() }
            } label: {
                Text(L10n.continueWithGoogle(lang: lang))
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            .disabled(authService.isLoading || isGuestLoading)

            SignInWithAppleButton(
                onRequest: { request in
                    request.requestedScopes = [.fullName, .email]
                    request.nonce = authService.getAppleSignInNonce()
                },
                onCompletion: { result in
                    guard case .success(let authorization) = result,
                          let credential = authorization.credential as? ASAuthorizationAppleIDCredential else {
                        return
                    }
                    Task { try? await authService.signInWithApple(authorization: credential) }
                }
            )
            .signInWithAppleButtonStyle(.white)
            .frame(height: 50)
            .disabled(authService.isLoading || isGuestLoading)

            Button {
                Task { await continueAsGuest() }
            } label: {
                if authService.isLoading || isGuestLoading {
                    ProgressView().frame(maxWidth: .infinity)
                } else {
                    Text(L10n.continueAsGuest(lang: lang)).frame(maxWidth: .infinity)
                }
            }
            .buttonStyle(.bordered)
            .disabled(authService.isLoading || isGuestLoading)
        }
    }

    private func textField(_ placeholder: String, text: Binding<String>, keyboard: UIKeyboardType = .default) -> some View {
        TextField(placeholder, text: text)
            .textInputAutocapitalization(keyboard == .emailAddress ? .never : .words)
            .keyboardType(keyboard)
            .autocorrectionDisabled()
            .padding()
            .background(Theme.backgroundCard)
            .clipShape(RoundedRectangle(cornerRadius: Theme.tileCornerRadius))
            .foregroundStyle(Theme.textPrimary)
    }

    private func secureField(_ placeholder: String, text: Binding<String>) -> some View {
        SecureField(placeholder, text: text)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .padding()
            .background(Theme.backgroundCard)
            .clipShape(RoundedRectangle(cornerRadius: Theme.tileCornerRadius))
            .foregroundStyle(Theme.textPrimary)
    }

    private func primaryButton(title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            if authService.isLoading {
                ProgressView().frame(maxWidth: .infinity)
            } else {
                Text(title).frame(maxWidth: .infinity)
            }
        }
        .buttonStyle(.borderedProminent)
        .tint(Theme.accentGold)
    }

    private func continueAsGuest() async {
        guestError = nil
        isGuestLoading = true
        defer { isGuestLoading = false }

        let ok = await withTaskGroup(of: Bool.self) { group in
            group.addTask { await XRewardsGuestAuth.continueAsGuest() }
            group.addTask {
                try? await Task.sleep(nanoseconds: 20_000_000_000)
                return false
            }
            let first = await group.next() ?? false
            group.cancelAll()
            return first
        }

        if !ok {
            guestError = L10n.guestSignInFailed(lang: lang)
        } else {
            XRewardsSession.shared.refresh()
        }
    }
}

#Preview {
    XRewardsAuthenticationView()
        .environment(\.appLanguage, .zh)
}
