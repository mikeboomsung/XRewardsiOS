import { httpsCallable } from 'firebase/functions';
import { functions } from '../firebase';
import type { AdminReferral, AdminTransaction, AdminUserDetail, AdminUserSummary } from '../types';

function unwrap<T>(data: unknown): T {
  if (!data || typeof data !== 'object') {
    throw new Error('Empty server response');
  }
  const payload = data as { success?: boolean; error?: { message?: string } };
  if (payload.success === false) {
    throw new Error(payload.error?.message ?? 'Request failed');
  }
  return data as T;
}

export async function checkAdminAccess(): Promise<boolean> {
  const callable = httpsCallable(functions, 'checkAdminAccess');
  const result = await callable({});
  const data = unwrap<{ success: boolean; isAdmin?: boolean }>(result.data);
  return data.isAdmin === true;
}

export async function listAdminReferrals(status: string = 'all'): Promise<AdminReferral[]> {
  const callable = httpsCallable(functions, 'listAdminReferrals');
  const result = await callable({ status, limit: 100 });
  const data = unwrap<{ referrals: AdminReferral[] }>(result.data);
  return data.referrals ?? [];
}

export async function listAdminUsers(): Promise<AdminUserSummary[]> {
  const callable = httpsCallable(functions, 'listAdminUsers');
  const result = await callable({ limit: 100 });
  const data = unwrap<{ users: AdminUserSummary[] }>(result.data);
  return data.users ?? [];
}

export async function getAdminUserDetail(userId: string): Promise<{
  user: AdminUserDetail;
  transactions: AdminTransaction[];
  referrals: AdminReferral[];
}> {
  const callable = httpsCallable(functions, 'getAdminUserDetail');
  const result = await callable({ userId });
  return unwrap(result.data);
}

export async function confirmReferral(input: {
  referrerUid: string;
  referralId: string;
  notes?: string;
  externalRef?: string;
}): Promise<void> {
  const callable = httpsCallable(functions, 'confirmReferral');
  const result = await callable(input);
  unwrap(result.data);
}

export async function awardConversionBonus(input: {
  referrerUid: string;
  referralId: string;
  points?: number;
  notes?: string;
  externalRef?: string;
}): Promise<{ conversionPoints: number }> {
  const callable = httpsCallable(functions, 'awardConversionBonus');
  const result = await callable(input);
  const data = unwrap<{ conversionPoints: number }>(result.data);
  return { conversionPoints: data.conversionPoints ?? 0 };
}
