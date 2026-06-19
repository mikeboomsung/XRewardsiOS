import { User } from 'firebase/auth';

export interface SessionState {
  isGuest: boolean;
  isMember: boolean;
  canUseApp: boolean;
}

export function deriveSession(user: User | null): SessionState {
  if (!user) {
    return { isGuest: false, isMember: false, canUseApp: false };
  }
  const isGuest = user.isAnonymous;
  const isMember = !isGuest && (user.emailVerified || Boolean(user.providerData.some((p) => p.providerId === 'google.com')));
  return {
    isGuest,
    isMember,
    canUseApp: isGuest || isMember,
  };
}
