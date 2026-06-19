import { FormEvent, useState } from 'react';
import { Link, useParams } from 'react-router-dom';
import { submitReferral } from '../../api/memberApi';
import { useLanguage } from '../../i18n/LanguageProvider';
import { L10n } from '../../i18n/l10n';
import {
  categoryActions,
  categoryDisplayName,
  categorySummary,
} from '../../member/categories';
import { CATEGORY_ICONS, CATEGORY_POINT_RANGES, isRevenueCategoryId } from '../../member/models';
import { useRewards } from '../../member/RewardsContext';
import { deriveSession } from '../../member/session';
import { auth } from '../../firebase';

export function CategoryDetailPage() {
  const { categoryId = '' } = useParams();
  const { lang } = useLanguage();
  const { reload } = useRewards();
  const session = deriveSession(auth.currentUser);

  const [showForm, setShowForm] = useState(false);
  const [showGuestAlert, setShowGuestAlert] = useState(false);
  const [name, setName] = useState('');
  const [phone, setPhone] = useState('');
  const [email, setEmail] = useState('');
  const [error, setError] = useState<string | null>(null);
  const [success, setSuccess] = useState(false);
  const [submitting, setSubmitting] = useState(false);

  if (!isRevenueCategoryId(categoryId)) {
    return (
      <div className="member-page">
        <p className="error">Unknown category</p>
        <Link to="/earn">← {L10n.earnTitle(lang)}</Link>
      </div>
    );
  }

  const category = categoryId;
  const actions = categoryActions(category, lang);
  const isFormValid =
    name.trim().length >= 2 && phone.replace(/\D/g, '').length >= 7 && email.includes('@');

  async function handleSubmit(event: FormEvent) {
    event.preventDefault();
    if (!isFormValid) return;
    setSubmitting(true);
    setError(null);
    try {
      await submitReferral({
        category,
        inviteeName: name.trim(),
        inviteePhone: phone,
        inviteeEmail: email.trim().toLowerCase(),
      });
      setSuccess(true);
      await reload();
      setTimeout(() => {
        setShowForm(false);
        setSuccess(false);
        setName('');
        setPhone('');
        setEmail('');
      }, 900);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Submit failed');
    } finally {
      setSubmitting(false);
    }
  }

  return (
    <div className="member-page">
      <Link className="back-link" to="/earn">
        ← {L10n.earnTitle(lang)}
      </Link>

      <div className="category-hero">
        <span className="category-icon large">{CATEGORY_ICONS[category]}</span>
        <div>
          <h2>{categoryDisplayName(category, lang)}</h2>
          <p className="muted">{CATEGORY_POINT_RANGES[category]} pts</p>
        </div>
      </div>

      <p className="muted">{categorySummary(category, lang)}</p>

      <h3>{L10n.pointTable(lang)}</h3>
      <div className="stack gap-sm">
        {actions.map((action) => (
          <div className="card row-between" key={action.name}>
            <span>{action.name}</span>
            <strong className="gold">{action.range} pts</strong>
          </div>
        ))}
      </div>

      <button
        className="btn primary full"
        type="button"
        onClick={() => {
          if (session.isGuest) setShowGuestAlert(true);
          else setShowForm(true);
        }}
      >
        {L10n.startEarning(lang)}
      </button>
      <p className="muted small center">{L10n.submitReferralHint(lang)}</p>

      {showGuestAlert ? (
        <div className="modal-backdrop" role="presentation" onClick={() => setShowGuestAlert(false)}>
          <div className="modal card" role="dialog" onClick={(e) => e.stopPropagation()}>
            <p>{L10n.guestCannotEarn(lang)}</p>
            <button className="btn primary" type="button" onClick={() => setShowGuestAlert(false)}>
              {L10n.ok(lang)}
            </button>
          </div>
        </div>
      ) : null}

      {showForm ? (
        <div className="modal-backdrop" role="presentation" onClick={() => setShowForm(false)}>
          <div className="modal card wide" role="dialog" onClick={(e) => e.stopPropagation()}>
            <h3>{L10n.referCategory(categoryDisplayName(category, lang), lang)}</h3>
            <p className="muted">{L10n.submitReferralIntro(lang)}</p>
            <form className="stack gap-sm" onSubmit={handleSubmit}>
              <label className="field">
                {L10n.fullName(lang)}
                <input value={name} onChange={(e) => setName(e.target.value)} required />
              </label>
              <label className="field">
                {L10n.phoneNumber(lang)}
                <input value={phone} onChange={(e) => setPhone(e.target.value)} required />
              </label>
              <label className="field">
                {L10n.emailAddress(lang)}
                <input type="email" value={email} onChange={(e) => setEmail(e.target.value)} required />
              </label>
              {error ? <p className="error">{error}</p> : null}
              {success ? <p className="success">{L10n.referralSuccess(lang)}</p> : null}
              <div className="btn-row">
                <button className="btn" type="button" onClick={() => setShowForm(false)}>
                  {L10n.close(lang)}
                </button>
                <button className="btn primary" type="submit" disabled={submitting || !isFormValid}>
                  {submitting ? L10n.loading(lang) : L10n.submitReferral(lang)}
                </button>
              </div>
            </form>
          </div>
        </div>
      ) : null}
    </div>
  );
}
