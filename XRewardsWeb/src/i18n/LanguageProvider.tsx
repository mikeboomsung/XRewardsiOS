import { createContext, useContext, useMemo, useState, type ReactNode } from 'react';
import {
  AppLanguage,
  DEFAULT_LANGUAGE,
  readStoredLanguage,
  storeLanguage,
} from './language';

interface LanguageContextValue {
  lang: AppLanguage;
  setLang: (lang: AppLanguage) => void;
  toggleLang: () => void;
  toggleLabel: string;
  currentLanguageLabel: string;
}

const LanguageContext = createContext<LanguageContextValue | null>(null);

export function LanguageProvider({ children }: { children: ReactNode }) {
  const [lang, setLangState] = useState<AppLanguage>(() => readStoredLanguage());

  const value = useMemo<LanguageContextValue>(
    () => ({
      lang,
      setLang: (next) => {
        storeLanguage(next);
        setLangState(next);
      },
      toggleLang: () => {
        const next: AppLanguage = lang === 'zh' ? 'en' : 'zh';
        storeLanguage(next);
        setLangState(next);
      },
      toggleLabel: lang === 'zh' ? 'En' : '中文',
      currentLanguageLabel: lang === 'zh' ? '简体中文' : 'English',
    }),
    [lang]
  );

  return <LanguageContext.Provider value={value}>{children}</LanguageContext.Provider>;
}

export function useLanguage(): LanguageContextValue {
  const ctx = useContext(LanguageContext);
  if (!ctx) {
    return {
      lang: DEFAULT_LANGUAGE,
      setLang: () => undefined,
      toggleLang: () => undefined,
      toggleLabel: 'EN',
      currentLanguageLabel: '简体中文',
    };
  }
  return ctx;
}
