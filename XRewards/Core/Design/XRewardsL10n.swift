import Foundation

enum L10n {
    static func t(_ zh: String, _ zhHant: String, _ en: String, _ es: String, lang: AppUILanguage) -> String {
        switch lang {
        case .zh: zh
        case .zhHant: zhHant
        case .en: en
        case .es: es
        }
    }

    // MARK: - App shell

    static func preparingConnection(lang: AppUILanguage) -> String {
        t("正在建立安全连接…", "正在建立安全連線…", "Preparing secure connection…", "Preparando conexión segura…", lang: lang)
    }

    static func guestPreviewBanner(lang: AppUILanguage) -> String {
        t(
            "游客预览模式：可浏览应用，但无法赚取积分。注册或登录后开始赚取。",
            "訪客預覽模式：可瀏覽應用程式，但無法賺取積分。註冊或登入後開始賺取。",
            "Guest preview: explore the app, but you cannot earn points. Sign up or sign in to start earning.",
            "Vista previa: explora la app, pero no puedes ganar puntos. Regístrate o inicia sesión para empezar.",
            lang: lang
        )
    }

    static func guestProfileName(lang: AppUILanguage) -> String {
        t("演示用户", "示範用戶", "Demo User", "Usuario demo", lang: lang)
    }

    static func guestMemberID(lang: AppUILanguage) -> String {
        t("预览", "預覽", "PREVIEW", "VISTA PREVIA", lang: lang)
    }

    static func guestAccountLabel(lang: AppUILanguage) -> String {
        t("游客账号", "訪客帳號", "Guest account", "Cuenta de invitado", lang: lang)
    }

    // MARK: - Tabs

    static func tabHome(lang: AppUILanguage) -> String { t("首页", "首頁", "Home", "Inicio", lang: lang) }
    static func tabEarn(lang: AppUILanguage) -> String { t("赚取", "賺取", "Earn", "Ganar", lang: lang) }
    static func tabActivity(lang: AppUILanguage) -> String { t("动态", "動態", "Activity", "Actividad", lang: lang) }
    static func tabProfile(lang: AppUILanguage) -> String { t("我的", "我的", "Profile", "Perfil", lang: lang) }

    // MARK: - Auth

    static func authTagline(lang: AppUILanguage) -> String {
        t(
            "通过真实业务活动积累积分",
            "透過真實業務活動累積積分",
            "Earn points from verified business activities",
            "Gana puntos con actividades comerciales verificadas",
            lang: lang
        )
    }

    static func authPromo(lang: AppUILanguage) -> String {
        t(
            "推荐客户 · 完成交易 · 获得积分",
            "推薦客戶 · 完成交易 · 獲得積分",
            "Refer customers · Close deals · Earn points",
            "Recomienda clientes · Cierra tratos · Gana puntos",
            lang: lang
        )
    }

    static func authGuestNotice(lang: AppUILanguage) -> String {
        t(
            "游客模式仅供预览，无法赚取或保存积分。注册或登录后即可开始赚取。",
            "訪客模式僅供預覽，無法賺取或儲存積分。註冊或登入後即可開始賺取。",
            "Guest mode lets you preview the app but cannot earn or save points. Sign up or sign in to start earning.",
            "El modo invitado solo permite previsualizar; no puedes ganar ni guardar puntos. Regístrate o inicia sesión para empezar.",
            lang: lang
        )
    }

    static func email(lang: AppUILanguage) -> String { t("邮箱", "電子郵件", "Email", "Correo electrónico", lang: lang) }
    static func password(lang: AppUILanguage) -> String { t("密码", "密碼", "Password", "Contraseña", lang: lang) }
    static func confirmPassword(lang: AppUILanguage) -> String { t("确认密码", "確認密碼", "Confirm Password", "Confirmar contraseña", lang: lang) }
    static func signIn(lang: AppUILanguage) -> String { t("登录", "登入", "Sign In", "Iniciar sesión", lang: lang) }
    static func signUp(lang: AppUILanguage) -> String { t("注册", "註冊", "Sign Up", "Registrarse", lang: lang) }
    static func forgotPassword(lang: AppUILanguage) -> String { t("忘记密码？", "忘記密碼？", "Forgot Password?", "¿Olvidaste tu contraseña?", lang: lang) }
    static func orDivider(lang: AppUILanguage) -> String { t("或", "或", "OR", "O", lang: lang) }
    static func continueWithGoogle(lang: AppUILanguage) -> String { t("使用 Google 登录", "使用 Google 登入", "Continue with Google", "Continuar con Google", lang: lang) }
    static func continueAsGuest(lang: AppUILanguage) -> String { t("游客继续", "訪客繼續", "Continue as Guest", "Continuar como invitado", lang: lang) }
    static func noAccountSignUp(lang: AppUILanguage) -> String { t("没有账号？去注册", "沒有帳號？去註冊", "No account yet? Sign up", "¿No tienes cuenta? Regístrate", lang: lang) }
    static func hasAccountSignIn(lang: AppUILanguage) -> String { t("已有账号？去登录", "已有帳號？去登入", "Already have an account? Sign in", "¿Ya tienes cuenta? Inicia sesión", lang: lang) }
    static func guestSignInFailed(lang: AppUILanguage) -> String {
        t("游客登录失败，请检查网络后重试。", "訪客登入失敗，請檢查網路後重試。", "Guest sign-in failed. Check your connection and try again.", "Error al iniciar sesión como invitado. Comprueba tu conexión e inténtalo de nuevo.", lang: lang)
    }
    static func signInToEarn(lang: AppUILanguage) -> String { t("登录后开始赚取", "登入後開始賺取", "Sign In to Earn", "Inicia sesión para ganar", lang: lang) }

    // MARK: - Home

    static func dashboard(lang: AppUILanguage) -> String { t("仪表盘", "儀表板", "Dashboard", "Panel", lang: lang) }
    static func welcomeBack(lang: AppUILanguage) -> String { t("欢迎回来", "歡迎回來", "Welcome back", "Bienvenido de nuevo", lang: lang) }
    static func member(lang: AppUILanguage) -> String { t("会员", "會員", "Member", "Miembro", lang: lang) }
    static func totalPoints(lang: AppUILanguage) -> String { t("总积分", "總積分", "Total Points", "Puntos totales", lang: lang) }
    static func pointsPermanent(lang: AppUILanguage) -> String { t("已确认积分", "已確認積分", "Confirmed points", "Puntos confirmados", lang: lang) }
    static func estimatedThisMonth(lang: AppUILanguage) -> String { t("本月预估奖励", "本月預估獎勵", "Estimated This Month", "Estimado este mes", lang: lang) }
    static func basedOnCurrentPool(lang: AppUILanguage) -> String { t("基于已确认积分", "基於已確認積分", "Based on confirmed points", "Basado en puntos confirmados", lang: lang) }
    static func rewardPoolPercent(_ percent: Int, lang: AppUILanguage) -> String {
        t("按积分占比分配月度奖励", "按積分占比分配月度獎勵", "Monthly reward based on your point share", "Recompensa mensual según tu proporción de puntos", lang: lang)
    }
    static func pendingPoints(lang: AppUILanguage) -> String { t("待确认积分", "待確認積分", "Pending Points", "Puntos pendientes", lang: lang) }
    static func activeRevenueStreams(lang: AppUILanguage) -> String { t("活跃收益来源", "活躍收益來源", "Active Revenue Streams", "Fuentes de ingresos activas", lang: lang) }
    static func howPassiveIncomeWorks(lang: AppUILanguage) -> String {
        t("奖励如何运作", "獎勵如何運作", "How rewards work", "Cómo funcionan las recompensas", lang: lang)
    }

    // MARK: - Earn

    static func earnTitle(lang: AppUILanguage) -> String { t("赚取", "賺取", "Earn", "Ganar", lang: lang) }
    static func earnSubtitle(lang: AppUILanguage) -> String {
        t(
            "选择业务类别，提交客户线索或完成交易以赚取积分。",
            "選擇業務類別，提交客戶線索或完成交易以賺取積分。",
            "Choose a category and submit customer leads or close deals to earn points.",
            "Elige una categoría y envía clientes potenciales o cierra tratos para ganar puntos.",
            lang: lang
        )
    }
    static func pointTable(lang: AppUILanguage) -> String { t("积分表", "積分表", "Point Table", "Tabla de puntos", lang: lang) }
    static func startEarning(lang: AppUILanguage) -> String { t("提交线索", "提交線索", "Submit Lead", "Enviar cliente", lang: lang) }
    static func submitReferralHint(lang: AppUILanguage) -> String {
        t("提交客户信息，核实后可获得相应积分。", "提交客戶資訊，核實後可獲得相應積分。", "Submit customer details to earn points once verified.", "Envía los datos del cliente para ganar puntos tras la verificación.", lang: lang)
    }
    static func guestCannotEarn(lang: AppUILanguage) -> String {
        t("游客模式无法提交线索或赚取积分，请先注册或登录。", "訪客模式無法提交線索或賺取積分，請先註冊或登入。", "Guest mode cannot submit leads or earn points. Please sign up or sign in.", "El modo invitado no puede enviar clientes ni ganar puntos. Regístrate o inicia sesión.", lang: lang)
    }
    static func ok(lang: AppUILanguage) -> String { t("好的", "好的", "OK", "OK", lang: lang) }

    // MARK: - Activity

    static func activity(lang: AppUILanguage) -> String { t("动态", "動態", "Activity", "Actividad", lang: lang) }
    static func filterAll(lang: AppUILanguage) -> String { t("全部", "全部", "All", "Todo", lang: lang) }
    static func filterReferrals(lang: AppUILanguage) -> String { t("线索", "線索", "Leads", "Clientes", lang: lang) }
    static func filterPending(lang: AppUILanguage) -> String { t("待确认", "待確認", "Pending", "Pendiente", lang: lang) }
    static func filterConfirmed(lang: AppUILanguage) -> String { t("已确认", "已確認", "Confirmed", "Confirmado", lang: lang) }
    static func noActivity(lang: AppUILanguage) -> String { t("暂无动态", "暫無動態", "No Activity", "Sin actividad", lang: lang) }
    static func noActivityDesc(lang: AppUILanguage) -> String {
        t("符合筛选条件的交易将显示在这里。", "符合篩選條件的交易將顯示在這裡。", "Transactions matching this filter will appear here.", "Las transacciones que coincidan con este filtro aparecerán aquí.", lang: lang)
    }
    static func noReferrals(lang: AppUILanguage) -> String { t("暂无线索", "暫無線索", "No Leads Yet", "Aún no hay clientes", lang: lang) }
    static func noReferralsDesc(lang: AppUILanguage) -> String {
        t("在「赚取」中选择类别并提交客户线索。", "在「賺取」中選擇類別並提交客戶線索。", "Submit customer leads from Earn → Submit Lead.", "Envía clientes desde Ganar → Enviar cliente.", lang: lang)
    }

    // MARK: - Profile

    static func profile(lang: AppUILanguage) -> String { t("我的", "我的", "Profile", "Perfil", lang: lang) }
    static func memberSince(_ date: String, lang: AppUILanguage) -> String {
        t("加入于 \(date)", "加入於 \(date)", "Member since \(date)", "Miembro desde \(date)", lang: lang)
    }
    static func editName(lang: AppUILanguage) -> String { t("编辑姓名", "編輯姓名", "Edit Name", "Editar nombre", lang: lang) }
    static func learn(lang: AppUILanguage) -> String { t("了解", "了解", "Learn", "Información", lang: lang) }
    static func howItWorks(lang: AppUILanguage) -> String { t("运作方式", "運作方式", "How It Works", "Cómo funciona", lang: lang) }
    static func dividends(lang: AppUILanguage) -> String { t("月度奖励", "月度獎勵", "Monthly Rewards", "Recompensas mensuales", lang: lang) }
    static func support(lang: AppUILanguage) -> String { t("支持", "支援", "Support", "Soporte", lang: lang) }
    static func contactSupport(lang: AppUILanguage) -> String { t("联系支持", "聯絡支援", "Contact Support", "Contactar soporte", lang: lang) }
    static func settings(lang: AppUILanguage) -> String { t("设置", "設定", "Settings", "Ajustes", lang: lang) }
    static func language(lang: AppUILanguage) -> String { t("语言", "語言", "Language", "Idioma", lang: lang) }
    static func signOut(lang: AppUILanguage) -> String { t("退出登录", "登出", "Sign Out", "Cerrar sesión", lang: lang) }
    static func displayName(lang: AppUILanguage) -> String { t("显示名称", "顯示名稱", "Display name", "Nombre para mostrar", lang: lang) }
    static func yourName(lang: AppUILanguage) -> String { t("您的姓名", "您的姓名", "Your name", "Tu nombre", lang: lang) }
    static func cancel(lang: AppUILanguage) -> String { t("取消", "取消", "Cancel", "Cancelar", lang: lang) }
    static func save(lang: AppUILanguage) -> String { t("保存", "儲存", "Save", "Guardar", lang: lang) }

    // MARK: - Lead form

    static func submitReferralIntro(lang: AppUILanguage) -> String {
        t("提交客户信息，核实后将获得相应积分。", "提交客戶資訊，核實後將獲得相應積分。", "Submit customer details. You'll earn points once the lead is verified.", "Envía los datos del cliente. Ganarás puntos cuando se verifique.", lang: lang)
    }
    static func submitLeadPrivacyNotice(lang: AppUILanguage) -> String {
        t(
            "提交即表示您确认已获得该客户同意分享其联系信息，且我们可能会将线索提供给相关第三方合作方用于营销或业务跟进。详见隐私政策。",
            "提交即表示您確認已獲得該客戶同意分享其聯絡資訊，且我們可能會將線索提供給相關第三方合作方用於行銷或業務跟進。詳見隱私權政策。",
            "By submitting, you confirm the customer consents to sharing their contact information. We may provide this lead to relevant third-party partners for marketing or business follow-up. See our Privacy Policy.",
            "Al enviar, confirmas que el cliente consiente compartir su información de contacto. Podemos proporcionar este cliente a socios externos para marketing o seguimiento comercial. Consulta nuestra Política de privacidad.",
            lang: lang
        )
    }
    static func fullName(lang: AppUILanguage) -> String { t("客户姓名", "客戶姓名", "Customer Name", "Nombre del cliente", lang: lang) }
    static func phoneNumber(lang: AppUILanguage) -> String { t("手机号", "手機號碼", "Phone Number", "Número de teléfono", lang: lang) }
    static func emailAddress(lang: AppUILanguage) -> String { t("邮箱地址", "電子郵件地址", "Email Address", "Correo electrónico", lang: lang) }
    static func submitReferral(lang: AppUILanguage) -> String { t("提交线索", "提交線索", "Submit Lead", "Enviar cliente", lang: lang) }
    static func referralSuccess(lang: AppUILanguage) -> String {
        t("线索已提交 — 积分待确认", "線索已提交 — 積分待確認", "Lead submitted — points pending verification", "Cliente enviado — puntos pendientes de verificación", lang: lang)
    }
    static func referCategory(_ name: String, lang: AppUILanguage) -> String {
        t("线索 · \(name)", "線索 · \(name)", "Lead · \(name)", "Cliente · \(name)", lang: lang)
    }
    static func close(lang: AppUILanguage) -> String { t("关闭", "關閉", "Close", "Cerrar", lang: lang) }

    // MARK: - Dividends

    static func currentPeriod(lang: AppUILanguage) -> String { t("当前周期", "目前週期", "Current Period", "Período actual", lang: lang) }
    static func estimatedPayout(lang: AppUILanguage) -> String { t("预估发放", "預估發放", "Estimated Payout", "Pago estimado", lang: lang) }
    static func history(lang: AppUILanguage) -> String { t("历史", "歷史", "History", "Historial", lang: lang) }
    static func poolSize(lang: AppUILanguage) -> String { t("奖励总额", "獎勵總額", "Reward Total", "Total de recompensas", lang: lang) }
    static func yourShare(lang: AppUILanguage) -> String { t("您的占比", "您的占比", "Your Share", "Tu proporción", lang: lang) }
    static func yourPoints(lang: AppUILanguage) -> String { t("您的积分", "您的積分", "Your Points", "Tus puntos", lang: lang) }
    static func settlesJuly1(lang: AppUILanguage) -> String { t("7 月 1 日结算", "7 月 1 日結算", "Settles Jul 1", "Liquidación 1 jul", lang: lang) }
    static func dividendFormula(lang: AppUILanguage) -> String {
        t(
            "月度奖励按已确认积分占比分配。结算前金额为预估。",
            "月度獎勵按已確認積分占比分配。結算前金額為預估。",
            "Monthly rewards are distributed based on your share of confirmed points. Amounts are estimates until settlement.",
            "Las recompensas mensuales se distribuyen según tu proporción de puntos confirmados. Los importes son estimaciones hasta la liquidación.",
            lang: lang
        )
    }

    // MARK: - How it works

    static func howItWorksSubtitle(lang: AppUILanguage) -> String {
        t("通过已核实的业务活动赚取积分", "透過已核實的業務活動賺取積分", "Earn points from verified business activity", "Gana puntos con actividad comercial verificada", lang: lang)
    }
    static func fivePillars(lang: AppUILanguage) -> String { t("要点说明", "要點說明", "What to Expect", "Qué esperar", lang: lang) }
    static func howItWorksDisclaimer(lang: AppUILanguage) -> String {
        t(
            "奖励金额在正式结算前均为预估。积分与奖励取决于已核实的业务活动及平台规则，不构成收入保证。",
            "獎勵金額在正式結算前均為預估。積分與獎勵取決於已核實的業務活動及平台規則，不構成收入保證。",
            "Reward amounts are estimates until officially settled. Points and rewards depend on verified business activity and platform rules. Earnings are not guaranteed.",
            "Los importes de recompensa son estimaciones hasta la liquidación oficial. Los puntos y recompensas dependen de la actividad verificada y las reglas de la plataforma. No se garantizan ingresos.",
            lang: lang
        )
    }
    static func stepNumber(_ number: Int, lang: AppUILanguage) -> String {
        t("第 \(number) 步", "第 \(number) 步", "Step \(number)", "Paso \(number)", lang: lang)
    }
    static func memberIDLabel(_ id: String, lang: AppUILanguage) -> String {
        t("ID：\(id)", "ID：\(id)", "ID: \(id)", "ID: \(id)", lang: lang)
    }
    static func exitGuest(lang: AppUILanguage) -> String { t("退出游客模式", "退出訪客模式", "Exit Guest Mode", "Salir del modo invitado", lang: lang) }
    static func deleteAccount(lang: AppUILanguage) -> String { t("删除账号", "刪除帳號", "Delete Account", "Eliminar cuenta", lang: lang) }
    static func deleteAccountTitle(lang: AppUILanguage) -> String {
        t("确认删除账号？", "確認刪除帳號？", "Delete Account?", "¿Eliminar cuenta?", lang: lang)
    }
    static func deleteAccountMessage(lang: AppUILanguage) -> String {
        t(
            "此操作不可撤销。您的账号、全部积分、线索记录和奖励历史将被永久删除，且无法恢复。",
            "此操作不可撤銷。您的帳號、全部積分、線索記錄和獎勵歷史將被永久刪除，且無法恢復。",
            "This cannot be undone. Your account, all points, lead records, and reward history will be permanently deleted and cannot be recovered.",
            "Esta acción no se puede deshacer. Tu cuenta, todos los puntos, registros de clientes e historial de recompensas se eliminarán permanentemente.",
            lang: lang
        )
    }
    static func delete(lang: AppUILanguage) -> String { t("删除", "刪除", "Delete", "Eliminar", lang: lang) }
    static func privacyPolicy(lang: AppUILanguage) -> String { t("隐私政策", "隱私權政策", "Privacy Policy", "Política de privacidad", lang: lang) }
    static func privacyPolicyAgreePrompt(lang: AppUILanguage) -> String {
        t("请阅读并同意我们的隐私政策以继续使用", "請閱讀並同意我們的隱私權政策以繼續使用", "Please read and agree to our Privacy Policy to continue", "Lee y acepta nuestra Política de privacidad para continuar", lang: lang)
    }
    static func privacyPolicyAgree(lang: AppUILanguage) -> String {
        t("我已阅读并同意", "我已閱讀並同意", "I Have Read and Agree", "He leído y acepto", lang: lang)
    }
    static func privacyPolicyScrollHint(lang: AppUILanguage) -> String {
        t("请滚动至隐私政策底部后继续", "請捲動至隱私權政策底部後繼續", "Please scroll to the bottom of the Privacy Policy to continue", "Desplázate hasta el final de la Política de privacidad para continuar", lang: lang)
    }
    static func privacyPolicyLoadFailed(lang: AppUILanguage) -> String {
        t("无法加载隐私政策", "無法載入隱私權政策", "Unable to load Privacy Policy", "No se pudo cargar la Política de privacidad", lang: lang)
    }

    // MARK: - Transaction status

    static func statusPending(lang: AppUILanguage) -> String { t("待确认", "待確認", "Pending", "Pendiente", lang: lang) }
    static func statusConfirmed(lang: AppUILanguage) -> String { t("已确认", "已確認", "Confirmed", "Confirmado", lang: lang) }
    static func statusRejected(lang: AppUILanguage) -> String { t("已拒绝", "已拒絕", "Rejected", "Rechazado", lang: lang) }
    static func statusEstimated(lang: AppUILanguage) -> String { t("预估", "預估", "Estimated", "Estimado", lang: lang) }
    static func statusProcessing(lang: AppUILanguage) -> String { t("处理中", "處理中", "Processing", "Procesando", lang: lang) }
    static func statusPaid(lang: AppUILanguage) -> String { t("已发放", "已發放", "Paid", "Pagado", lang: lang) }
}
