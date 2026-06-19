import { Link } from 'react-router-dom';
import { useLanguage } from '../../i18n/LanguageProvider';
import { L10n } from '../../i18n/l10n';
import { valuePillars, workflowSteps } from '../../member/categories';

export function HowItWorksPage() {
  const { lang } = useLanguage();
  const steps = workflowSteps(lang);
  const pillars = valuePillars(lang);

  return (
    <div className="member-page">
      <Link className="back-link" to="/profile">
        ← {L10n.profile(lang)}
      </Link>
      <h2 className="page-title">{L10n.howItWorks(lang)}</h2>
      <p className="muted">{L10n.howItWorksSubtitle(lang)}</p>

      <div className="stack gap-md">
        {steps.map((step, index) => (
          <div className="card workflow-step" key={step.id}>
            <div className="workflow-icon">{step.icon}</div>
            <div>
              <p className="gold small">{L10n.stepNumber(step.id, lang)}</p>
              <h3>{step.title}</h3>
              <p className="muted">{step.description}</p>
              {index < steps.length - 1 ? <div className="workflow-line" /> : null}
            </div>
          </div>
        ))}
      </div>

      <div className="card">
        <h3>{L10n.rewardPoolTitle(lang)}</h3>
        <div className="flow-row">
          <span>{L10n.platformProfit(lang)}</span>
          <span>→</span>
          <span>{L10n.poolPercentRange(30, 50, lang)}</span>
          <span>→</span>
          <span>{L10n.poolShareLabel(lang)}</span>
        </div>
        <p className="muted small">{L10n.dividendFormulaShort(lang)}</p>
      </div>

      <div className="card">
        <h3>{L10n.longTermRetention(lang)}</h3>
        <p className="muted">{L10n.retentionBody(lang)}</p>
        <div className="chart-row">
          <div>
            <strong>20%</strong>
            <div className="bar short" />
            <span className="muted small">{L10n.traditionalLabel(lang)}</span>
          </div>
          <div>
            <strong className="gold">90%+</strong>
            <div className="bar tall" />
            <span className="muted small">{L10n.xrewardsLabel(lang)}</span>
          </div>
        </div>
      </div>

      <h3>{L10n.fivePillars(lang)}</h3>
      <div className="stack gap-sm">
        {pillars.map((pillar) => (
          <div className="card row gap-sm" key={pillar.title}>
            <span className="category-icon">{pillar.icon}</span>
            <div>
              <strong>{pillar.title}</strong>
              <p className="muted small">{pillar.subtitle}</p>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
