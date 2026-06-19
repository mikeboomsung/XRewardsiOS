import { NavLink, Outlet } from 'react-router-dom';
import { LanguageToggle } from './MemberUi';
import { useLanguage } from '../../i18n/LanguageProvider';
import { L10n } from '../../i18n/l10n';

export function MemberLayout() {
  const { lang } = useLanguage();

  return (
    <div className="member-shell">
      <header className="member-header">
        <div className="brand">
          <h1>
            <span>XRewards</span>
          </h1>
        </div>
        <LanguageToggle />
      </header>

      <main className="member-main">
        <Outlet />
      </main>

      <nav className="member-tabbar" aria-label="Main">
        <NavLink to="/" end>
          <span aria-hidden>🏠</span>
          {L10n.tabHome(lang)}
        </NavLink>
        <NavLink to="/earn">
          <span aria-hidden>💎</span>
          {L10n.tabEarn(lang)}
        </NavLink>
        <NavLink to="/activity">
          <span aria-hidden>📋</span>
          {L10n.tabActivity(lang)}
        </NavLink>
        <NavLink to="/team">
          <span aria-hidden>👥</span>
          {L10n.tabTeam(lang)}
        </NavLink>
        <NavLink to="/profile">
          <span aria-hidden>👤</span>
          {L10n.tabProfile(lang)}
        </NavLink>
      </nav>
    </div>
  );
}
