import { useEffect, useState } from 'react';
import { Link, useParams } from 'react-router-dom';
import { getAdminUserDetail } from '../api/adminApi';
import { formatCategory, formatDate, StatusBadge } from '../components/StatusBadge';
import type { AdminTransaction, AdminUserDetail } from '../types';

export function UserDetailPage() {
  const { userId = '' } = useParams();
  const [user, setUser] = useState<AdminUserDetail | null>(null);
  const [transactions, setTransactions] = useState<AdminTransaction[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    if (!userId) return;
    void (async () => {
      setLoading(true);
      setError(null);
      try {
        const detail = await getAdminUserDetail(userId);
        setUser(detail.user);
        setTransactions(detail.transactions);
      } catch (err) {
        setError(err instanceof Error ? err.message : 'Failed to load member');
      } finally {
        setLoading(false);
      }
    })();
  }, [userId]);

  if (loading) return <div className="card"><p className="muted">Loading…</p></div>;
  if (error || !user) return <div className="card"><p className="error">{error ?? 'Not found'}</p></div>;

  return (
    <div className="card">
      <p><Link to="/users">← Back to members</Link></p>
      <h2>{user.displayName ?? 'Member'}</h2>
      <p className="muted">{user.memberId} · {user.email ?? 'No email'}</p>

      <div className="stats">
        <div className="stat">
          <span className="muted">Total points</span>
          <strong>{user.points.total}</strong>
        </div>
        <div className="stat">
          <span className="muted">Pending</span>
          <strong>{user.points.pending}</strong>
        </div>
        <div className="stat">
          <span className="muted">Confirmed</span>
          <strong>{user.points.confirmed}</strong>
        </div>
      </div>

      <h3>Reward history</h3>
      <div className="table-wrap">
        <table>
          <thead>
            <tr>
              <th>Action</th>
              <th>Category</th>
              <th>Points</th>
              <th>Status</th>
              <th>Date</th>
            </tr>
          </thead>
          <tbody>
            {transactions.map((tx) => (
              <tr key={tx.id}>
                <td>{tx.action}</td>
                <td>{formatCategory(tx.category)}</td>
                <td>{tx.points}</td>
                <td><StatusBadge status={tx.status} /></td>
                <td>{formatDate(tx.confirmedAt ?? tx.createdAt)}</td>
              </tr>
            ))}
          </tbody>
        </table>
        {transactions.length === 0 ? <p className="muted">No transactions yet.</p> : null}
      </div>
    </div>
  );
}
