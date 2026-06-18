import { FirebaseApp } from 'firebase/app';
import {
  AppCheck,
  getToken,
  initializeAppCheck,
  ReCaptchaEnterpriseProvider,
  ReCaptchaV3Provider,
} from 'firebase/app-check';

let appCheckInstance: AppCheck | undefined;

/**
 * Firebase Auth enforces App Check on xrewards-c0524.
 * The admin web app must initialize App Check before sign-in.
 *
 * Recommended: reCAPTCHA Enterprise (free for 10k assessments/month).
 * Register in Firebase Console → App Check → Web app → reCAPTCHA Enterprise.
 */
export function initializeFirebaseAppCheck(app: FirebaseApp): void {
  const siteKey = import.meta.env.VITE_FIREBASE_RECAPTCHA_SITE_KEY?.trim();
  const debug = import.meta.env.VITE_APP_CHECK_DEBUG === 'true';
  const useEnterprise = import.meta.env.VITE_APP_CHECK_USE_ENTERPRISE !== 'false';

  if (!siteKey) {
    console.warn(
      '[XRewards Admin] Missing VITE_FIREBASE_RECAPTCHA_SITE_KEY. Auth sign-in will fail until App Check is configured.'
    );
    return;
  }

  console.info(
    `[XRewards Admin] App Check provider: ${useEnterprise ? 'reCAPTCHA Enterprise' : 'reCAPTCHA v3'} (site key …${siteKey.slice(-6)})`
  );

  if (debug) {
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    (globalThis as any).FIREBASE_APPCHECK_DEBUG_TOKEN = true;
    console.info(
      '[XRewards Admin] App Check debug mode — copy the debug token from the console and register it in Firebase App Check.'
    );
  }

  const provider = useEnterprise
    ? new ReCaptchaEnterpriseProvider(siteKey)
    : new ReCaptchaV3Provider(siteKey);

  appCheckInstance = initializeAppCheck(app, {
    provider,
    isTokenAutoRefreshEnabled: true,
  });
}

/** Force an App Check token before Auth so failures surface with a clear message. */
export async function ensureAppCheckToken(): Promise<void> {
  if (!appCheckInstance) {
    throw new Error('App Check is not initialized. Check VITE_FIREBASE_RECAPTCHA_SITE_KEY.');
  }
  await getToken(appCheckInstance, true);
}
