import { useMemo, useState } from 'react';
import { MemberStatusBadge } from '../../components/member/MemberUi';
import { useLanguage } from '../../i18n/LanguageProvider';
import { L10n } from '../../i18n/l10n';
import { categoryDisplayName } from '../../member/categories';
import { CATEGORY_ICONS } from '../../member/models';
import { formatDate, formatPoints } from '../../member/format';
import { useRewards } from '../../member/RewardsContext';

type Filter = 'all' | 'referrals' | 'pending' | 'confirmed';

export function ActivityPage() {
  const { lang } = useLanguage();
  const { data, isLoading } = useRewards();
  const [filter, setFilter] = useState<Filter>('all');

  const transactions = useMemo(() => {
    if (!data) return [];
    switch (filter) {
      case 'referrals':
        return data.transactions.filter(
          (tx) =>
            tx.action.toLowerCase().includes('referral') || tx.action.includes('推荐')
        );
      case 'pending':
        return data.transactions.filter((tx) => tx.status === 'pending');
      case 'confirmed':
        return data.transactions.filter((tx) => tx.status === 'confirmed');
      default:
        return data.transactions;
    }
  }, [data, filter]);

  if (isLoading || !data) {
    return <p className="muted center">{L10n.loading(lang)}</p>;
  }

  const filters: { id: Filter; label: string }[] = [
    { id: 'all', label: L10n.filterAll(lang) },
    { id: 'referrals', label: L10n.filterReferrals(lang) },
    { id: 'pending', label: L10n.filterPending(lang) },
    { id: 'confirmed', label: L10n.filterConfirmed(lang) },
  ];

  return (
    <div className="member-page">
      <h2 className="page-title">{L10n.activity(lang)}</h2>

      <div className="segmented">
        {filters.map((item) => (
          <button
            key={item.id}
            type="button"
            className={filter === item.id ? 'active' : ''}
            onClick={() => setFilter(item.id)}
          >
            {item.label}
          </button>
        ))}
      </div>

      {filter === 'referrals' ? (
        data.referrals.length === 0 ? (
          <div className="empty card">
            <h3>{L10n.noReferrals(lang)}</h3>
            <p className="muted">{L10n.noReferralsDesc(lang)}</p>
          </div>
        ) : (
          <div className="stack gap-sm">
            {data.referrals.map((referral) => (
              <div className="card list-item" key={referral.id}>
                <div className="row-between">
                  <strong>{referral.inviteeName}</strong>
                  <span className="gold">+{formatPoints(referral.pointsAwarded)}</span>
                </div>
                <p className="muted small">{referral.inviteeEmail}</p>
                <div className="row-between small muted">
                  <span>{referral.inviteePhone}</span>
                  <span>{categoryDisplayName(referral.category, lang)}</span>
                  <MemberStatusBadge status={referral.status} />
                </div>
              </div>
            ))}
          </div>
        )
      ) : transactions.length === 0 ? (
        <div className="empty card">
          <h3>{L10n.noActivity(lang)}</h3>
          <p className="muted">{L10n.noActivityDesc(lang)}</p>
        </div>
      ) : (
        <div className="stack gap-sm">
          {transactions.map((tx) => (
            <div className="card list-item" key={tx.id}>
              <div className="row-between">
                <div className="row gap-sm">
                  <span>{CATEGORY_ICONS[tx.category]}</span>
                  <div>
                    <strong>{tx.action}</strong>
                    <p className="muted small">{formatDate(tx.createdAt)}</p>
                  </div>
                </div>
                <div className="align-end">
                  <span className="gold">+{formatPoints(tx.points)}</span>
                  <MemberStatusBadge status={tx.status} />
                </div>
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}
