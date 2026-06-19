import Foundation

extension RevenueCategory {
    func displayName(for lang: AppUILanguage) -> String {
        switch self {
        case .insurance: return L10n.t("保险", "Insurance", lang: lang)
        case .loans: return L10n.t("贷款", "Loans", lang: lang)
        case .realEstate: return L10n.t("房产", "Real Estate", lang: lang)
        case .appEcosystem: return L10n.t("应用生态", "App Ecosystem", lang: lang)
        case .content: return L10n.t("内容创作", "Content Creation", lang: lang)
        case .training: return L10n.t("培训活动", "Training & Events", lang: lang)
        }
    }

    func summary(for lang: AppUILanguage) -> String {
        switch self {
        case .insurance:
            return L10n.t(
                "推荐客户或完成保险销售可获得积分，成交奖励更高。",
                "Earn points by referring customers or closing insurance policies. Higher rewards for completed sales.",
                lang: lang
            )
        case .loans:
            return L10n.t(
                "推荐贷款申请人或协助获批贷款产品，获得永久积分。",
                "Refer loan applicants or assist with approved loan products to earn permanent points.",
                lang: lang
            )
        case .realEstate:
            return L10n.t(
                "通过您的推荐完成房产交易后，积分将记入账户。",
                "Points are credited when property transactions close through your referral.",
                lang: lang
            )
        case .appEcosystem:
            return L10n.t(
                "推广合作应用——用户下载并付费订阅后可获积分。",
                "Promote partner apps — earn when users download and convert to paid subscribers.",
                lang: lang
            )
        case .content:
            return L10n.t(
                "创作并分享内容，带来有效线索与互动。",
                "Create and share content that drives qualified leads and engagement.",
                lang: lang
            )
        case .training:
            return L10n.t(
                "参加工作坊或举办培训，提升技能并赚取积分。",
                "Attend workshops or host training sessions to grow skills and earn points.",
                lang: lang
            )
        }
    }

    func actions(for lang: AppUILanguage) -> [(name: String, range: String)] {
        switch self {
        case .insurance:
            return [
                (L10n.t("保险推荐", "Insurance Referral", lang: lang), "100 – 500"),
                (L10n.t("保险销售", "Insurance Sale", lang: lang), "500 – 5,000"),
            ]
        case .loans:
            return [
                (L10n.t("贷款推荐", "Loan Referral", lang: lang), "200 – 1,000"),
                (L10n.t("贷款销售", "Loan Sale", lang: lang), "1,000 – 10,000"),
            ]
        case .realEstate:
            return [(L10n.t("房产销售", "Property Sale", lang: lang), "2,000 – 20,000")]
        case .appEcosystem:
            return [
                (L10n.t("应用下载", "App Download", lang: lang), "5 – 20"),
                (L10n.t("付费转化", "Paid Conversion", lang: lang), "50 – 500"),
            ]
        case .content:
            return [
                (L10n.t("分享内容", "Share Content", lang: lang), "50 – 200"),
                (L10n.t("有效线索", "Published Lead", lang: lang), "200 – 1,000"),
            ]
        case .training:
            return [
                (L10n.t("参加活动", "Attend Event", lang: lang), "100 – 1,000"),
                (L10n.t("举办培训", "Host Training", lang: lang), "1,000 – 5,000"),
            ]
        }
    }
}

extension TransactionStatus {
    func displayName(for lang: AppUILanguage) -> String {
        switch self {
        case .pending: return L10n.statusPending(lang: lang)
        case .confirmed: return L10n.statusConfirmed(lang: lang)
        case .rejected: return L10n.statusRejected(lang: lang)
        }
    }
}

extension DividendStatus {
    func displayName(for lang: AppUILanguage) -> String {
        switch self {
        case .estimated: return L10n.statusEstimated(lang: lang)
        case .processing: return L10n.statusProcessing(lang: lang)
        case .paid: return L10n.statusPaid(lang: lang)
        }
    }
}
