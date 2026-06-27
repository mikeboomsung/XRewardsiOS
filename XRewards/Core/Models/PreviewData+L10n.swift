import Foundation

extension PreviewData {
    static func pillars(for lang: AppUILanguage) -> [ValuePillar] {
        [
            ValuePillar(
                title: L10n.t("真实业务", "真實業務", "Verified Activity", "Actividad verificada", lang: lang),
                subtitle: L10n.t(
                    "积分来自保险、贷款、房产等已核实的客户线索与交易",
                    "積分來自保險、貸款、房產等已核實的客戶線索與交易",
                    "Points come from verified customer leads and transactions in insurance, loans, real estate, and more",
                    "Los puntos provienen de clientes y transacciones verificados en seguros, préstamos, bienes raíces y más",
                    lang: lang
                ),
                icon: "briefcase.fill"
            ),
            ValuePillar(
                title: L10n.t("透明状态", "透明狀態", "Clear Statuses", "Estados claros", lang: lang),
                subtitle: L10n.t(
                    "每条记录显示待确认或已确认状态，积分范围在提交前可见",
                    "每條記錄顯示待確認或已確認狀態，積分範圍在提交前可見",
                    "Every submission shows Pending or Confirmed status, with point ranges visible before you submit",
                    "Cada envío muestra estado Pendiente o Confirmado, con rangos de puntos visibles antes de enviar",
                    lang: lang
                ),
                icon: "shield.checkered"
            ),
            ValuePillar(
                title: L10n.t("月度奖励", "月度獎勵", "Monthly Rewards", "Recompensas mensuales", lang: lang),
                subtitle: L10n.t(
                    "已确认积分可能参与月度奖励计算，结算前金额均为预估",
                    "已確認積分可能參與月度獎勵計算，結算前金額均為預估",
                    "Confirmed points may count toward monthly rewards; amounts are estimates until settlement",
                    "Los puntos confirmados pueden contar para recompensas mensuales; los importes son estimaciones hasta la liquidación",
                    lang: lang
                ),
                icon: "calendar.circle.fill"
            ),
            ValuePillar(
                title: L10n.t("技能提升", "技能提升", "Skill Building", "Desarrollo de habilidades", lang: lang),
                subtitle: L10n.t(
                    "通过培训与活动提升业务能力，同时赚取相应积分",
                    "透過培訓與活動提升業務能力，同時賺取相應積分",
                    "Build your skills through training and events while earning points for participation",
                    "Mejora tus habilidades con formación y eventos mientras ganas puntos por participar",
                    lang: lang
                ),
                icon: "arrow.up.forward.circle.fill"
            ),
        ]
    }

    static func workflowSteps(for lang: AppUILanguage) -> [WorkflowStep] {
        [
            WorkflowStep(
                id: 1,
                title: L10n.t("提交", "提交", "Submit", "Enviar", lang: lang),
                description: L10n.t(
                    "在「赚取」中选择类别，提交客户线索，或完成已核实的业务交易。",
                    "在「賺取」中選擇類別，提交客戶線索，或完成已核實的業務交易。",
                    "Choose a category in Earn, submit a customer lead, or complete a verified business transaction.",
                    "Elige una categoría en Ganar, envía un cliente potencial o completa una transacción comercial verificada.",
                    lang: lang
                ),
                icon: "hand.tap.fill"
            ),
            WorkflowStep(
                id: 2,
                title: L10n.t("核实", "核實", "Verify", "Verificar", lang: lang),
                description: L10n.t(
                    "提交后积分为「待确认」状态。核实通过后，积分记入账户并在「动态」中显示。",
                    "提交後積分為「待確認」狀態。核實通過後，積分記入帳戶並在「動態」中顯示。",
                    "Points start as Pending after submission. Once verified, they are credited to your account and appear in Activity.",
                    "Tras el envío, los puntos quedan Pendientes. Una vez verificados, se acreditan en tu cuenta y aparecen en Actividad.",
                    lang: lang
                ),
                icon: "checkmark.seal.fill"
            ),
            WorkflowStep(
                id: 3,
                title: L10n.t("奖励", "獎勵", "Reward", "Recompensa", lang: lang),
                description: L10n.t(
                    "每月根据已确认积分计算预估奖励。最终金额在月度结算后确定。",
                    "每月根據已確認積分計算預估獎勵。最終金額在月度結算後確定。",
                    "Each month, confirmed points contribute to an estimated reward. Final amounts are determined after monthly settlement.",
                    "Cada mes, los puntos confirmados contribuyen a una recompensa estimada. Los importes finales se determinan tras la liquidación mensual.",
                    lang: lang
                ),
                icon: "banknote.fill"
            ),
        ]
    }
}
