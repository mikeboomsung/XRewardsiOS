import { useEffect, useState } from 'react';
import { BrowserRouter, Navigate, Route, Routes } from 'react-router-dom';
import { onAuthStateChanged, User } from 'firebase/auth';
import { auth } from './firebase';
import { checkAdminAccess } from './api/adminApi';
import { Layout } from './components/Layout';
import { LoginPage } from './pages/LoginPage';
import { ReferralsPage } from './pages/ReferralsPage';
import { UserDetailPage } from './pages/UserDetailPage';
import { UsersPage } from './pages/UsersPage';

export default function App() {
  const [user, setUser] = useState<User | null>(null);
  const [ready, setReady] = useState(false);
  const [isAdmin, setIsAdmin] = useState(false);

  useEffect(() => {
    return onAuthStateChanged(auth, (nextUser) => {
      setUser(nextUser);
      setReady(true);
    });
  }, []);

  useEffect(() => {
    if (!user) {
      setIsAdmin(false);
      return;
    }
    void (async () => {
      try {
        setIsAdmin(await checkAdminAccess());
      } catch {
        setIsAdmin(false);
      }
    })();
  }, [user]);

  if (!ready) {
    return <div className="login-page"><p className="muted">Loading…</p></div>;
  }

  if (!user || !isAdmin) {
    return (
      <LoginPage
        onSignedIn={() => {
          setUser(auth.currentUser);
          setIsAdmin(true);
        }}
      />
    );
  }

  return (
    <BrowserRouter>
      <Routes>
        <Route element={<Layout />}>
          <Route index element={<ReferralsPage />} />
          <Route path="users" element={<UsersPage />} />
          <Route path="users/:userId" element={<UserDetailPage />} />
          <Route path="*" element={<Navigate to="/" replace />} />
        </Route>
      </Routes>
    </BrowserRouter>
  );
}
