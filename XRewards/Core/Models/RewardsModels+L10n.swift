import Foundation

extension RevenueCategory {
    func displayName(for lang: AppUILanguage) -> String {
        switch self {
        case .insurance: return L10n.t("保险", "保險", "Insurance", "Seguros", lang: lang)
        case .loans: return L10n.t("贷款", "貸款", "Loans", "Préstamos", lang: lang)
        case .realEstate: return L10n.t("房产", "房產", "Real Estate", "Bienes raíces", lang: lang)
        case .appEcosystem: return L10n.t("应用生态", "應用生態", "App Ecosystem", "Ecosistema de apps", lang: lang)
        case .content: return L10n.t("内容创作", "內容創作", "Content Creation", "Creación de contenido", lang: lang)
        case .training: return L10n.t("培训活动", "培訓活動", "Training & Events", "Formación y eventos", lang: lang)
        }
    }

    func summary(for lang: AppUILanguage) -> String {
        switch self {
        case .insurance:
            return L10n.t(
                "推荐客户或完成保险销售可获得积分，成交奖励更高。",
                "推薦客戶或完成保險銷售可獲得積分，成交獎勵更高。",
                "Earn points by referring customers or closing insurance policies. Higher rewards for completed sales.",
                "Gana puntos recomendando clientes o cerrando pólizas de seguro. Mayores recompensas por ventas completadas.",
                lang: lang
            )
        case .loans:
            return L10n.t(
                "推荐贷款申请人或协助获批贷款产品，获得积分。",
                "推薦貸款申請人或協助獲批貸款產品，獲得積分。",
                "Refer loan applicants or assist with approved loan products to earn points.",
                "Recomienda solicitantes de préstamos o ayuda con productos aprobados para ganar puntos.",
                lang: lang
            )
        case .realEstate:
            return L10n.t(
                "通过您的推荐完成房产交易后，积分将记入账户。",
                "透過您的推薦完成房產交易後，積分將記入帳戶。",
                "Points are credited when property transactions close through your referral.",
                "Los puntos se acreditan cuando se cierran transacciones inmobiliarias por tu recomendación.",
                lang: lang
            )
        case .appEcosystem:
            return L10n.t(
                "推广合作应用——用户下载并付费订阅后可获积分。",
                "推廣合作應用——用戶下載並付費訂閱後可獲積分。",
                "Promote partner apps — earn when users download and convert to paid subscribers.",
                "Promociona apps asociadas: gana cuando los usuarios descarguen y se suscriban de pago.",
                lang: lang
            )
        case .content:
            return L10n.t(
                "创作并分享内容，带来有效线索与互动。",
                "創作並分享內容，帶來有效線索與互動。",
                "Create and share content that drives qualified leads and engagement.",
                "Crea y comparte contenido que genere clientes potenciales calificados e interacción.",
                lang: lang
            )
        case .training:
            return L10n.t(
                "参加工作坊或举办培训，提升技能并赚取积分。",
                "參加工作坊或舉辦培訓，提升技能並賺取積分。",
                "Attend workshops or host training sessions to grow skills and earn points.",
                "Asiste a talleres u organiza formaciones para mejorar tus habilidades y ganar puntos.",
                lang: lang
            )
        }
    }

    func actions(for lang: AppUILanguage) -> [(name: String, range: String)] {
        switch self {
        case .insurance:
            return [
                (L10n.t("保险线索", "保險線索", "Insurance Lead", "Cliente de seguros", lang: lang), "100 – 500"),
                (L10n.t("保险销售", "保險銷售", "Insurance Sale", "Venta de seguros", lang: lang), "500 – 5,000"),
            ]
        case .loans:
            return [
                (L10n.t("贷款线索", "貸款線索", "Loan Lead", "Cliente de préstamo", lang: lang), "200 – 1,000"),
                (L10n.t("贷款销售", "貸款銷售", "Loan Sale", "Venta de préstamo", lang: lang), "1,000 – 10,000"),
            ]
        case .realEstate:
            return [(L10n.t("房产销售", "房產銷售", "Property Sale", "Venta inmobiliaria", lang: lang), "2,000 – 20,000")]
        case .appEcosystem:
            return [
                (L10n.t("应用下载", "應用下載", "App Download", "Descarga de app", lang: lang), "5 – 20"),
                (L10n.t("付费转化", "付費轉化", "Paid Conversion", "Conversión de pago", lang: lang), "50 – 500"),
            ]
        case .content:
            return [
                (L10n.t("分享内容", "分享內容", "Share Content", "Compartir contenido", lang: lang), "50 – 200"),
                (L10n.t("有效线索", "有效線索", "Published Lead", "Cliente publicado", lang: lang), "200 – 1,000"),
            ]
        case .training:
            return [
                (L10n.t("参加活动", "參加活動", "Attend Event", "Asistir a evento", lang: lang), "100 – 1,000"),
                (L10n.t("举办培训", "舉辦培訓", "Host Training", "Organizar formación", lang: lang), "1,000 – 5,000"),
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
