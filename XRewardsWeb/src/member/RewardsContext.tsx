import {
  createContext,
  useCallback,
  useContext,
  useEffect,
  useMemo,
  useState,
  type ReactNode,
} from 'react';
import { fetchRewardsData } from '../api/memberApi';
import { useLanguage } from '../i18n/LanguageProvider';
import { buildGuestPreview, emptyMemberPayload } from './mockData';
import type { RewardsPayload } from './models';

interface RewardsContextValue {
  data: RewardsPayload | null;
  isLoading: boolean;
  isGuestPreview: boolean;
  usesLiveData: boolean;
  reload: () => Promise<void>;
  clear: () => void;
}

const RewardsContext = createContext<RewardsContextValue | null>(null);

export function RewardsProvider({
  children,
  isGuest,
  isMember,
}: {
  children: ReactNode;
  isGuest: boolean;
  isMember: boolean;
}) {
  const { lang } = useLanguage();
  const [data, setData] = useState<RewardsPayload | null>(null);
  const [isLoading, setIsLoading] = useState(true);
  const [isGuestPreview, setIsGuestPreview] = useState(false);
  const [usesLiveData, setUsesLiveData] = useState(false);

  const clear = useCallback(() => {
    setData(null);
    setIsGuestPreview(false);
    setUsesLiveData(false);
  }, []);

  const reload = useCallback(async () => {
    setIsLoading(true);
    try {
      if (isMember) {
        const payload = await fetchRewardsData();
        setData(payload);
        setIsGuestPreview(false);
        setUsesLiveData(true);
      } else if (isGuest) {
        setData(buildGuestPreview(lang));
        setIsGuestPreview(true);
        setUsesLiveData(false);
      } else {
        setData(emptyMemberPayload());
        setIsGuestPreview(false);
        setUsesLiveData(false);
      }
    } catch {
      setData(isGuest ? buildGuestPreview(lang) : emptyMemberPayload());
      setIsGuestPreview(isGuest);
      setUsesLiveData(false);
    } finally {
      setIsLoading(false);
    }
  }, [isGuest, isMember, lang]);

  useEffect(() => {
    void reload();
  }, [reload]);

  const value = useMemo(
    () => ({ data, isLoading, isGuestPreview, usesLiveData, reload, clear }),
    [data, isLoading, isGuestPreview, usesLiveData, reload, clear]
  );

  return <RewardsContext.Provider value={value}>{children}</RewardsContext.Provider>;
}

export function useRewards(): RewardsContextValue {
  const ctx = useContext(RewardsContext);
  if (!ctx) {
    throw new Error('useRewards must be used within RewardsProvider');
  }
  return ctx;
}
