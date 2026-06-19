export function formatPoints(value: number): string {
  return value.toLocaleString();
}

export function formatCurrency(value: number): string {
  return value.toLocaleString(undefined, { style: 'currency', currency: 'USD' });
}

export function formatPercent(value: number): string {
  return value.toLocaleString(undefined, { style: 'percent', minimumFractionDigits: 2, maximumFractionDigits: 2 });
}

export function formatDate(value: string | null): string {
  if (!value) return '—';
  return new Date(value).toLocaleDateString(undefined, { dateStyle: 'medium' });
}

export function formatMonthYear(value: string): string {
  return new Date(value).toLocaleDateString(undefined, { month: 'long', year: 'numeric' });
}
