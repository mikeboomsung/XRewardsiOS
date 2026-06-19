import { useLanguage } from '../../i18n/LanguageProvider';
import { L10n } from '../../i18n/l10n';

interface PublicLegalLinksProps {
  className?: string;
}

export function PublicLegalLinks({ className }: PublicLegalLinksProps) {
  const { lang } = useLanguage();
  const privacyHref = lang === 'zh' ? '/privacy-policy.html' : '/privacy-policy-en.html';
  const supportHref = lang === 'zh' ? '/support.html' : '/support-en.html';

  return (
    <nav className={['public-legal-links', className].filter(Boolean).join(' ')} aria-label="Legal">
      <a href={supportHref} target="_blank" rel="noreferrer">
        {L10n.support(lang)}
      </a>
      <span className="public-legal-sep" aria-hidden>
        ·
      </span>
      <a href={privacyHref} target="_blank" rel="noreferrer">
        {L10n.privacyPolicy(lang)}
      </a>
    </nav>
  );
}
