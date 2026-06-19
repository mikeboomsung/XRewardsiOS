import { Link } from 'react-router-dom';
import { MemberStatusBadge } from '../../components/member/MemberUi';
import { useLanguage } from '../../i18n/LanguageProvider';
import { L10n } from '../../i18n/l10n';
import { formatCurrency, formatMonthYear, formatPercent, formatPoints } from '../../member/format';
import { useRewards } from '../../member/RewardsContext';

export function DividendsPage() {
  const { lang } = useLanguage();
  const { data, isLoading } = useRewards();

  if (isLoading || !data) {
    return <p className="muted center">{L10n.loading(lang)}</p>;
  }

  const current = data.currentDividend;

  return (
    <div className="member-page">
      <Link className="back-link" to="/profile">
        ← {L10n.profile(lang)}
      </Link>
      <h2 className="page-title">{L10n.dividends(lang)}</h2>

      {current ? (
        <div className="card">
          <h3>{L10n.currentPeriod(lang)}</h3>
          <div className="row-between">
            <div>
              <p className="muted small">{L10n.estimatedPayout(lang)}</p>
              <p className="metric-value">{formatCurrency(current.payoutAmount)}</p>
            </div>
            <div className="align-end">
              <MemberStatusBadge status={current.status} />
              <p className="muted small">{L10n.settlesJuly1(lang)}</p>
            </div>
          </div>
          <hr className="hr-divider" />
          <div className="detail-row">
            <span className="muted">{L10n.poolSize(lang)}</span>
            <span>{formatCurrency(current.poolAmount)}</span>
          </div>
          <div className="detail-row">
            <span className="muted">{L10n.yourShare(lang)}</span>
            <span>{formatPercent(current.userShare)}</span>
          </div>
          <div className="detail-row">
            <span className="muted">{L10n.yourPoints(lang)}</span>
            <span>{formatPoints(current.userPoints)}</span>
          </div>
        </div>
      ) : null}

      <h3>{L10n.history(lang)}</h3>
      <div className="stack gap-sm">
        {data.dividends.map((period) => (
          <div className="card row-between" key={period.id}>
            <div>
              <strong>{formatMonthYear(period.month)}</strong>
              <MemberStatusBadge status={period.status} />
            </div>
            <span className="gold">{formatCurrency(period.payoutAmount)}</span>
          </div>
        ))}
      </div>

      <p className="muted small">{L10n.dividendFormula(lang)}</p>
    </div>
  );
}
