export type ReferralStatus = 'pending' | 'confirmed' | 'converted' | 'rejected';

export interface AdminReferral {
  id: string;
  referralId: string;
  referrerUid: string;
  referrerEmail: string | null;
  referrerMemberId: string | null;
  referrerDisplayName: string | null;
  inviteeName: string;
  inviteePhone: string;
  inviteeEmail: string;
  category: string;
  leadPoints: number;
  conversionPoints: number;
  status: ReferralStatus;
  createdAt: string | null;
  confirmedAt: string | null;
  convertedAt: string | null;
  externalRef: string | null;
  notes: string | null;
}

export interface AdminUserSummary {
  uid: string;
  email: string | null;
  displayName: string | null;
  memberId: string | null;
  memberSince: string | null;
  points: {
    total: number;
    pending: number;
    confirmed: number;
  };
  updatedAt: string | null;
}

export interface AdminTransaction {
  id: string;
  category: string;
  action: string;
  points: number;
  status: string;
  createdAt: string | null;
  confirmedAt: string | null;
  referralId: string | null;
}

export interface AdminUserDetail {
  uid: string;
  email: string | null;
  displayName: string | null;
  memberId: string | null;
  memberSince: string | null;
  points: {
    total: number;
    pending: number;
    confirmed: number;
  };
}
