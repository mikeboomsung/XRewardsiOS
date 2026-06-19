import Foundation

enum L10n {
    static func t(_ zh: String, _ en: String, lang: AppUILanguage) -> String {
        lang == .zh ? zh : en
    }

    // MARK: - App shell

    static func preparingConnection(lang: AppUILanguage) -> String {
        t("正在建立安全连接…", "Preparing secure connection…", lang: lang)
    }

    static func guestPreviewBanner(lang: AppUILanguage) -> String {
        t(
            "游客预览模式：可浏览全部功能，但无法赚取积分。注册或登录后开始赚取。",
            "Guest preview: explore all features, but you cannot earn points. Sign up or sign in to start earning.",
            lang: lang
        )
    }

    static func guestProfileName(lang: AppUILanguage) -> String {
        t("演示用户", "Demo User", lang: lang)
    }

    static func guestMemberID(lang: AppUILanguage) -> String {
        t("预览", "PREVIEW", lang: lang)
    }

    static func guestAccountLabel(lang: AppUILanguage) -> String {
        t("游客账号", "Guest account", lang: lang)
    }

    // MARK: - Tabs

    static func tabHome(lang: AppUILanguage) -> String { t("首页", "Home", lang: lang) }
    static func tabEarn(lang: AppUILanguage) -> String { t("赚取", "Earn", lang: lang) }
    static func tabActivity(lang: AppUILanguage) -> String { t("动态", "Activity", lang: lang) }
    static func tabTeam(lang: AppUILanguage) -> String { t("团队", "Team", lang: lang) }
    static func tabProfile(lang: AppUILanguage) -> String { t("我的", "Profile", lang: lang) }

    // MARK: - Auth

    static func authTagline(lang: AppUILanguage) -> String {
        t("积累积分 · 共享奖励 · 共同成长", "Build points. Share rewards. Grow together.", lang: lang)
    }

    static func authPromo(lang: AppUILanguage) -> String {
        t("每推荐一位会员可获得 10 积分", "Earn 10 points for every member referral", lang: lang)
    }

    static func authGuestNotice(lang: AppUILanguage) -> String {
        t(
            "游客模式仅供预览全部功能，无法赚取或保存积分。注册或登录后即可开始赚取。",
            "Guest mode lets you preview all features but cannot earn or save points. Sign up or sign in to start earning.",
            lang: lang
        )
    }

    static func email(lang: AppUILanguage) -> String { t("邮箱", "Email", lang: lang) }
    static func password(lang: AppUILanguage) -> String { t("密码", "Password", lang: lang) }
    static func confirmPassword(lang: AppUILanguage) -> String { t("确认密码", "Confirm Password", lang: lang) }
    static func signIn(lang: AppUILanguage) -> String { t("登录", "Sign In", lang: lang) }
    static func signUp(lang: AppUILanguage) -> String { t("注册", "Sign Up", lang: lang) }
    static func forgotPassword(lang: AppUILanguage) -> String { t("忘记密码？", "Forgot Password?", lang: lang) }
    static func orDivider(lang: AppUILanguage) -> String { t("或", "OR", lang: lang) }
    static func continueWithGoogle(lang: AppUILanguage) -> String { t("使用 Google 登录", "Continue with Google", lang: lang) }
    static func continueAsGuest(lang: AppUILanguage) -> String { t("游客继续", "Continue as Guest", lang: lang) }
    static func noAccountSignUp(lang: AppUILanguage) -> String { t("没有账号？去注册", "No account yet? Sign up", lang: lang) }
    static func hasAccountSignIn(lang: AppUILanguage) -> String { t("已有账号？去登录", "Already have an account? Sign in", lang: lang) }
    static func guestSignInFailed(lang: AppUILanguage) -> String {
        t("游客登录失败，请检查网络后重试。", "Guest sign-in failed. Check your connection and try again.", lang: lang)
    }
    static func signInToEarn(lang: AppUILanguage) -> String { t("登录后开始赚取", "Sign In to Earn", lang: lang) }

    // MARK: - Home

    static func dashboard(lang: AppUILanguage) -> String { t("仪表盘", "Dashboard", lang: lang) }
    static func welcomeBack(lang: AppUILanguage) -> String { t("欢迎回来", "Welcome back", lang: lang) }
    static func member(lang: AppUILanguage) -> String { t("会员", "Member", lang: lang) }
    static func totalPoints(lang: AppUILanguage) -> String { t("总积分", "Total Points", lang: lang) }
    static func pointsPermanent(lang: AppUILanguage) -> String { t("永久有效 · 永不过期", "Permanent · Never expire", lang: lang) }
    static func estimatedThisMonth(lang: AppUILanguage) -> String { t("本月预估", "Estimated This Month", lang: lang) }
    static func basedOnCurrentPool(lang: AppUILanguage) -> String { t("基于当前奖池", "Based on current pool", lang: lang) }
    static func rewardPoolPercent(_ percent: Int, lang: AppUILanguage) -> String {
        t("奖励池：平台利润的 \(percent)%", "Reward pool: \(percent)% of platform profit", lang: lang)
    }
    static func pendingPoints(lang: AppUILanguage) -> String { t("待确认积分", "Pending Points", lang: lang) }
    static func activeRevenueStreams(lang: AppUILanguage) -> String { t("活跃收益来源", "Active Revenue Streams", lang: lang) }
    static func howPassiveIncomeWorks(lang: AppUILanguage) -> String {
        t("被动收入如何运作", "How passive income works", lang: lang)
    }

    // MARK: - Earn

    static func earnTitle(lang: AppUILanguage) -> String { t("赚取", "Earn", lang: lang) }
    static func earnSubtitle(lang: AppUILanguage) -> String {
        t("选择收益来源，开始积累永久积分。", "Choose a revenue stream and start earning permanent points.", lang: lang)
    }
    static func pointTable(lang: AppUILanguage) -> String { t("积分表", "Point Table", lang: lang) }
    static func startEarning(lang: AppUILanguage) -> String { t("开始赚取", "Start Earning", lang: lang) }
    static func submitReferralHint(lang: AppUILanguage) -> String {
        t("提交被邀请人信息，每单可获 10 推荐积分。", "Submit invitee details to earn 10 referral points.", lang: lang)
    }
    static func guestCannotEarn(lang: AppUILanguage) -> String {
        t("游客模式无法提交推荐或赚取积分，请先注册或登录。", "Guest mode cannot submit referrals or earn points. Please sign up or sign in.", lang: lang)
    }
    static func ok(lang: AppUILanguage) -> String { t("好的", "OK", lang: lang) }

    // MARK: - Activity

    static func activity(lang: AppUILanguage) -> String { t("动态", "Activity", lang: lang) }
    static func filterAll(lang: AppUILanguage) -> String { t("全部", "All", lang: lang) }
    static func filterReferrals(lang: AppUILanguage) -> String { t("推荐", "Referrals", lang: lang) }
    static func filterPending(lang: AppUILanguage) -> String { t("待确认", "Pending", lang: lang) }
    static func filterConfirmed(lang: AppUILanguage) -> String { t("已确认", "Confirmed", lang: lang) }
    static func noActivity(lang: AppUILanguage) -> String { t("暂无动态", "No Activity", lang: lang) }
    static func noActivityDesc(lang: AppUILanguage) -> String {
        t("符合筛选条件的交易将显示在这里。", "Transactions matching this filter will appear here.", lang: lang)
    }
    static func noReferrals(lang: AppUILanguage) -> String { t("暂无推荐", "No Referrals Yet", lang: lang) }
    static func noReferralsDesc(lang: AppUILanguage) -> String {
        t("在「赚取」中提交被邀请人信息，每单可获 10 积分。", "Submit invitee details from Earn → Start Earning to earn 10 points per referral.", lang: lang)
    }

    // MARK: - Team

    static func team(lang: AppUILanguage) -> String { t("团队", "Team", lang: lang) }
    static func teamSubtitle(lang: AppUILanguage) -> String {
        t("组建团队，共同积累积分。", "Build your team and grow collective points.", lang: lang)
    }
    static func directMembers(lang: AppUILanguage) -> String { t("直推成员", "Direct Members", lang: lang) }
    static func totalTeam(lang: AppUILanguage) -> String { t("团队总人数", "Total Team", lang: lang) }
    static func teamPoints(lang: AppUILanguage) -> String { t("团队积分", "Team Points", lang: lang) }
    static func teamStructure(lang: AppUILanguage) -> String { t("团队结构", "Team Structure", lang: lang) }
    static func orgChartSoon(lang: AppUILanguage) -> String { t("组织架构即将上线", "Org Chart Coming Soon", lang: lang) }
    static func orgChartDesc(lang: AppUILanguage) -> String {
        t("成员列表与层级将在后续更新中展示。", "Member list and hierarchy will appear in a future update.", lang: lang)
    }
    static func inviteMembers(lang: AppUILanguage) -> String { t("邀请成员", "Invite Members", lang: lang) }
    static func inviteHint(lang: AppUILanguage) -> String {
        t("邀请流程上线后可分享推荐链接。", "Share your referral link when the invite flow launches.", lang: lang)
    }
    static func inviteTitle(lang: AppUILanguage) -> String { t("邀请", "Invite", lang: lang) }
    static func inviteMessage(lang: AppUILanguage) -> String {
        t(
            "邀请好友加入 XRewards，通过真实业务活动赚取永久积分和月度分红。下载应用并开始赚取：https://xrewards.app/invite",
            "Join me on XRewards — earn permanent points and monthly dividends from real business activities. Download the app and start earning: https://xrewards.app/invite",
            lang: lang
        )
    }
    static func inviteSheetBody(lang: AppUILanguage) -> String {
        t("邀请好友加入团队，解锁更多赚取机会。", "Invite friends to grow your team and unlock more earning opportunities.", lang: lang)
    }
    static func shareInvite(lang: AppUILanguage) -> String { t("分享邀请", "Share Invite", lang: lang) }
    static func done(lang: AppUILanguage) -> String { t("完成", "Done", lang: lang) }

    // MARK: - Profile

    static func profile(lang: AppUILanguage) -> String { t("我的", "Profile", lang: lang) }
    static func memberSince(_ date: String, lang: AppUILanguage) -> String {
        t("加入于 \(date)", "Member since \(date)", lang: lang)
    }
    static func editName(lang: AppUILanguage) -> String { t("编辑姓名", "Edit Name", lang: lang) }
    static func learn(lang: AppUILanguage) -> String { t("了解", "Learn", lang: lang) }
    static func howItWorks(lang: AppUILanguage) -> String { t("运作方式", "How It Works", lang: lang) }
    static func dividends(lang: AppUILanguage) -> String { t("分红", "Dividends", lang: lang) }
    static func support(lang: AppUILanguage) -> String { t("支持", "Support", lang: lang) }
    static func rewardRules(lang: AppUILanguage) -> String { t("奖励规则", "Reward Rules", lang: lang) }
    static func faq(lang: AppUILanguage) -> String { t("常见问题", "FAQ", lang: lang) }
    static func contactSupport(lang: AppUILanguage) -> String { t("联系支持", "Contact Support", lang: lang) }
    static func settings(lang: AppUILanguage) -> String { t("设置", "Settings", lang: lang) }
    static func language(lang: AppUILanguage) -> String { t("语言", "Language", lang: lang) }
    static func languageChinese(lang: AppUILanguage) -> String { t("简体中文", "Simplified Chinese", lang: lang) }
    static func languageEnglish(lang: AppUILanguage) -> String { t("English", "English", lang: lang) }
    static func signOut(lang: AppUILanguage) -> String { t("退出登录", "Sign Out", lang: lang) }
    static func displayName(lang: AppUILanguage) -> String { t("显示名称", "Display name", lang: lang) }
    static func yourName(lang: AppUILanguage) -> String { t("您的姓名", "Your name", lang: lang) }
    static func cancel(lang: AppUILanguage) -> String { t("取消", "Cancel", lang: lang) }
    static func save(lang: AppUILanguage) -> String { t("保存", "Save", lang: lang) }

    // MARK: - Referral form

    static func submitReferralIntro(lang: AppUILanguage) -> String {
        t("提交您邀请的人员信息，记录后将获得 10 积分。", "Submit the person you invited. You'll earn 10 points once the lead is recorded.", lang: lang)
    }
    static func fullName(lang: AppUILanguage) -> String { t("姓名", "Full Name", lang: lang) }
    static func phoneNumber(lang: AppUILanguage) -> String { t("手机号", "Phone Number", lang: lang) }
    static func emailAddress(lang: AppUILanguage) -> String { t("邮箱地址", "Email Address", lang: lang) }
    static func submitReferral(lang: AppUILanguage) -> String { t("提交推荐", "Submit Referral", lang: lang) }
    static func referralSuccess(lang: AppUILanguage) -> String {
        t("推荐已提交 — 10 积分已添加（待确认）", "Referral submitted — 10 points added (pending)", lang: lang)
    }
    static func referCategory(_ name: String, lang: AppUILanguage) -> String {
        t("推荐 · \(name)", "Refer \(name)", lang: lang)
    }
    static func close(lang: AppUILanguage) -> String { t("关闭", "Close", lang: lang) }

    // MARK: - Dividends

    static func currentPeriod(lang: AppUILanguage) -> String { t("当前周期", "Current Period", lang: lang) }
    static func estimatedPayout(lang: AppUILanguage) -> String { t("预估发放", "Estimated Payout", lang: lang) }
    static func history(lang: AppUILanguage) -> String { t("历史", "History", lang: lang) }
    static func poolSize(lang: AppUILanguage) -> String { t("奖池规模", "Pool Size", lang: lang) }
    static func yourShare(lang: AppUILanguage) -> String { t("您的份额", "Your Share", lang: lang) }
    static func yourPoints(lang: AppUILanguage) -> String { t("您的积分", "Your Points", lang: lang) }
    static func settlesJuly1(lang: AppUILanguage) -> String { t("7 月 1 日结算", "Settles Jul 1", lang: lang) }
    static func dividendFormula(lang: AppUILanguage) -> String {
        t(
            "您的月度分红 =（您的积分 ÷ 平台总积分）× 奖励池。结算前金额为预估。",
            "Your monthly dividend = (your points ÷ total platform points) × reward pool. Amounts are estimates until settlement.",
            lang: lang
        )
    }

    // MARK: - How it works

    static func howItWorksSubtitle(lang: AppUILanguage) -> String {
        t("从行动到被动收入的路径", "Your path from action to passive income", lang: lang)
    }
    static func fivePillars(lang: AppUILanguage) -> String { t("五大价值支柱", "Five Value Pillars", lang: lang) }
    static func stepNumber(_ number: Int, lang: AppUILanguage) -> String {
        t("第 \(number) 步", "Step \(number)", lang: lang)
    }
    static func longTermRetention(lang: AppUILanguage) -> String { t("长期留存", "Long-Term Retention", lang: lang) }
    static func retentionBody(lang: AppUILanguage) -> String {
        t(
            "传统一次性佣金会衰减。XRewards 积分永久有效——您的奖池份额持续分红。",
            "Traditional one-time commissions fade. XRewards points stay valid — your share of the pool keeps paying.",
            lang: lang
        )
    }
    static func traditionalLabel(lang: AppUILanguage) -> String { t("传统模式", "Traditional", lang: lang) }
    static func xrewardsLabel(lang: AppUILanguage) -> String { t("XRewards", "XRewards", lang: lang) }
    static func rewardPoolTitle(lang: AppUILanguage) -> String { t("奖励池", "Reward Pool", lang: lang) }
    static func platformProfit(lang: AppUILanguage) -> String { t("平台利润", "Platform Profit", lang: lang) }
    static func poolShareLabel(lang: AppUILanguage) -> String { t("您的份额", "Your Share", lang: lang) }
    static func poolPercentRange(_ lower: Int, _ upper: Int, lang: AppUILanguage) -> String {
        t("\(lower)–\(upper)% 奖池", "\(lower)–\(upper)% Pool", lang: lang)
    }
    static func dividendFormulaShort(lang: AppUILanguage) -> String {
        t(
            "分红 =（您的积分 ÷ 平台总积分）× 奖励池",
            "Dividend = (your points ÷ total platform points) × reward pool",
            lang: lang
        )
    }
    static func memberIDLabel(_ id: String, lang: AppUILanguage) -> String {
        t("ID：\(id)", "ID: \(id)", lang: lang)
    }
    static func exitGuest(lang: AppUILanguage) -> String { t("退出游客模式", "Exit Guest Mode", lang: lang) }
    static func deleteAccount(lang: AppUILanguage) -> String { t("删除账号", "Delete Account", lang: lang) }
    static func deleteAccountTitle(lang: AppUILanguage) -> String {
        t("确认删除账号？", "Delete Account?", lang: lang)
    }
    static func deleteAccountMessage(lang: AppUILanguage) -> String {
        t(
            "此操作不可撤销。您的账号、全部积分、推荐记录和分红历史将被永久删除，且无法恢复。",
            "This cannot be undone. Your account, all points, referrals, and dividend history will be permanently deleted and cannot be recovered.",
            lang: lang
        )
    }
    static func delete(lang: AppUILanguage) -> String { t("删除", "Delete", lang: lang) }
    static func privacyPolicy(lang: AppUILanguage) -> String { t("隐私政策", "Privacy Policy", lang: lang) }
    static func privacyPolicyAgreePrompt(lang: AppUILanguage) -> String {
        t("请阅读并同意我们的隐私政策以继续使用", "Please read and agree to our Privacy Policy to continue", lang: lang)
    }
    static func privacyPolicyAgree(lang: AppUILanguage) -> String {
        t("我已阅读并同意", "I Have Read and Agree", lang: lang)
    }
    static func privacyPolicyScrollHint(lang: AppUILanguage) -> String {
        t("请滚动至隐私政策底部后继续", "Please scroll to the bottom of the Privacy Policy to continue", lang: lang)
    }
    static func privacyPolicyLoadFailed(lang: AppUILanguage) -> String {
        t("无法加载隐私政策", "Unable to load Privacy Policy", lang: lang)
    }

    // MARK: - Transaction status

    static func statusPending(lang: AppUILanguage) -> String { t("待确认", "Pending", lang: lang) }
    static func statusConfirmed(lang: AppUILanguage) -> String { t("已确认", "Confirmed", lang: lang) }
    static func statusRejected(lang: AppUILanguage) -> String { t("已拒绝", "Rejected", lang: lang) }
    static func statusEstimated(lang: AppUILanguage) -> String { t("预估", "Estimated", lang: lang) }
    static func statusProcessing(lang: AppUILanguage) -> String { t("处理中", "Processing", lang: lang) }
    static func statusPaid(lang: AppUILanguage) -> String { t("已发放", "Paid", lang: lang) }
}
