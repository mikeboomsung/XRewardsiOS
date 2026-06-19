import { AppLanguage, t } from './language';

export const L10n = {
  preparingConnection: (lang: AppLanguage) => t('正在建立安全连接…', 'Preparing secure connection…', lang),
  guestPreviewBanner: (lang: AppLanguage) =>
    t(
      '游客预览模式：可浏览全部功能，但无法赚取积分。注册或登录后开始赚取。',
      'Guest preview: explore all features, but you cannot earn points. Sign up or sign in to start earning.',
      lang
    ),
  guestProfileName: (lang: AppLanguage) => t('演示用户', 'Demo User', lang),
  guestMemberID: (lang: AppLanguage) => t('预览', 'PREVIEW', lang),
  guestAccountLabel: (lang: AppLanguage) => t('游客账号', 'Guest account', lang),
  tabHome: (lang: AppLanguage) => t('首页', 'Home', lang),
  tabEarn: (lang: AppLanguage) => t('赚取', 'Earn', lang),
  tabActivity: (lang: AppLanguage) => t('动态', 'Activity', lang),
  tabTeam: (lang: AppLanguage) => t('团队', 'Team', lang),
  tabProfile: (lang: AppLanguage) => t('我的', 'Profile', lang),
  authTagline: (lang: AppLanguage) =>
    t('积累积分 · 共享奖励 · 共同成长', 'Build points. Share rewards. Grow together.', lang),
  authPromo: (lang: AppLanguage) =>
    t('每推荐一位会员可获得 10 积分', 'Earn 10 points for every member referral', lang),
  authGuestNotice: (lang: AppLanguage) =>
    t(
      '游客模式仅供预览全部功能，无法赚取或保存积分。注册或登录后即可开始赚取。',
      'Guest mode lets you preview all features but cannot earn or save points. Sign up or sign in to start earning.',
      lang
    ),
  email: (lang: AppLanguage) => t('邮箱', 'Email', lang),
  password: (lang: AppLanguage) => t('密码', 'Password', lang),
  confirmPassword: (lang: AppLanguage) => t('确认密码', 'Confirm Password', lang),
  signIn: (lang: AppLanguage) => t('登录', 'Sign In', lang),
  signUp: (lang: AppLanguage) => t('注册', 'Sign Up', lang),
  orDivider: (lang: AppLanguage) => t('或', 'OR', lang),
  continueWithGoogle: (lang: AppLanguage) => t('使用 Google 登录', 'Continue with Google', lang),
  continueAsGuest: (lang: AppLanguage) => t('游客继续', 'Continue as Guest', lang),
  noAccountSignUp: (lang: AppLanguage) => t('没有账号？去注册', 'No account yet? Sign up', lang),
  hasAccountSignIn: (lang: AppLanguage) => t('已有账号？去登录', 'Already have an account? Sign in', lang),
  guestSignInFailed: (lang: AppLanguage) =>
    t('游客登录失败，请检查网络后重试。', 'Guest sign-in failed. Check your connection and try again.', lang),
  signInToEarn: (lang: AppLanguage) => t('登录后开始赚取', 'Sign In to Earn', lang),
  dashboard: (lang: AppLanguage) => t('仪表盘', 'Dashboard', lang),
  welcomeBack: (lang: AppLanguage) => t('欢迎回来', 'Welcome back', lang),
  member: (lang: AppLanguage) => t('会员', 'Member', lang),
  totalPoints: (lang: AppLanguage) => t('总积分', 'Total Points', lang),
  pointsPermanent: (lang: AppLanguage) => t('永久有效 · 永不过期', 'Permanent · Never expire', lang),
  estimatedThisMonth: (lang: AppLanguage) => t('本月预估', 'Estimated This Month', lang),
  basedOnCurrentPool: (lang: AppLanguage) => t('基于当前奖池', 'Based on current pool', lang),
  rewardPoolPercent: (percent: number, lang: AppLanguage) =>
    t(`奖励池：平台利润的 ${percent}%`, `Reward pool: ${percent}% of platform profit`, lang),
  pendingPoints: (lang: AppLanguage) => t('待确认积分', 'Pending Points', lang),
  activeRevenueStreams: (lang: AppLanguage) => t('活跃收益来源', 'Active Revenue Streams', lang),
  howPassiveIncomeWorks: (lang: AppLanguage) => t('被动收入如何运作', 'How passive income works', lang),
  earnTitle: (lang: AppLanguage) => t('赚取', 'Earn', lang),
  earnSubtitle: (lang: AppLanguage) =>
    t('选择收益来源，开始积累永久积分。', 'Choose a revenue stream and start earning permanent points.', lang),
  pointTable: (lang: AppLanguage) => t('积分表', 'Point Table', lang),
  startEarning: (lang: AppLanguage) => t('开始赚取', 'Start Earning', lang),
  submitReferralHint: (lang: AppLanguage) =>
    t('提交被邀请人信息，每单可获 10 推荐积分。', 'Submit invitee details to earn 10 referral points.', lang),
  guestCannotEarn: (lang: AppLanguage) =>
    t(
      '游客模式无法提交推荐或赚取积分，请先注册或登录。',
      'Guest mode cannot submit referrals or earn points. Please sign up or sign in.',
      lang
    ),
  ok: (lang: AppLanguage) => t('好的', 'OK', lang),
  activity: (lang: AppLanguage) => t('动态', 'Activity', lang),
  filterAll: (lang: AppLanguage) => t('全部', 'All', lang),
  filterReferrals: (lang: AppLanguage) => t('推荐', 'Referrals', lang),
  filterPending: (lang: AppLanguage) => t('待确认', 'Pending', lang),
  filterConfirmed: (lang: AppLanguage) => t('已确认', 'Confirmed', lang),
  noActivity: (lang: AppLanguage) => t('暂无动态', 'No Activity', lang),
  noActivityDesc: (lang: AppLanguage) =>
    t('符合筛选条件的交易将显示在这里。', 'Transactions matching this filter will appear here.', lang),
  noReferrals: (lang: AppLanguage) => t('暂无推荐', 'No Referrals Yet', lang),
  noReferralsDesc: (lang: AppLanguage) =>
    t(
      '在「赚取」中提交被邀请人信息，每单可获 10 积分。',
      'Submit invitee details from Earn → Start Earning to earn 10 points per referral.',
      lang
    ),
  team: (lang: AppLanguage) => t('团队', 'Team', lang),
  teamSubtitle: (lang: AppLanguage) =>
    t('组建团队，共同积累积分。', 'Build your team and grow collective points.', lang),
  directMembers: (lang: AppLanguage) => t('直推成员', 'Direct Members', lang),
  totalTeam: (lang: AppLanguage) => t('团队总人数', 'Total Team', lang),
  teamPoints: (lang: AppLanguage) => t('团队积分', 'Team Points', lang),
  teamStructure: (lang: AppLanguage) => t('团队结构', 'Team Structure', lang),
  orgChartSoon: (lang: AppLanguage) => t('组织架构即将上线', 'Org Chart Coming Soon', lang),
  orgChartDesc: (lang: AppLanguage) =>
    t('成员列表与层级将在后续更新中展示。', 'Member list and hierarchy will appear in a future update.', lang),
  inviteMembers: (lang: AppLanguage) => t('邀请成员', 'Invite Members', lang),
  inviteHint: (lang: AppLanguage) =>
    t('邀请流程上线后可分享推荐链接。', 'Share your referral link when the invite flow launches.', lang),
  inviteTitle: (lang: AppLanguage) => t('邀请', 'Invite', lang),
  inviteMessage: (lang: AppLanguage) =>
    t(
      '邀请好友加入 XRewards，通过真实业务活动赚取永久积分和月度分红。访问网站并开始赚取：https://xrewards-c0524.web.app',
      'Join me on XRewards — earn permanent points and monthly dividends from real business activities. Visit https://xrewards-c0524.web.app to start earning.',
      lang
    ),
  inviteSheetBody: (lang: AppLanguage) =>
    t('邀请好友加入团队，解锁更多赚取机会。', 'Invite friends to grow your team and unlock more earning opportunities.', lang),
  shareInvite: (lang: AppLanguage) => t('分享邀请', 'Share Invite', lang),
  done: (lang: AppLanguage) => t('完成', 'Done', lang),
  profile: (lang: AppLanguage) => t('我的', 'Profile', lang),
  memberSince: (date: string, lang: AppLanguage) => t(`加入于 ${date}`, `Member since ${date}`, lang),
  editName: (lang: AppLanguage) => t('编辑姓名', 'Edit Name', lang),
  learn: (lang: AppLanguage) => t('了解', 'Learn', lang),
  howItWorks: (lang: AppLanguage) => t('运作方式', 'How It Works', lang),
  dividends: (lang: AppLanguage) => t('分红', 'Dividends', lang),
  support: (lang: AppLanguage) => t('支持', 'Support', lang),
  rewardRules: (lang: AppLanguage) => t('奖励规则', 'Reward Rules', lang),
  faq: (lang: AppLanguage) => t('常见问题', 'FAQ', lang),
  contactSupport: (lang: AppLanguage) => t('联系支持', 'Contact Support', lang),
  settings: (lang: AppLanguage) => t('设置', 'Settings', lang),
  language: (lang: AppLanguage) => t('语言', 'Language', lang),
  signOut: (lang: AppLanguage) => t('退出登录', 'Sign Out', lang),
  exitGuest: (lang: AppLanguage) => t('退出游客模式', 'Exit Guest Mode', lang),
  displayName: (lang: AppLanguage) => t('显示名称', 'Display name', lang),
  yourName: (lang: AppLanguage) => t('您的姓名', 'Your name', lang),
  cancel: (lang: AppLanguage) => t('取消', 'Cancel', lang),
  save: (lang: AppLanguage) => t('保存', 'Save', lang),
  memberIDLabel: (id: string, lang: AppLanguage) => t(`ID：${id}`, `ID: ${id}`, lang),
  submitReferralIntro: (lang: AppLanguage) =>
    t(
      '提交您邀请的人员信息，记录后将获得 10 积分。',
      "Submit the person you invited. You'll earn 10 points once the lead is recorded.",
      lang
    ),
  fullName: (lang: AppLanguage) => t('姓名', 'Full Name', lang),
  phoneNumber: (lang: AppLanguage) => t('手机号', 'Phone Number', lang),
  emailAddress: (lang: AppLanguage) => t('邮箱地址', 'Email Address', lang),
  submitReferral: (lang: AppLanguage) => t('提交推荐', 'Submit Referral', lang),
  referralSuccess: (lang: AppLanguage) =>
    t('推荐已提交 — 10 积分已添加（待确认）', 'Referral submitted — 10 points added (pending)', lang),
  referCategory: (name: string, lang: AppLanguage) => t(`推荐 · ${name}`, `Refer ${name}`, lang),
  close: (lang: AppLanguage) => t('关闭', 'Close', lang),
  currentPeriod: (lang: AppLanguage) => t('当前周期', 'Current Period', lang),
  estimatedPayout: (lang: AppLanguage) => t('预估发放', 'Estimated Payout', lang),
  history: (lang: AppLanguage) => t('历史', 'History', lang),
  poolSize: (lang: AppLanguage) => t('奖池规模', 'Pool Size', lang),
  yourShare: (lang: AppLanguage) => t('您的份额', 'Your Share', lang),
  yourPoints: (lang: AppLanguage) => t('您的积分', 'Your Points', lang),
  settlesJuly1: (lang: AppLanguage) => t('7 月 1 日结算', 'Settles Jul 1', lang),
  dividendFormula: (lang: AppLanguage) =>
    t(
      '您的月度分红 =（您的积分 ÷ 平台总积分）× 奖励池。结算前金额为预估。',
      'Your monthly dividend = (your points ÷ total platform points) × reward pool. Amounts are estimates until settlement.',
      lang
    ),
  howItWorksSubtitle: (lang: AppLanguage) =>
    t('从行动到被动收入的路径', 'Your path from action to passive income', lang),
  fivePillars: (lang: AppLanguage) => t('五大价值支柱', 'Five Value Pillars', lang),
  stepNumber: (n: number, lang: AppLanguage) => t(`第 ${n} 步`, `Step ${n}`, lang),
  longTermRetention: (lang: AppLanguage) => t('长期留存', 'Long-Term Retention', lang),
  retentionBody: (lang: AppLanguage) =>
    t(
      '传统一次性佣金会衰减。XRewards 积分永久有效——您的奖池份额持续分红。',
      'Traditional one-time commissions fade. XRewards points stay valid — your share of the pool keeps paying.',
      lang
    ),
  traditionalLabel: (lang: AppLanguage) => t('传统模式', 'Traditional', lang),
  xrewardsLabel: (lang: AppLanguage) => t('XRewards', 'XRewards', lang),
  rewardPoolTitle: (lang: AppLanguage) => t('奖励池', 'Reward Pool', lang),
  platformProfit: (lang: AppLanguage) => t('平台利润', 'Platform Profit', lang),
  poolShareLabel: (lang: AppLanguage) => t('您的份额', 'Your Share', lang),
  poolPercentRange: (lower: number, upper: number, lang: AppLanguage) =>
    t(`${lower}–${upper}% 奖池`, `${lower}–${upper}% Pool`, lang),
  dividendFormulaShort: (lang: AppLanguage) =>
    t(
      '分红 =（您的积分 ÷ 平台总积分）× 奖励池',
      'Dividend = (your points ÷ total platform points) × reward pool',
      lang
    ),
  statusPending: (lang: AppLanguage) => t('待确认', 'Pending', lang),
  statusConfirmed: (lang: AppLanguage) => t('已确认', 'Confirmed', lang),
  statusRejected: (lang: AppLanguage) => t('已拒绝', 'Rejected', lang),
  statusEstimated: (lang: AppLanguage) => t('预估', 'Estimated', lang),
  statusProcessing: (lang: AppLanguage) => t('处理中', 'Processing', lang),
  statusPaid: (lang: AppLanguage) => t('已发放', 'Paid', lang),
  adminPortal: (lang: AppLanguage) => t('管理后台', 'Admin portal', lang),
  loading: (lang: AppLanguage) => t('加载中…', 'Loading…', lang),
  deleteAccount: (lang: AppLanguage) => t('删除账号', 'Delete Account', lang),
  deleteAccountTitle: (lang: AppLanguage) => t('确认删除账号？', 'Delete Account?', lang),
  deleteAccountMessage: (lang: AppLanguage) =>
    t(
      '此操作不可撤销。您的账号、全部积分、推荐记录和分红历史将被永久删除，且无法恢复。',
      'This cannot be undone. Your account, all points, referrals, and dividend history will be permanently deleted and cannot be recovered.',
      lang
    ),
  delete: (lang: AppLanguage) => t('删除', 'Delete', lang),
  privacyPolicy: (lang: AppLanguage) => t('隐私政策', 'Privacy Policy', lang),
  privacyPolicyAgreePrompt: (lang: AppLanguage) =>
    t('请阅读并同意我们的隐私政策以继续使用', 'Please read and agree to our Privacy Policy to continue', lang),
  privacyPolicyAgree: (lang: AppLanguage) => t('我已阅读并同意', 'I Have Read and Agree', lang),
  privacyPolicyScrollHint: (lang: AppLanguage) =>
    t('请滚动至隐私政策底部后继续', 'Please scroll to the bottom of the Privacy Policy to continue', lang),
  languageChinese: (lang: AppLanguage) => t('简体中文', 'Simplified Chinese', lang),
  languageEnglish: (lang: AppLanguage) => t('English', 'English', lang),
};
