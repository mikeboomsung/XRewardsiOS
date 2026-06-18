import { FormEvent, useState } from 'react';
import { signInWithEmailAndPassword } from 'firebase/auth';
import { auth } from '../firebase';
import { ensureAppCheckToken } from '../appCheck';
import { checkAdminAccess } from '../api/adminApi';

interface LoginPageProps {
  onSignedIn: () => void;
}

export function LoginPage({ onSignedIn }: LoginPageProps) {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState<string | null>(null);
  const [loading, setLoading] = useState(false);

  async function handleSubmit(event: FormEvent) {
    event.preventDefault();
    setLoading(true);
    setError(null);

    try {
      await ensureAppCheckToken();
      await signInWithEmailAndPassword(auth, email.trim(), password);
      const isAdmin = await checkAdminAccess();
      if (!isAdmin) {
        await auth.signOut();
        throw new Error('This account does not have admin access.');
      }
      onSignedIn();
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Sign in failed');
    } finally {
      setLoading(false);
    }
  }

  return (
    <div className="login-page">
      <div className="card login-card">
        <h2>Admin sign in</h2>
        <p className="muted">Use your XRewards admin Firebase Auth account.</p>
        <form onSubmit={handleSubmit}>
          <label className="field">
            Email
            <input
              type="email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              autoComplete="username"
              required
            />
          </label>
          <label className="field">
            Password
            <input
              type="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              autoComplete="current-password"
              required
            />
          </label>
          {error ? <p className="error">{error}</p> : null}
          <button className="btn primary" type="submit" disabled={loading}>
            {loading ? 'Signing in…' : 'Sign in'}
          </button>
        </form>
      </div>
    </div>
  );
}
