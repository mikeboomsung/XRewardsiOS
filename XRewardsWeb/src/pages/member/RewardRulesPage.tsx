import { useLanguage } from '../../i18n/LanguageProvider';
import { L10n } from '../../i18n/l10n';
import { rewardRulesContent } from '../../content/supportContent';
import { InfoPage } from '../../components/member/InfoPage';

export function RewardRulesPage() {
  const { lang } = useLanguage();
  return (
    <InfoPage
      title={L10n.rewardRules(lang)}
      sections={rewardRulesContent(lang)}
    />
  );
}
