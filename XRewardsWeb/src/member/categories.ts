import { AppLanguage, t } from '../i18n/language';
import { RevenueCategoryId } from './models';

export function categoryDisplayName(id: RevenueCategoryId, lang: AppLanguage): string {
  const names: Record<RevenueCategoryId, [string, string]> = {
    insurance: ['保险', 'Insurance'],
    loans: ['贷款', 'Loans'],
    realEstate: ['房产', 'Real Estate'],
    appEcosystem: ['应用生态', 'App Ecosystem'],
    content: ['内容创作', 'Content Creation'],
    training: ['培训活动', 'Training & Events'],
  };
  const [zh, en] = names[id];
  return t(zh, en, lang);
}

export function categorySummary(id: RevenueCategoryId, lang: AppLanguage): string {
  const summaries: Record<RevenueCategoryId, [string, string]> = {
    insurance: [
      '推荐客户或完成保险销售可获得积分，成交奖励更高。',
      'Earn points by referring customers or closing insurance policies. Higher rewards for completed sales.',
    ],
    loans: [
      '推荐贷款申请人或协助获批贷款产品，获得永久积分。',
      'Refer loan applicants or assist with approved loan products to earn permanent points.',
    ],
    realEstate: [
      '通过您的推荐完成房产交易后，积分将记入账户。',
      'Points are credited when property transactions close through your referral.',
    ],
    appEcosystem: [
      '推广合作应用——用户下载并付费订阅后可获积分。',
      'Promote partner apps — earn when users download and convert to paid subscribers.',
    ],
    content: [
      '创作并分享内容，带来有效线索与互动。',
      'Create and share content that drives qualified leads and engagement.',
    ],
    training: [
      '参加工作坊或举办培训，提升技能并赚取积分。',
      'Attend workshops or host training sessions to grow skills and earn points.',
    ],
  };
  const [zh, en] = summaries[id];
  return t(zh, en, lang);
}

export function categoryActions(
  id: RevenueCategoryId,
  lang: AppLanguage
): { name: string; range: string }[] {
  const map: Record<RevenueCategoryId, { name: [string, string]; range: string }[]> = {
    insurance: [
      { name: ['保险推荐', 'Insurance Referral'], range: '100 – 500' },
      { name: ['保险销售', 'Insurance Sale'], range: '500 – 5,000' },
    ],
    loans: [
      { name: ['贷款推荐', 'Loan Referral'], range: '200 – 1,000' },
      { name: ['贷款销售', 'Loan Sale'], range: '1,000 – 10,000' },
    ],
    realEstate: [{ name: ['房产销售', 'Property Sale'], range: '2,000 – 20,000' }],
    appEcosystem: [
      { name: ['应用下载', 'App Download'], range: '5 – 20' },
      { name: ['付费转化', 'Paid Conversion'], range: '50 – 500' },
    ],
    content: [
      { name: ['分享内容', 'Share Content'], range: '50 – 200' },
      { name: ['有效线索', 'Published Lead'], range: '200 – 1,000' },
    ],
    training: [
      { name: ['参加活动', 'Attend Event'], range: '100 – 1,000' },
      { name: ['举办培训', 'Host Training'], range: '1,000 – 5,000' },
    ],
  };
  return map[id].map((item) => ({ name: t(item.name[0], item.name[1], lang), range: item.range }));
}

export function transactionStatusLabel(status: string, lang: AppLanguage): string {
  switch (status) {
    case 'confirmed':
      return t('已确认', 'Confirmed', lang);
    case 'rejected':
      return t('已拒绝', 'Rejected', lang);
    default:
      return t('待确认', 'Pending', lang);
  }
}

export function dividendStatusLabel(status: string, lang: AppLanguage): string {
  switch (status) {
    case 'paid':
      return t('已发放', 'Paid', lang);
    case 'processing':
      return t('处理中', 'Processing', lang);
    default:
      return t('预估', 'Estimated', lang);
  }
}

export function workflowSteps(lang: AppLanguage) {
  return [
    {
      id: 1,
      title: t('行动', 'Act', lang),
      description: t(
        '推荐客户或创造价值——一次行动，永久绑定。',
        'Recommend a customer or create value — one action, permanent binding.',
        lang
      ),
      icon: '👆',
    },
    {
      id: 2,
      title: t('确认', 'Confirm', lang),
      description: t(
        '交易核实后，积分永久记入您的账户。',
        'Transaction verified; points credited permanently to your account.',
        lang
      ),
      icon: '✅',
    },
    {
      id: 3,
      title: t('奖池', 'Pool', lang),
      description: t('平台利润流入月度奖励池。', 'Platform profit flows into the monthly reward pool.', lang),
      icon: '💧',
    },
    {
      id: 4,
      title: t('分红', 'Dividend', lang),
      description: t(
        '根据您的积分占比，每月发放 payout。',
        'Monthly payout based on your share of total points.',
        lang
      ),
      icon: '💵',
    },
    {
      id: 5,
      title: t('持续', 'Sustain', lang),
      description: t(
        '积分永不过期——收入随时间持续。',
        'Points never expire — income continues over time.',
        lang
      ),
      icon: '♾️',
    },
  ];
}

export function valuePillars(lang: AppLanguage) {
  return [
    {
      title: t('赚钱', 'Make Money', lang),
      subtitle: t('每次行动都有可见收入', 'Visible income from every action', lang),
      icon: '💰',
    },
    {
      title: t('持续赚取', 'Continuous Earning', lang),
      subtitle: t('被动收入持续增长', 'Passive income that keeps growing', lang),
      icon: '📈',
    },
    {
      title: t('安全公平', 'Security & Fairness', lang),
      subtitle: t('透明规则与奖励池', 'Transparent rules and reward pool', lang),
      icon: '🛡️',
    },
    {
      title: t('归属感', 'Belonging', lang),
      subtitle: t('与团队共同成长', 'Grow together with your team', lang),
      icon: '👥',
    },
    {
      title: t('成长', 'Growth', lang),
      subtitle: t('培训与活动助力提升', 'Training and events to level up', lang),
      icon: '🚀',
    },
  ];
}
