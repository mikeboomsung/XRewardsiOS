import { AppLanguage, t } from '../i18n/language';

export interface ContentSection {
  title: string;
  paragraphs: string[];
  bullets?: string[];
}

export interface FaqItem {
  question: string;
  answer: string;
}

function sections(
  lang: AppLanguage,
  zh: ContentSection[],
  en: ContentSection[]
): ContentSection[] {
  return lang === 'zh' ? zh : en;
}

function faqItems(lang: AppLanguage, zh: FaqItem[], en: FaqItem[]): FaqItem[] {
  return lang === 'zh' ? zh : en;
}

export function rewardRulesContent(lang: AppLanguage): ContentSection[] {
  return sections(lang, [
    {
      title: '积分基本原则',
      paragraphs: [
        'XRewards 积分代表您在平台真实业务活动中的永久贡献。积分累计、不过期、不重置。',
        '每笔经核实的推荐或成交都会永久绑定到您的会员账户。',
      ],
    },
    {
      title: '推荐积分',
      paragraphs: ['在「赚取」中提交被邀请人信息后：'],
      bullets: [
        '每单有效推荐可获得 10 积分（初始为待确认状态）',
        '运营团队核实线索后，积分转为已确认',
        '若被邀请人完成购买或签约，可额外获得成交奖励积分',
      ],
    },
    {
      title: '成交奖励（参考值）',
      paragraphs: ['不同业务类别的成交奖励范围如下，具体以运营审核为准：'],
      bullets: [
        '保险：约 2,500 积分',
        '贷款：约 1,000 积分',
        '房产：约 10,000 积分',
        '应用生态：约 200 积分',
        '内容创作：约 500 积分',
        '培训活动：约 1,000 积分',
      ],
    },
    {
      title: '月度分红',
      paragraphs: [
        '平台将每月一定比例的利润（约 30%–50%）注入奖励池。',
        '您的月度分红 =（您的积分 ÷ 平台总积分）× 当月奖励池。',
        '结算前显示为预估金额，正式结算后更新为已发放。',
      ],
    },
    {
      title: '状态说明',
      paragraphs: [],
      bullets: [
        '待确认：已记录，等待运营核实',
        '已确认：积分已计入您的永久余额',
        '已拒绝：未通过审核（如有疑问请联系支持）',
      ],
    },
    {
      title: '游客模式',
      paragraphs: [
        '游客模式仅供预览全部功能，无法赚取、保存或提交真实推荐。',
        '注册或登录后即可开始积累永久积分。',
      ],
    },
  ], [
    {
      title: 'Core point rules',
      paragraphs: [
        'XRewards points represent your permanent contribution from real business activities. Points accumulate, never expire, and never reset.',
        'Each verified referral or closed deal is permanently bound to your member account.',
      ],
    },
    {
      title: 'Referral points',
      paragraphs: ['When you submit invitee details from Earn:'],
      bullets: [
        'Each valid referral earns 10 points (initially pending)',
        'Ops verifies the lead, then points move to confirmed',
        'If the invitee converts, you may receive an additional conversion bonus',
      ],
    },
    {
      title: 'Conversion bonuses (reference)',
      paragraphs: ['Typical conversion awards by category — final amounts set by ops review:'],
      bullets: [
        'Insurance: ~2,500 points',
        'Loans: ~1,000 points',
        'Real Estate: ~10,000 points',
        'App Ecosystem: ~200 points',
        'Content: ~500 points',
        'Training: ~1,000 points',
      ],
    },
    {
      title: 'Monthly dividends',
      paragraphs: [
        'A portion of platform profit (roughly 30–50%) flows into the monthly reward pool.',
        'Your dividend = (your points ÷ total platform points) × reward pool.',
        'Amounts are estimates until settlement; paid status appears after payout.',
      ],
    },
    {
      title: 'Status meanings',
      paragraphs: [],
      bullets: [
        'Pending: recorded, awaiting ops verification',
        'Confirmed: credited to your permanent balance',
        'Rejected: not approved (contact support if you have questions)',
      ],
    },
    {
      title: 'Guest mode',
      paragraphs: [
        'Guest mode lets you preview all features but cannot earn, save, or submit real referrals.',
        'Sign up or sign in to start earning permanent points.',
      ],
    },
  ]);
}

export function faqContent(lang: AppLanguage): FaqItem[] {
  return faqItems(lang, [
    {
      question: '如何开始赚取积分？',
      answer:
        '注册或登录后，进入「赚取」选择业务类别，提交被邀请人信息即可开始。每单有效推荐可获得 10 积分（待确认）。',
    },
    {
      question: '积分什么时候变为已确认？',
      answer:
        '提交推荐后积分先显示为「待确认」。运营团队核实线索真实性后，会将状态更新为「已确认」并计入您的总积分。',
    },
    {
      question: '分红如何计算？',
      answer:
        '月度分红 =（您的积分 ÷ 平台总积分）× 当月奖励池。奖励池来自平台利润的一定比例。结算前金额为预估，正式结算后更新。',
    },
    {
      question: '积分会过期吗？',
      answer: '不会。XRewards 积分永久有效，持续参与月度分红计算。',
    },
    {
      question: '游客模式是什么？',
      answer:
        '游客模式使用匿名登录，可浏览全部功能和使用演示数据，但无法提交真实推荐或赚取积分。登录正式账户后即可开始赚取。',
    },
    {
      question: '如何邀请团队成员？',
      answer:
        '在「团队」页面可查看团队统计并分享邀请信息。完整的推荐链接功能将在后续版本上线。',
    },
    {
      question: '网站和 App 数据是否同步？',
      answer:
        '是的。使用同一 Firebase 账户登录 iOS App 或网站，积分、推荐记录和分红数据保持一致。',
    },
    {
      question: '对积分或分红有疑问怎么办？',
      answer:
        '请通过「联系支持」发送邮件，附上您的会员 ID、注册邮箱和问题描述，我们会尽快回复。',
    },
  ], [
    {
      question: 'How do I start earning points?',
      answer:
        'Sign up or sign in, go to Earn, pick a category, and submit invitee details. Each valid referral earns 10 points (pending).',
    },
    {
      question: 'When do points become confirmed?',
      answer:
        'Referrals start as Pending. After ops verifies the lead, status updates to Confirmed and points count toward your total balance.',
    },
    {
      question: 'How are dividends calculated?',
      answer:
        'Monthly dividend = (your points ÷ total platform points) × reward pool. The pool comes from a share of platform profit. Amounts are estimates until settlement.',
    },
    {
      question: 'Do points expire?',
      answer: 'No. XRewards points are permanent and continue to participate in monthly dividend calculations.',
    },
    {
      question: 'What is guest mode?',
      answer:
        'Guest mode uses anonymous sign-in so you can preview all features with demo data, but you cannot submit real referrals or earn points. Sign in with a full account to start earning.',
    },
    {
      question: 'How do I invite team members?',
      answer:
        'Open Team to see stats and share an invite message. Full referral-link flows will launch in a future update.',
    },
    {
      question: 'Are the website and iOS app in sync?',
      answer:
        'Yes. Sign in with the same Firebase account on iOS or the web — points, referrals, and dividend data stay aligned.',
    },
    {
      question: 'Who do I contact about a points or dividend issue?',
      answer:
        'Use Contact Support and email us with your member ID, account email, and a short description. We will respond as soon as possible.',
    },
  ]);
}

export function contactSupportContent(lang: AppLanguage) {
  return {
    intro: t(
      '如有账户、积分、推荐或分红相关问题，欢迎联系我们的支持团队。',
      'For account, points, referral, or dividend questions, reach out to our support team.',
      lang
    ),
    email: 'support@xrewards.app',
    responseTime: t(
      '我们通常会在 1–2 个工作日内回复（节假日可能略有延迟）。',
      'We typically reply within 1–2 business days (slightly longer on holidays).',
      lang
    ),
    includeTitle: t('请在邮件中提供', 'Please include', lang),
    includeItems: lang === 'zh'
      ? ['您的会员 ID（在「我的」页面查看）', '注册邮箱', '问题简述及相关截图（如有）']
      : ['Your member ID (on Profile)', 'Account email', 'A short description and screenshots if helpful'],
    hoursTitle: t('支持时间', 'Support hours', lang),
    hours: t(
      '周一至周五，9:00–18:00（太平洋时间）',
      'Monday–Friday, 9:00 AM–6:00 PM Pacific Time',
      lang
    ),
    urgentNote: t(
      '涉及账户安全的问题，请在邮件标题注明「紧急」。',
      'For urgent account security issues, put "Urgent" in the email subject line.',
      lang
    ),
  };
}

export function contentUpdatedLabel(lang: AppLanguage): string {
  return t('内容可能随时更新', 'Content may be updated at any time', lang);
}
