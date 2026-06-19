import { useState } from 'react';
import { useLanguage } from '../../i18n/LanguageProvider';
import { L10n } from '../../i18n/l10n';
import { formatPoints } from '../../member/format';
import { useRewards } from '../../member/RewardsContext';

export function TeamPage() {
  const { lang } = useLanguage();
  const { data, isLoading } = useRewards();
  const [showInvite, setShowInvite] = useState(false);

  if (isLoading || !data) {
    return <p className="muted center">{L10n.loading(lang)}</p>;
  }

  const { team } = data;
  const inviteMessage = L10n.inviteMessage(lang);

  return (
    <div className="member-page">
      <h2 className="page-title">{L10n.team(lang)}</h2>
      <p className="muted">{L10n.teamSubtitle(lang)}</p>

      <div className="stats">
        <div className="stat card">
          <strong>{team.directMembers}</strong>
          <span className="muted">{L10n.directMembers(lang)}</span>
        </div>
        <div className="stat card">
          <strong>{team.totalDownline}</strong>
          <span className="muted">{L10n.totalTeam(lang)}</span>
        </div>
        <div className="stat card">
          <strong>{formatPoints(team.teamPoints)}</strong>
          <span className="muted">{L10n.teamPoints(lang)}</span>
        </div>
      </div>

      <div className="card">
        <h3>{L10n.teamStructure(lang)}</h3>
        <div className="empty compact">
          <p>{L10n.orgChartSoon(lang)}</p>
          <p className="muted small">{L10n.orgChartDesc(lang)}</p>
        </div>
      </div>

      <button className="btn primary full" type="button" onClick={() => setShowInvite(true)}>
        {L10n.inviteMembers(lang)}
      </button>
      <p className="muted small center">{L10n.inviteHint(lang)}</p>

      {showInvite ? (
        <div className="modal-backdrop" role="presentation" onClick={() => setShowInvite(false)}>
          <div className="modal card" role="dialog" onClick={(e) => e.stopPropagation()}>
            <h3>{L10n.inviteTitle(lang)}</h3>
            <p className="muted">{L10n.inviteSheetBody(lang)}</p>
            <textarea className="invite-text" readOnly value={inviteMessage} rows={4} />
            <div className="btn-row">
              <button className="btn" type="button" onClick={() => setShowInvite(false)}>
                {L10n.done(lang)}
              </button>
              <button
                className="btn primary"
                type="button"
                onClick={() => {
                  void navigator.clipboard.writeText(inviteMessage);
                }}
              >
                {L10n.shareInvite(lang)}
              </button>
            </div>
          </div>
        </div>
      ) : null}
    </div>
  );
}
