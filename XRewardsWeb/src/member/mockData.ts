import { AppLanguage } from '../i18n/language';
import { L10n } from '../i18n/l10n';
import type { RewardsPayload } from './models';

function iso(year: number, month: number, day: number): string {
  return new Date(Date.UTC(year, month - 1, day)).toISOString();
}

export function buildGuestPreview(language: AppLanguage): RewardsPayload {
  return {
    profile: {
      name: L10n.guestProfileName(language),
      memberID: L10n.guestMemberID(language),
      memberSince: iso(2025, 3, 15),
    },
    dashboard: {
      totalPoints: 12450,
      pendingPoints: 800,
      estimatedMonthlyDividend: 186.75,
      rewardPoolPercentRange: [30, 50],
      lastSettlementDate: iso(2026, 6, 1),
      activeCategories: ['insurance', 'appEcosystem', 'loans'],
      poolAmount: 7500,
      totalPlatformPoints: 500000,
    },
    transactions: [
      {
        id: 'tx-1',
        category: 'insurance',
        action: 'Insurance Sale',
        points: 2500,
        status: 'confirmed',
        createdAt: iso(2026, 6, 1),
        confirmedAt: iso(2026, 6, 2),
      },
      {
        id: 'tx-2',
        category: 'appEcosystem',
        action: 'App Paid User',
        points: 200,
        status: 'confirmed',
        createdAt: iso(2026, 6, 10),
        confirmedAt: iso(2026, 6, 10),
      },
      {
        id: 'tx-3',
        category: 'loans',
        action: 'Loan Referral',
        points: 500,
        status: 'pending',
        createdAt: iso(2026, 6, 14),
        confirmedAt: null,
      },
    ],
    currentDividend: {
      id: 'div-current',
      month: iso(2026, 6, 1),
      poolAmount: 7500,
      totalPlatformPoints: 500000,
      userPoints: 12450,
      userShare: 0.0249,
      payoutAmount: 186.75,
      status: 'estimated',
    },
    dividends: [
      {
        id: 'div-1',
        month: iso(2026, 5, 1),
        poolAmount: 6800,
        totalPlatformPoints: 485000,
        userPoints: 11200,
        userShare: 0.0231,
        payoutAmount: 157.08,
        status: 'paid',
      },
      {
        id: 'div-2',
        month: iso(2026, 4, 1),
        poolAmount: 6200,
        totalPlatformPoints: 460000,
        userPoints: 9800,
        userShare: 0.0213,
        payoutAmount: 132.06,
        status: 'paid',
      },
    ],
    team: {
      directMembers: 8,
      totalDownline: 34,
      teamPoints: 48200,
    },
    referrals: [
      {
        id: 'ref-1',
        inviteeName: 'Jane Doe',
        inviteePhone: '+1 555-0100',
        inviteeEmail: 'jane@example.com',
        category: 'insurance',
        pointsAwarded: 10,
        status: 'pending',
        createdAt: iso(2026, 6, 12),
      },
      {
        id: 'ref-2',
        inviteeName: 'Bob Smith',
        inviteePhone: '+1 555-0101',
        inviteeEmail: 'bob@example.com',
        category: 'loans',
        pointsAwarded: 10,
        status: 'confirmed',
        createdAt: iso(2026, 6, 5),
      },
    ],
  };
}

export function emptyMemberPayload(): RewardsPayload {
  return {
    profile: { name: 'Member', memberID: '—', memberSince: new Date().toISOString() },
    dashboard: {
      totalPoints: 0,
      pendingPoints: 0,
      estimatedMonthlyDividend: 0,
      rewardPoolPercentRange: [30, 50],
      lastSettlementDate: null,
      activeCategories: [],
      poolAmount: 0,
      totalPlatformPoints: 0,
    },
    transactions: [],
    dividends: [],
    currentDividend: null,
    team: { directMembers: 0, totalDownline: 0, teamPoints: 0 },
    referrals: [],
  };
}
