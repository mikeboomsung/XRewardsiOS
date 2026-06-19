import SwiftUI

struct ReferralSubmissionView: View {
    let category: RevenueCategory
    let onSubmitted: () -> Void

    @Environment(\.appLanguage) private var lang
    @Environment(\.dismiss) private var dismiss
    @State private var inviteeName = ""
    @State private var inviteePhone = ""
    @State private var inviteeEmail = ""
    @State private var isSubmitting = false
    @State private var errorMessage: String?
    @State private var didSucceed = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: Theme.cardSpacing) {
                    Text(L10n.submitReferralIntro(lang: lang))
                        .font(.subheadline)
                        .foregroundStyle(Theme.textSecondary)

                    VStack(spacing: 12) {
                        referralField(L10n.fullName(lang: lang), text: $inviteeName, keyboard: .default)
                        referralField(L10n.phoneNumber(lang: lang), text: $inviteePhone, keyboard: .phonePad)
                        referralField(L10n.emailAddress(lang: lang), text: $inviteeEmail, keyboard: .emailAddress)
                    }

                    if let errorMessage {
                        Text(errorMessage)
                            .font(.caption)
                            .foregroundStyle(.red)
                    }

                    if didSucceed {
                        Label(L10n.referralSuccess(lang: lang), systemImage: "checkmark.circle.fill")
                            .font(.subheadline)
                            .foregroundStyle(Theme.success)
                    }

                    PrimaryButton(title: L10n.submitReferral(lang: lang)) {
                        Task { await submit() }
                    }
                    .disabled(isSubmitting || !isFormValid)
                    .opacity(isSubmitting || !isFormValid ? 0.6 : 1)
                }
                .padding(Theme.horizontalPadding)
            }
            .screenBackground()
            .navigationTitle(L10n.referCategory(category.displayName(for: lang), lang: lang))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(L10n.close(lang: lang)) { dismiss() }
                        .foregroundStyle(Theme.accentGold)
                }
            }
        }
    }

    private var isFormValid: Bool {
        inviteeName.trimmingCharacters(in: .whitespacesAndNewlines).count >= 2
            && inviteePhone.filter(\.isNumber).count >= 7
            && inviteeEmail.contains("@")
    }

    private func referralField(
        _ title: String,
        text: Binding<String>,
        keyboard: UIKeyboardType
    ) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.caption)
                .foregroundStyle(Theme.textSecondary)
            TextField(title, text: text)
                .textInputAutocapitalization(keyboard == .emailAddress ? .never : .words)
                .keyboardType(keyboard)
                .autocorrectionDisabled(keyboard == .emailAddress)
                .padding()
                .background(Theme.backgroundCard)
                .clipShape(RoundedRectangle(cornerRadius: Theme.tileCornerRadius))
                .foregroundStyle(Theme.textPrimary)
        }
    }

    private func submit() async {
        isSubmitting = true
        errorMessage = nil
        defer { isSubmitting = false }

        do {
            _ = try await ReferralService.shared.submitReferral(
                category: category,
                inviteeName: inviteeName.trimmingCharacters(in: .whitespacesAndNewlines),
                inviteePhone: inviteePhone,
                inviteeEmail: inviteeEmail.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
            )
            didSucceed = true
            onSubmitted()
            try? await Task.sleep(for: .milliseconds(900))
            dismiss()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

#Preview {
    ReferralSubmissionView(category: .insurance) {}
        .environment(\.appLanguage, .zh)
}
