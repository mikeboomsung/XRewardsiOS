import { useLanguage } from '../../i18n/LanguageProvider';

export function LanguageToggle() {
  const { toggleLang, toggleLabel } = useLanguage();
  return (
    <button className="lang-toggle" type="button" onClick={toggleLang}>
      {toggleLabel}
    </button>
  );
}

export function CurrentLanguageLabel() {
  const { currentLanguageLabel } = useLanguage();
  return <span className="current-lang">{currentLanguageLabel}</span>;
}

export function MemberStatusBadge({
  status,
}: {
  status: string;
}) {
  const { lang } = useLanguage();
  const normalized = status.toLowerCase();
  const className =
    normalized === 'confirmed' || normalized === 'paid'
      ? 'badge confirmed'
      : normalized === 'rejected'
        ? 'badge danger'
        : 'badge pending';
  const label =
    normalized === 'confirmed'
      ? lang === 'zh'
        ? '已确认'
        : 'Confirmed'
      : normalized === 'rejected'
        ? lang === 'zh'
          ? '已拒绝'
          : 'Rejected'
        : normalized === 'paid'
          ? lang === 'zh'
            ? '已发放'
            : 'Paid'
          : normalized === 'estimated'
            ? lang === 'zh'
              ? '预估'
              : 'Estimated'
            : lang === 'zh'
              ? '待确认'
              : 'Pending';
  return <span className={className}>{label}</span>;
}
