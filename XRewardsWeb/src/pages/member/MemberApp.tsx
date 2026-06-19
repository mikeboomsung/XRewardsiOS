import { useEffect, useState } from 'react';
import { Navigate, Route, Routes } from 'react-router-dom';
import { onAuthStateChanged, User } from 'firebase/auth';
import { auth } from '../../firebase';
import { MemberLayout } from '../../components/member/MemberLayout';
import { RewardsProvider } from '../../member/RewardsContext';
import { deriveSession } from '../../member/session';
import { useLanguage } from '../../i18n/LanguageProvider';
import { L10n } from '../../i18n/l10n';
import { AuthPage } from './AuthPage';
import { HomePage } from './HomePage';
import { EarnPage } from './EarnPage';
import { CategoryDetailPage } from './CategoryDetailPage';
import { ActivityPage } from './ActivityPage';
import { TeamPage } from './TeamPage';
import { ProfilePage } from './ProfilePage';
import { HowItWorksPage } from './HowItWorksPage';
import { DividendsPage } from './DividendsPage';
import { RewardRulesPage } from './RewardRulesPage';
import { FaqPage } from './FaqPage';
import { ContactSupportPage } from './ContactSupportPage';
import { PrivacyConsentPage } from './PrivacyConsentPage';

const PRIVACY_ACCEPTED_KEY = 'xrewards.privacy.accepted';

function readPrivacyAccepted(): boolean {
  return localStorage.getItem(PRIVACY_ACCEPTED_KEY) === 'true';
}

export function MemberApp() {
  const { lang } = useLanguage();
  const [user, setUser] = useState<User | null | undefined>(undefined);
  const [hasAcceptedPrivacy, setHasAcceptedPrivacy] = useState(readPrivacyAccepted);

  useEffect(() => {
    return onAuthStateChanged(auth, setUser);
  }, []);

  if (!hasAcceptedPrivacy) {
    return (
      <PrivacyConsentPage
        onAgree={() => {
          localStorage.setItem(PRIVACY_ACCEPTED_KEY, 'true');
          setHasAcceptedPrivacy(true);
        }}
      />
    );
  }

  if (user === undefined) {
    return (
      <div className="login-page">
        <p className="muted">{L10n.preparingConnection(lang)}</p>
      </div>
    );
  }

  const session = deriveSession(user);

  if (!session.canUseApp) {
    return <AuthPage />;
  }

  return (
    <RewardsProvider isGuest={session.isGuest} isMember={session.isMember}>
      <Routes>
        <Route element={<MemberLayout />}>
          <Route index element={<HomePage />} />
          <Route path="earn" element={<EarnPage />} />
          <Route path="earn/:categoryId" element={<CategoryDetailPage />} />
          <Route path="activity" element={<ActivityPage />} />
          <Route path="team" element={<TeamPage />} />
          <Route path="profile" element={<ProfilePage />} />
          <Route path="how-it-works" element={<HowItWorksPage />} />
          <Route path="dividends" element={<DividendsPage />} />
          <Route path="reward-rules" element={<RewardRulesPage />} />
          <Route path="faq" element={<FaqPage />} />
          <Route path="contact" element={<ContactSupportPage />} />
          <Route path="*" element={<Navigate to="/" replace />} />
        </Route>
      </Routes>
    </RewardsProvider>
  );
}
