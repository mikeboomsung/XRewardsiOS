import { Link } from 'react-router-dom';
import { useLanguage } from '../../i18n/LanguageProvider';
import { L10n } from '../../i18n/l10n';
import { categoryDisplayName } from '../../member/categories';
import { CATEGORY_ICONS, CATEGORY_POINT_RANGES, REVENUE_CATEGORIES } from '../../member/models';

export function EarnPage() {
  const { lang } = useLanguage();

  return (
    <div className="member-page">
      <h2 className="page-title">{L10n.earnTitle(lang)}</h2>
      <p className="muted">{L10n.earnSubtitle(lang)}</p>

      <div className="category-grid">
        {REVENUE_CATEGORIES.map((category) => (
          <Link className="card category-card" key={category} to={`/earn/${category}`}>
            <span className="category-icon">{CATEGORY_ICONS[category]}</span>
            <strong>{categoryDisplayName(category, lang)}</strong>
            <span className="muted small">{CATEGORY_POINT_RANGES[category]} pts</span>
          </Link>
        ))}
      </div>
    </div>
  );
}
