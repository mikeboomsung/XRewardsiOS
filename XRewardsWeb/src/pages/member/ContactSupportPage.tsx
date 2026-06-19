import { Link } from 'react-router-dom';
import { useLanguage } from '../../i18n/LanguageProvider';
import { L10n } from '../../i18n/l10n';
import { contactSupportContent } from '../../content/supportContent';

export function ContactSupportPage() {
  const { lang } = useLanguage();
  const content = contactSupportContent(lang);
  const mailto = `mailto:${content.email}?subject=${encodeURIComponent(
    lang === 'zh' ? 'XRewards 支持请求' : 'XRewards support request'
  )}`;

  return (
    <div className="member-page content-page">
      <Link className="back-link" to="/profile">
        ← {L10n.profile(lang)}
      </Link>
      <h2 className="page-title">{L10n.contactSupport(lang)}</h2>

      <div className="card content-section">
        <p className="content-body">{content.intro}</p>
        <p className="content-body">
          <strong>{content.email}</strong>
        </p>
        <p className="muted small">{content.responseTime}</p>
        <a className="btn primary full" href={mailto}>
          {lang === 'zh' ? '发送邮件' : 'Send email'}
        </a>
      </div>

      <div className="card content-section">
        <h3>{content.includeTitle}</h3>
        <ul className="content-list">
          {content.includeItems.map((item) => (
            <li key={item}>{item}</li>
          ))}
        </ul>
      </div>

      <div className="card content-section">
        <h3>{content.hoursTitle}</h3>
        <p className="content-body">{content.hours}</p>
        <p className="muted small">{content.urgentNote}</p>
      </div>
    </div>
  );
}
