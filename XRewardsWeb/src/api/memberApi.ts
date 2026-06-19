import { httpsCallable } from 'firebase/functions';
import { auth, functions } from '../firebase';
import type {
  DashboardSummary,
  DividendPeriod,
  PointTransaction,
  ReferralRecord,
  RevenueCategoryId,
  RewardsPayload,
  TeamSummary,
  UserProfile,
} from '../member/models';

function unwrap<T>(data: unknown): T {
  if (!data || typeof data !== 'object') {
    throw new Error('Empty server response');
  }
  const payload = data as { success?: boolean; error?: { message?: string; code?: string } };
  if (payload.success === false) {
    throw new Error(payload.error?.message ?? 'Request failed');
  }
  return data as T;
}

async function callFunction<T>(name: string, data: Record<string, unknown> = {}): Promise<T> {
  const callable = httpsCallable(functions, name);
  const result = await callable(data);
  return unwrap<T>(result.data);
}

function parseDate(value: unknown): string | null {
  if (typeof value !== 'string' || !value) return null;
  return value;
}

function parseNumber(value: unknown): number {
  if (typeof value === 'number') return value;
  if (typeof value === 'string') return Number(value) || 0;
  return 0;
}

function decodeProfile(data: Record<string, unknown> | undefined): UserProfile {
  return {
    name: (data?.name as string) ?? 'Member',
    memberID: (data?.memberID as string) ?? '—',
    memberSince: parseDate(data?.memberSince) ?? new Date().toISOString(),
  };
}

function decodeDashboard(data: Record<string, unknown> | undefined): DashboardSummary {
  const range = (data?.rewardPoolPercentRange as number[]) ?? [30, 50];
  return {
    totalPoints: parseNumber(data?.totalPoints),
    pendingPoints: parseNumber(data?.pendingPoints),
    estimatedMonthlyDividend: parseNumber(data?.estimatedMonthlyDividend),
    rewardPoolPercentRange: [range[0] ?? 30, range[1] ?? 50],
    lastSettlementDate: parseDate(data?.lastSettlementDate),
    activeCategories: ((data?.activeCategories as string[]) ?? []).filter(Boolean) as DashboardSummary['activeCategories'],
    poolAmount: parseNumber(data?.poolAmount),
    totalPlatformPoints: parseNumber(data?.totalPlatformPoints),
  };
}

function decodeTransaction(item: Record<string, unknown>): PointTransaction {
  return {
    id: (item.id as string) ?? crypto.randomUUID(),
    category: (item.category as RevenueCategoryId) ?? 'insurance',
    action: (item.action as string) ?? 'Activity',
    points: parseNumber(item.points),
    status: (item.status as PointTransaction['status']) ?? 'pending',
    createdAt: parseDate(item.createdAt) ?? new Date().toISOString(),
    confirmedAt: parseDate(item.confirmedAt),
  };
}

function decodeDividend(item: Record<string, unknown> | undefined): DividendPeriod | null {
  if (!item) return null;
  return {
    id: (item.id as string) ?? crypto.randomUUID(),
    month: parseDate(item.month) ?? new Date().toISOString(),
    poolAmount: parseNumber(item.poolAmount),
    totalPlatformPoints: parseNumber(item.totalPlatformPoints),
    userPoints: parseNumber(item.userPoints),
    userShare: parseNumber(item.userShare),
    payoutAmount: parseNumber(item.payoutAmount),
    status: (item.status as DividendPeriod['status']) ?? 'estimated',
  };
}

function decodeTeam(data: Record<string, unknown> | undefined): TeamSummary {
  return {
    directMembers: parseNumber(data?.directMembers),
    totalDownline: parseNumber(data?.totalDownline),
    teamPoints: parseNumber(data?.teamPoints),
  };
}

function decodeReferral(item: Record<string, unknown>): ReferralRecord {
  return {
    id: (item.id as string) ?? crypto.randomUUID(),
    inviteeName: (item.inviteeName as string) ?? '',
    inviteePhone: (item.inviteePhone as string) ?? '',
    inviteeEmail: (item.inviteeEmail as string) ?? '',
    category: (item.category as RevenueCategoryId) ?? 'insurance',
    pointsAwarded: parseNumber(item.pointsAwarded),
    status: (item.status as ReferralRecord['status']) ?? 'pending',
    createdAt: parseDate(item.createdAt) ?? new Date().toISOString(),
  };
}

function decodePayload(root: Record<string, unknown>): RewardsPayload {
  return {
    profile: decodeProfile(root.profile as Record<string, unknown>),
    dashboard: decodeDashboard(root.dashboard as Record<string, unknown>),
    transactions: ((root.transactions as Record<string, unknown>[]) ?? []).map(decodeTransaction),
    dividends: ((root.dividends as Record<string, unknown>[]) ?? [])
      .map((item) => decodeDividend(item))
      .filter(Boolean) as DividendPeriod[],
    currentDividend: decodeDividend(root.currentDividend as Record<string, unknown>),
    team: decodeTeam(root.team as Record<string, unknown>),
    referrals: ((root.referrals as Record<string, unknown>[]) ?? []).map(decodeReferral),
  };
}

export async function ensureUserProfile(): Promise<void> {
  const user = auth.currentUser;
  if (!user) throw new Error('Sign in to continue.');
  const payload: Record<string, unknown> = {};
  if (user.email) payload.email = user.email;
  await callFunction('createUserDocument', payload);
}

export async function fetchRewardsData(): Promise<RewardsPayload> {
  try {
    const root = await callFunction<Record<string, unknown>>('getRewardsData');
    return decodePayload(root);
  } catch (error) {
    const message = error instanceof Error ? error.message : '';
    if (message.includes('NOT_FOUND') || message.toLowerCase().includes('not found')) {
      await ensureUserProfile();
      const root = await callFunction<Record<string, unknown>>('getRewardsData');
      return decodePayload(root);
    }
    throw error;
  }
}

export async function submitReferral(input: {
  category: RevenueCategoryId;
  inviteeName: string;
  inviteePhone: string;
  inviteeEmail: string;
}): Promise<number> {
  await ensureUserProfile();
  const data = await callFunction<{ pointsAwarded?: number }>('submitReferral', input);
  return data.pointsAwarded ?? 10;
}

export async function updateDisplayName(displayName: string): Promise<string> {
  await ensureUserProfile();
  const data = await callFunction<{ displayName?: string }>('updateProfile', { displayName: displayName.trim() });
  return data.displayName ?? displayName.trim();
}

export async function deleteAccount(): Promise<void> {
  await callFunction('deleteUserAccount');
}
