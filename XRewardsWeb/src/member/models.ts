export type RevenueCategoryId =
  | 'insurance'
  | 'loans'
  | 'realEstate'
  | 'appEcosystem'
  | 'content'
  | 'training';

export type TransactionStatus = 'pending' | 'confirmed' | 'rejected';
export type DividendStatus = 'estimated' | 'processing' | 'paid';

export interface UserProfile {
  name: string;
  memberID: string;
  memberSince: string;
}

export interface DashboardSummary {
  totalPoints: number;
  pendingPoints: number;
  estimatedMonthlyDividend: number;
  rewardPoolPercentRange: [number, number];
  lastSettlementDate: string | null;
  activeCategories: RevenueCategoryId[];
  poolAmount: number;
  totalPlatformPoints: number;
}

export interface PointTransaction {
  id: string;
  category: RevenueCategoryId;
  action: string;
  points: number;
  status: TransactionStatus;
  createdAt: string;
  confirmedAt: string | null;
}

export interface DividendPeriod {
  id: string;
  month: string;
  poolAmount: number;
  totalPlatformPoints: number;
  userPoints: number;
  userShare: number;
  payoutAmount: number;
  status: DividendStatus;
}

export interface TeamSummary {
  directMembers: number;
  totalDownline: number;
  teamPoints: number;
}

export interface ReferralRecord {
  id: string;
  inviteeName: string;
  inviteePhone: string;
  inviteeEmail: string;
  category: RevenueCategoryId;
  pointsAwarded: number;
  status: TransactionStatus;
  createdAt: string;
}

export interface RewardsPayload {
  profile: UserProfile;
  dashboard: DashboardSummary;
  transactions: PointTransaction[];
  dividends: DividendPeriod[];
  currentDividend: DividendPeriod | null;
  team: TeamSummary;
  referrals: ReferralRecord[];
}

export const REVENUE_CATEGORIES: RevenueCategoryId[] = [
  'insurance',
  'loans',
  'realEstate',
  'appEcosystem',
  'content',
  'training',
];

export const CATEGORY_ICONS: Record<RevenueCategoryId, string> = {
  insurance: '☂️',
  loans: '🏛️',
  realEstate: '🏠',
  appEcosystem: '📱',
  content: '✏️',
  training: '👥',
};

export const CATEGORY_POINT_RANGES: Record<RevenueCategoryId, string> = {
  insurance: '100 – 5,000',
  loans: '200 – 10,000',
  realEstate: '2,000 – 20,000',
  appEcosystem: '5 – 500',
  content: '50 – 1,000',
  training: '100 – 5,000',
};

export function isRevenueCategoryId(value: string): value is RevenueCategoryId {
  return (REVENUE_CATEGORIES as string[]).includes(value);
}
