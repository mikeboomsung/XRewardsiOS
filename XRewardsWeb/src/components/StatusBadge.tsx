import type { ReferralStatus } from '../types';

export function StatusBadge({ status }: { status: ReferralStatus | string }) {
  const normalized = status.toLowerCase();
  const className =
    normalized === 'converted'
      ? 'badge converted'
      : normalized === 'confirmed'
        ? 'badge confirmed'
        : 'badge pending';

  return <span className={className}>{status}</span>;
}

export function formatCategory(category: string): string {
  const labels: Record<string, string> = {
    insurance: 'Insurance',
    loans: 'Loans',
    realEstate: 'Real Estate',
    appEcosystem: 'App Ecosystem',
    content: 'Content',
    training: 'Training',
  };
  return labels[category] ?? category;
}

export function formatDate(value: string | null): string {
  if (!value) return '—';
  return new Date(value).toLocaleString();
}
