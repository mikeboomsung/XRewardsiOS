import { FormEvent, useState } from 'react';
import {
  createUserWithEmailAndPassword,
  signInAnonymously,
  signInWithEmailAndPassword,
  signInWithPopup,
  GoogleAuthProvider,
} from 'firebase/auth';
import { auth } from '../../firebase';
import { ensureAppCheckToken } from '../../appCheck';
import { LanguageToggle } from '../../components/member/MemberUi';
import { PublicLegalLinks } from '../../components/member/PublicLegalLinks';
import { useLanguage } from '../../i18n/LanguageProvider';
import { L10n } from '../../i18n/l10n';

export function AuthPage() {
  const { lang } = useLanguage();
  const [showSignUp, setShowSignUp] = useState(false);
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [error, setError] = useState<string | null>(null);
  const [loading, setLoading] = useState(false);

  async function withAuth<T>(action: () => Promise<T>): Promise<T> {
    setLoading(true);
    setError(null);
    try {
      await ensureAppCheckToken();
      return await action();
    } catch (err) {
      const message = err instanceof Error ? err.message : 'Authentication failed';
      setError(message);
      throw err;
    } finally {
      setLoading(false);
    }
  }

  async function handleEmailSubmit(event: FormEvent) {
    event.preventDefault();
    if (showSignUp && password !== confirmPassword) {
      setError(lang === 'zh' ? '两次密码不一致' : 'Passwords do not match');
      return;
    }
    await withAuth(async () => {
      if (showSignUp) {
        await createUserWithEmailAndPassword(auth, email.trim(), password);
      } else {
        await signInWithEmailAndPassword(auth, email.trim(), password);
      }
    });
  }

  async function handleGoogle() {
    await withAuth(async () => {
      await signInWithPopup(auth, new GoogleAuthProvider());
    });
  }

  async function handleGuest() {
    await withAuth(async () => {
      if (!auth.currentUser) {
        await signInAnonymously(auth);
      }
    }).catch(() => {
      setError(L10n.guestSignInFailed(lang));
    });
  }

  return (
    <div className="login-page member-auth">
      <div className="auth-wrap">
        <div className="auth-top">
          <div />
          <LanguageToggle />
        </div>

        <div className="auth-hero">
          <h1>
            <span>XRewards</span>
          </h1>
          <p className="muted">{L10n.authTagline(lang)}</p>
          <p className="auth-promo">{L10n.authPromo(lang)}</p>
        </div>

        <p className="guest-notice">{L10n.authGuestNotice(lang)}</p>

        <div className="card login-card">
          <form onSubmit={handleEmailSubmit}>
            <label className="field">
              {L10n.email(lang)}
              <input
                type="email"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                autoComplete="username"
                required
              />
            </label>
            <label className="field">
              {L10n.password(lang)}
              <input
                type="password"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                autoComplete={showSignUp ? 'new-password' : 'current-password'}
                required
              />
            </label>

          {showSignUp ? (
              <label className="field">
                {L10n.confirmPassword(lang)}
                <input
                  type="password"
                  value={confirmPassword}
                  onChange={(e) => setConfirmPassword(e.target.value)}
                  autoComplete="new-password"
                  required
                />
              </label>
            ) : null}

            <button className="btn primary full" type="submit" disabled={loading}>
              {loading ? L10n.loading(lang) : showSignUp ? L10n.signUp(lang) : L10n.signIn(lang)}
            </button>
          </form>

          <div className="or-divider">
            <span>{L10n.orDivider(lang)}</span>
          </div>

          <div className="stack gap-sm">
            <button className="btn full" type="button" disabled={loading} onClick={() => void handleGoogle()}>
              {L10n.continueWithGoogle(lang)}
            </button>
            <button className="btn full" type="button" disabled={loading} onClick={() => void handleGuest()}>
              {L10n.continueAsGuest(lang)}
            </button>
          </div>

          <button
            className="link-btn"
            type="button"
            onClick={() => {
              setShowSignUp((v) => !v);
              setError(null);
            }}
          >
            {showSignUp ? L10n.hasAccountSignIn(lang) : L10n.noAccountSignUp(lang)}
          </button>

          {error ? <p className="error">{error}</p> : null}
        </div>

        <PublicLegalLinks className="auth-legal-links" />
      </div>
    </div>
  );
}
