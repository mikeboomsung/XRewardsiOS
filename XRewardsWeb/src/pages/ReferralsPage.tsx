import { useEffect, useState } from 'react';
import {
  awardConversionBonus,
  confirmReferral,
  listAdminReferrals,
} from '../api/adminApi';
import { formatCategory, formatDate, StatusBadge } from '../components/StatusBadge';
import type { AdminReferral } from '../types';

export function ReferralsPage() {
  const [referrals, setReferrals] = useState<AdminReferral[]>([]);
  const [status, setStatus] = useState('all');
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [busyId, setBusyId] = useState<string | null>(null);

  async function load() {
    setLoading(true);
    setError(null);
    try {
      setReferrals(await listAdminReferrals(status));
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to load referrals');
    } finally {
      setLoading(false);
    }
  }

  useEffect(() => {
    void load();
  }, [status]);

  async function handleConfirm(referral: AdminReferral) {
    const externalRef = window.prompt('Policy / lead reference (optional):') ?? undefined;
    setBusyId(referral.id);
    try {
      await confirmReferral({
        referrerUid: referral.referrerUid,
        referralId: referral.referralId,
        externalRef: externalRef || undefined,
      });
      await load();
    } catch (err) {
      alert(err instanceof Error ? err.message : 'Confirm failed');
    } finally {
      setBusyId(null);
    }
  }

  async function handleConversion(referral: AdminReferral) {
    const externalRef = window.prompt('Sale / policy number (optional):') ?? undefined;
    const pointsInput = window.prompt(
      `Conversion points (leave blank for default for ${formatCategory(referral.category)}):`
    );
    const points = pointsInput?.trim() ? Number(pointsInput) : undefined;
    setBusyId(referral.id);
    try {
      const result = await awardConversionBonus({
        referrerUid: referral.referrerUid,
        referralId: referral.referralId,
        externalRef: externalRef || undefined,
        points: Number.isFinite(points) ? points : undefined,
      });
      alert(`Awarded ${result.conversionPoints} conversion points.`);
      await load();
    } catch (err) {
      alert(err instanceof Error ? err.message : 'Conversion award failed');
    } finally {
      setBusyId(null);
    }
  }

  return (
    <div className="card">
      <h2>Referrals inbox</h2>
      <p className="muted">
        Every member referral from the iOS app appears here. Confirm the lead, then award conversion
        points when a sale completes.
      </p>

      <div className="filters">
        <label>
          Status{' '}
          <select value={status} onChange={(e) => setStatus(e.target.value)}>
            <option value="all">All</option>
            <option value="pending">Pending</option>
            <option value="confirmed">Confirmed</option>
            <option value="converted">Converted</option>
          </select>
        </label>
        <button className="btn" type="button" onClick={() => void load()}>
          Refresh
        </button>
      </div>

      {loading ? <p className="muted">Loading…</p> : null}
      {error ? <p className="error">{error}</p> : null}

      {!loading && !error ? (
        <div className="table-wrap">
          <table>
            <thead>
              <tr>
                <th>Referrer</th>
                <th>Invitee</th>
                <th>Category</th>
                <th>Points</th>
                <th>Status</th>
                <th>Submitted</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              {referrals.map((referral) => (
                <tr key={referral.id}>
                  <td>
                    <strong>{referral.referrerDisplayName ?? 'Member'}</strong>
                    <div className="muted">{referral.referrerMemberId ?? referral.referrerUid}</div>
                    <div className="muted">{referral.referrerEmail ?? '—'}</div>
                  </td>
                  <td>
                    <strong>{referral.inviteeName}</strong>
                    <div className="muted">{referral.inviteePhone}</div>
                    <div className="muted">{referral.inviteeEmail}</div>
                  </td>
                  <td>{formatCategory(referral.category)}</td>
                  <td>
                    Lead: {referral.leadPoints}
                    <br />
                    Conversion: {referral.conversionPoints || '—'}
                  </td>
                  <td>
                    <StatusBadge status={referral.status} />
                  </td>
                  <td>{formatDate(referral.createdAt)}</td>
                  <td>
                    <div className="btn-row">
                      {referral.status === 'pending' ? (
                        <button
                          className="btn"
                          type="button"
                          disabled={busyId === referral.id}
                          onClick={() => void handleConfirm(referral)}
                        >
                          Confirm lead
                        </button>
                      ) : null}
                      {referral.status !== 'converted' ? (
                        <button
                          className="btn primary"
                          type="button"
                          disabled={busyId === referral.id}
                          onClick={() => void handleConversion(referral)}
                        >
                          Award sale
                        </button>
                      ) : null}
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
          {referrals.length === 0 ? <p className="muted">No referrals yet.</p> : null}
        </div>
      ) : null}
    </div>
  );
}
