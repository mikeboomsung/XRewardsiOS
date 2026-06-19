import { useEffect, useRef, useState } from 'react';
import { CurrentLanguageLabel, LanguageToggle } from '../../components/member/MemberUi';
import { PublicLegalLinks } from '../../components/member/PublicLegalLinks';
import { useLanguage } from '../../i18n/LanguageProvider';
import { L10n } from '../../i18n/l10n';

interface PrivacyConsentPageProps {
  onAgree: () => void;
}

export function PrivacyConsentPage({ onAgree }: PrivacyConsentPageProps) {
  const { lang } = useLanguage();
  const [canAgree, setCanAgree] = useState(false);
  const frameRef = useRef<HTMLIFrameElement>(null);

  const policySrc = lang === 'zh' ? '/privacy-policy.html' : '/privacy-policy-en.html';

  useEffect(() => {
    setCanAgree(false);
  }, [policySrc]);

  useEffect(() => {
    const frame = frameRef.current;
    if (!frame) return;

    function handleLoad() {
      const doc = frame?.contentDocument;
      if (!doc) return;

      const onScroll = () => {
        const el = doc.documentElement;
        const scrolled = el.scrollTop + el.clientHeight >= el.scrollHeight - 80;
        if (scrolled && el.scrollTop >= 80) {
          setCanAgree(true);
        }
      };

      doc.addEventListener('scroll', onScroll);
      frame.contentWindow?.addEventListener('scroll', onScroll);
    }

    frame.addEventListener('load', handleLoad);
    return () => frame.removeEventListener('load', handleLoad);
  }, [policySrc]);

  return (
    <div className="privacy-consent-shell">
      <header className="privacy-consent-header">
        <div>
          <h1>{L10n.privacyPolicy(lang)}</h1>
          <p className="muted">{L10n.privacyPolicyAgreePrompt(lang)}</p>
        </div>
        <div className="row gap-sm">
          <CurrentLanguageLabel />
          <LanguageToggle />
        </div>
      </header>

      <iframe
        ref={frameRef}
        className="privacy-frame"
        title={L10n.privacyPolicy(lang)}
        src={policySrc}
      />

      <footer className="privacy-consent-footer">
        <button className="btn primary full" type="button" disabled={!canAgree} onClick={onAgree}>
          {L10n.privacyPolicyAgree(lang)}
        </button>
        {!canAgree ? <p className="muted small center">{L10n.privacyPolicyScrollHint(lang)}</p> : null}
        <PublicLegalLinks className="consent-legal-links" />
      </footer>
    </div>
  );
}
