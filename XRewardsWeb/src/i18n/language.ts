export type AppLanguage = 'zh' | 'en';

export const LANGUAGE_STORAGE_KEY = 'xrewards.ui.language';
export const DEFAULT_LANGUAGE: AppLanguage = 'zh';

export function readStoredLanguage(): AppLanguage {
  const stored = localStorage.getItem(LANGUAGE_STORAGE_KEY);
  return stored === 'en' ? 'en' : DEFAULT_LANGUAGE;
}

export function storeLanguage(lang: AppLanguage): void {
  localStorage.setItem(LANGUAGE_STORAGE_KEY, lang);
}

export function t(zh: string, en: string, lang: AppLanguage): string {
  return lang === 'zh' ? zh : en;
}
