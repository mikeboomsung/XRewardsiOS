import { NavLink, Outlet } from 'react-router-dom';
import { signOut } from 'firebase/auth';
import { auth } from '../firebase';

export function Layout() {
  return (
    <div className="app-shell">
      <div className="topbar">
        <div className="brand">
          <h1>
            <span>XRewards</span> Admin
          </h1>
        </div>
        <button className="btn danger" type="button" onClick={() => signOut(auth)}>
          Sign out
        </button>
      </div>

      <nav className="nav">
        <NavLink to="/admin" end>
          Referrals
        </NavLink>
        <NavLink to="/admin/users">Members</NavLink>
        <NavLink to="/">Member app</NavLink>
      </nav>

      <Outlet />
    </div>
  );
}
