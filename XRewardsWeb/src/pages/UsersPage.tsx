import { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import { listAdminUsers } from '../api/adminApi';
import { formatDate } from '../components/StatusBadge';
import type { AdminUserSummary } from '../types';

export function UsersPage() {
  const [users, setUsers] = useState<AdminUserSummary[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    void (async () => {
      setLoading(true);
      setError(null);
      try {
        setUsers(await listAdminUsers());
      } catch (err) {
        setError(err instanceof Error ? err.message : 'Failed to load members');
      } finally {
        setLoading(false);
      }
    })();
  }, []);

  return (
    <div className="card">
      <h2>Members</h2>
      <p className="muted">Points balances and links to full reward history.</p>

      {loading ? <p className="muted">Loading…</p> : null}
      {error ? <p className="error">{error}</p> : null}

      {!loading && !error ? (
        <div className="table-wrap">
          <table>
            <thead>
              <tr>
                <th>Member</th>
                <th>Total</th>
                <th>Pending</th>
                <th>Confirmed</th>
                <th>Updated</th>
                <th></th>
              </tr>
            </thead>
            <tbody>
              {users.map((user) => (
                <tr key={user.uid}>
                  <td>
                    <strong>{user.displayName ?? 'Member'}</strong>
                    <div className="muted">{user.memberId ?? user.uid}</div>
                    <div className="muted">{user.email ?? '—'}</div>
                  </td>
                  <td>{user.points.total}</td>
                  <td>{user.points.pending}</td>
                  <td>{user.points.confirmed}</td>
                  <td>{formatDate(user.updatedAt)}</td>
                  <td>
                    <Link to={`/users/${user.uid}`}>View history</Link>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
          {users.length === 0 ? <p className="muted">No members yet.</p> : null}
        </div>
      ) : null}
    </div>
  );
}
