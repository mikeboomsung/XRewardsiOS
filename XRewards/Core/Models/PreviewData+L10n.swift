import Foundation

extension PreviewData {
    static func pillars(for lang: AppUILanguage) -> [ValuePillar] {
        [
            ValuePillar(
                title: L10n.t("赚钱", "Make Money", lang: lang),
                subtitle: L10n.t("每次行动都有可见收入", "Visible income from every action", lang: lang),
                icon: "dollarsign.circle.fill"
            ),
            ValuePillar(
                title: L10n.t("持续赚取", "Continuous Earning", lang: lang),
                subtitle: L10n.t("被动收入持续增长", "Passive income that keeps growing", lang: lang),
                icon: "chart.line.uptrend.xyaxis"
            ),
            ValuePillar(
                title: L10n.t("安全公平", "Security & Fairness", lang: lang),
                subtitle: L10n.t("透明规则与奖励池", "Transparent rules and reward pool", lang: lang),
                icon: "shield.checkered"
            ),
            ValuePillar(
                title: L10n.t("归属感", "Belonging", lang: lang),
                subtitle: L10n.t("与团队共同成长", "Grow together with your team", lang: lang),
                icon: "person.3.fill"
            ),
            ValuePillar(
                title: L10n.t("成长", "Growth", lang: lang),
                subtitle: L10n.t("培训与活动助力提升", "Training and events to level up", lang: lang),
                icon: "arrow.up.forward.circle.fill"
            ),
        ]
    }

    static func workflowSteps(for lang: AppUILanguage) -> [WorkflowStep] {
        [
            WorkflowStep(
                id: 1,
                title: L10n.t("行动", "Act", lang: lang),
                description: L10n.t(
                    "推荐客户或创造价值——一次行动，永久绑定。",
                    "Recommend a customer or create value — one action, permanent binding.",
                    lang: lang
                ),
                icon: "hand.tap.fill"
            ),
            WorkflowStep(
                id: 2,
                title: L10n.t("确认", "Confirm", lang: lang),
                description: L10n.t(
                    "交易核实后，积分永久记入您的账户。",
                    "Transaction verified; points credited permanently to your account.",
                    lang: lang
                ),
                icon: "checkmark.seal.fill"
            ),
            WorkflowStep(
                id: 3,
                title: L10n.t("奖池", "Pool", lang: lang),
                description: L10n.t(
                    "平台利润流入月度奖励池。",
                    "Platform profit flows into the monthly reward pool.",
                    lang: lang
                ),
                icon: "drop.fill"
            ),
            WorkflowStep(
                id: 4,
                title: L10n.t("分红", "Dividend", lang: lang),
                description: L10n.t(
                    "根据您的积分占比，每月发放 payout。",
                    "Monthly payout based on your share of total points.",
                    lang: lang
                ),
                icon: "banknote.fill"
            ),
            WorkflowStep(
                id: 5,
                title: L10n.t("持续", "Sustain", lang: lang),
                description: L10n.t(
                    "积分永不过期——收入随时间持续。",
                    "Points never expire — income continues over time.",
                    lang: lang
                ),
                icon: "infinity"
            ),
        ]
    }
}
