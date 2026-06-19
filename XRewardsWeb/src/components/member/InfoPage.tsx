import { Link } from 'react-router-dom';
import { useLanguage } from '../../i18n/LanguageProvider';
import { L10n } from '../../i18n/l10n';
import type { ContentSection } from '../../content/supportContent';
import { contentUpdatedLabel } from '../../content/supportContent';

interface InfoPageProps {
  title: string;
  backTo?: string;
  backLabel?: string;
  sections: ContentSection[];
}

export function InfoPage({ title, backTo = '/profile', backLabel, sections }: InfoPageProps) {
  const { lang } = useLanguage();

  return (
    <div className="member-page content-page">
      <Link className="back-link" to={backTo}>
        ← {backLabel ?? L10n.profile(lang)}
      </Link>
      <h2 className="page-title">{title}</h2>
      <p className="muted small">{contentUpdatedLabel(lang)}</p>

      <div className="stack gap-md">
        {sections.map((section) => (
          <article className="card content-section" key={section.title}>
            <h3>{section.title}</h3>
            {section.paragraphs.map((paragraph) => (
              <p className="content-body" key={paragraph}>
                {paragraph}
              </p>
            ))}
            {section.bullets?.length ? (
              <ul className="content-list">
                {section.bullets.map((item) => (
                  <li key={item}>{item}</li>
                ))}
              </ul>
            ) : null}
          </article>
        ))}
      </div>
    </div>
  );
}
