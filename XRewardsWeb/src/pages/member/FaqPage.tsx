import { Link } from 'react-router-dom';
import { useLanguage } from '../../i18n/LanguageProvider';
import { L10n } from '../../i18n/l10n';
import { contentUpdatedLabel, faqContent } from '../../content/supportContent';

export function FaqPage() {
  const { lang } = useLanguage();
  const items = faqContent(lang);

  return (
    <div className="member-page content-page">
      <Link className="back-link" to="/profile">
        ← {L10n.profile(lang)}
      </Link>
      <h2 className="page-title">{L10n.faq(lang)}</h2>
      <p className="muted small">{contentUpdatedLabel(lang)}</p>

      <div className="stack gap-sm">
        {items.map((item) => (
          <details className="card faq-item" key={item.question}>
            <summary>{item.question}</summary>
            <p className="content-body">{item.answer}</p>
          </details>
        ))}
      </div>
    </div>
  );
}
