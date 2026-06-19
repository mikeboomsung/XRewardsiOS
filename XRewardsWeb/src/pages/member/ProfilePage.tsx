import { FormEvent, useState } from 'react';
import { Link } from 'react-router-dom';
import { signOut } from 'firebase/auth';
import { deleteAccount, updateDisplayName } from '../../api/memberApi';
import { CurrentLanguageLabel, LanguageToggle } from '../../components/member/MemberUi';
import { auth } from '../../firebase';
import { useLanguage } from '../../i18n/LanguageProvider';
import { L10n } from '../../i18n/l10n';
import { formatDate } from '../../member/format';
import { useRewards } from '../../member/RewardsContext';
import { deriveSession } from '../../member/session';

export function ProfilePage() {
  const { lang } = useLanguage();
  const { data, usesLiveData, reload, clear } = useRewards();
  const session = deriveSession(auth.currentUser);

  const [editingName, setEditingName] = useState(false);
  const [name, setName] = useState('');
  const [nameError, setNameError] = useState<string | null>(null);
  const [saving, setSaving] = useState(false);
  const [signingOut, setSigningOut] = useState(false);
  const [showDeleteConfirm, setShowDeleteConfirm] = useState(false);
  const [deletingAccount, setDeletingAccount] = useState(false);
  const [deleteError, setDeleteError] = useState<string | null>(null);

  if (!data) {
    return <p className="muted center">{L10n.loading(lang)}</p>;
  }

  const profile = data.profile;

  async function handleSaveName(event: FormEvent) {
    event.preventDefault();
    if (name.trim().length < 2) return;
    setSaving(true);
    setNameError(null);
    try {
      await updateDisplayName(name);
      await reload();
      setEditingName(false);
    } catch (err) {
      setNameError(err instanceof Error ? err.message : 'Save failed');
    } finally {
      setSaving(false);
    }
  }

  async function handleDeleteAccount() {
    setDeletingAccount(true);
    setDeleteError(null);
    try {
      clear();
      await deleteAccount();
      await signOut(auth);
    } catch (err) {
      setDeleteError(err instanceof Error ? err.message : 'Delete failed');
    } finally {
      setDeletingAccount(false);
      setShowDeleteConfirm(false);
    }
  }

  async function handleSignOut() {
    setSigningOut(true);
    clear();
    await signOut(auth);
    setSigningOut(false);
  }

  return (
    <div className="member-page">
      <h2 className="page-title">{L10n.profile(lang)}</h2>

      <div className="card profile-card">
        <div className="profile-avatar" aria-hidden>
          👤
        </div>
        <div>
          <h3>{profile.name}</h3>
          {session.isGuest ? <p className="guest-label">{L10n.guestAccountLabel(lang)}</p> : null}
          <p className="muted small">{L10n.memberIDLabel(profile.memberID, lang)}</p>
          {!session.isGuest ? (
            <p className="muted small">{L10n.memberSince(formatDate(profile.memberSince), lang)}</p>
          ) : null}
        </div>
      </div>

      {usesLiveData && !session.isGuest ? (
        <button
          className="btn full"
          type="button"
          onClick={() => {
            setName(profile.name === 'Member' ? '' : profile.name);
            setEditingName(true);
          }}
        >
          {L10n.editName(lang)}
        </button>
      ) : null}

      {session.isGuest ? (
        <button className="btn primary full" type="button" onClick={() => void handleSignOut()}>
          {L10n.signInToEarn(lang)}
        </button>
      ) : null}

      <section className="profile-section">
        <h4>{L10n.learn(lang)}</h4>
        <Link className="card link-card" to="/how-it-works">
          {L10n.howItWorks(lang)} <span>›</span>
        </Link>
        <Link className="card link-card" to="/dividends">
          {L10n.dividends(lang)} <span>›</span>
        </Link>
      </section>

      <section className="profile-section">
        <h4>{L10n.support(lang)}</h4>
        <a
          className="card link-card"
          href={lang === 'zh' ? '/support.html' : '/support-en.html'}
          target="_blank"
          rel="noreferrer"
        >
          {L10n.support(lang)} <span>↗</span>
        </a>
        <a
          className="card link-card"
          href={lang === 'zh' ? '/privacy-policy.html' : '/privacy-policy-en.html'}
          target="_blank"
          rel="noreferrer"
        >
          {L10n.privacyPolicy(lang)} <span>↗</span>
        </a>
        <Link className="card link-card" to="/reward-rules">
          {L10n.rewardRules(lang)} <span>›</span>
        </Link>
        <Link className="card link-card" to="/faq">
          {L10n.faq(lang)} <span>›</span>
        </Link>
        <Link className="card link-card" to="/contact">
          {L10n.contactSupport(lang)} <span>›</span>
        </Link>
      </section>

      <section className="profile-section">
        <h4>{L10n.settings(lang)}</h4>
        <div className="card row-between">
          <span>{L10n.language(lang)}</span>
          <div className="row gap-sm">
            <CurrentLanguageLabel />
            <LanguageToggle />
          </div>
        </div>
        {session.isMember ? (
          <button
            className="btn danger full"
            type="button"
            disabled={deletingAccount}
            onClick={() => setShowDeleteConfirm(true)}
          >
            {L10n.deleteAccount(lang)}
          </button>
        ) : null}
        <Link className="card link-card muted" to="/admin">
          {L10n.adminPortal(lang)} <span>›</span>
        </Link>
        <button className="btn danger full" type="button" disabled={signingOut} onClick={() => void handleSignOut()}>
          {session.isGuest ? L10n.exitGuest(lang) : L10n.signOut(lang)}
        </button>
      </section>

      {showDeleteConfirm ? (
        <div className="modal-backdrop" role="presentation" onClick={() => setShowDeleteConfirm(false)}>
          <div className="modal card" role="dialog" onClick={(e) => e.stopPropagation()}>
            <h3>{L10n.deleteAccountTitle(lang)}</h3>
            <p className="content-body">{L10n.deleteAccountMessage(lang)}</p>
            {deleteError ? <p className="error">{deleteError}</p> : null}
            <div className="btn-row">
              <button className="btn" type="button" onClick={() => setShowDeleteConfirm(false)}>
                {L10n.cancel(lang)}
              </button>
              <button
                className="btn danger"
                type="button"
                disabled={deletingAccount}
                onClick={() => void handleDeleteAccount()}
              >
                {deletingAccount ? L10n.loading(lang) : L10n.delete(lang)}
              </button>
            </div>
          </div>
        </div>
      ) : null}

      {editingName ? (
        <div className="modal-backdrop" role="presentation" onClick={() => setEditingName(false)}>
          <div className="modal card" role="dialog" onClick={(e) => e.stopPropagation()}>
            <h3>{L10n.editName(lang)}</h3>
            <form onSubmit={handleSaveName}>
              <label className="field">
                {L10n.displayName(lang)}
                <input value={name} onChange={(e) => setName(e.target.value)} required />
              </label>
              {nameError ? <p className="error">{nameError}</p> : null}
              <div className="btn-row">
                <button className="btn" type="button" onClick={() => setEditingName(false)}>
                  {L10n.cancel(lang)}
                </button>
                <button className="btn primary" type="submit" disabled={saving || name.trim().length < 2}>
                  {L10n.save(lang)}
                </button>
              </div>
            </form>
          </div>
        </div>
      ) : null}
    </div>
  );
}
