import { Link } from 'react-router-dom';
import { PublicLegalLinks } from '../../components/member/PublicLegalLinks';
import { useLanguage } from '../../i18n/LanguageProvider';
import { L10n } from '../../i18n/l10n';
import { CATEGORY_ICONS } from '../../member/models';
import { categoryDisplayName } from '../../member/categories';
import { formatCurrency, formatPoints } from '../../member/format';
import { useRewards } from '../../member/RewardsContext';

export function HomePage() {
  const { lang } = useLanguage();
  const { data, isLoading, isGuestPreview } = useRewards();

  if (isLoading || !data) {
    return <p className="muted center">{L10n.loading(lang)}</p>;
  }

  const { profile, dashboard } = data;

  return (
    <div className="member-page">
      <h2 className="page-title">{L10n.dashboard(lang)}</h2>

      {isGuestPreview ? (
        <div className="banner card">
          <span aria-hidden>👁️</span>
          <p>{L10n.guestPreviewBanner(lang)}</p>
        </div>
      ) : null}

      <div className="greeting">
        <p className="muted">{L10n.welcomeBack(lang)}</p>
        <h3>{profile.name || L10n.member(lang)}</h3>
      </div>

      <div className="card metric-card">
        <p className="muted">{L10n.totalPoints(lang)}</p>
        <p className="metric-value">{formatPoints(dashboard.totalPoints)}</p>
        <p className="muted small">{L10n.pointsPermanent(lang)}</p>
      </div>

      <div className="card metric-card">
        <p className="muted">{L10n.estimatedThisMonth(lang)}</p>
        <p className="metric-value">{formatCurrency(dashboard.estimatedMonthlyDividend)}</p>
        <p className="muted small">{L10n.basedOnCurrentPool(lang)}</p>
        <p className="muted small">{L10n.rewardPoolPercent(40, lang)}</p>
      </div>

      <div className="card stat-inline">
        <span className="muted">{L10n.pendingPoints(lang)}</span>
        <strong>{formatPoints(dashboard.pendingPoints)}</strong>
      </div>

      <section>
        <h3>{L10n.activeRevenueStreams(lang)}</h3>
        <div className="chip-row">
          {dashboard.activeCategories.map((category) => (
            <span className="chip" key={category}>
              {CATEGORY_ICONS[category]} {categoryDisplayName(category, lang)}
            </span>
          ))}
        </div>
      </section>

      <Link className="card link-card" to="/how-it-works">
        <span>{L10n.howPassiveIncomeWorks(lang)}</span>
        <span aria-hidden>›</span>
      </Link>

      <PublicLegalLinks className="home-legal-links" />
    </div>
  );
}
