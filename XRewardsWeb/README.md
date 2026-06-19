# XRewards Web

Member portal + admin dashboard for `xrewards-c0524`.

## URLs

- **Member app (default):** https://xrewards-c0524.web.app
- **Admin dashboard:** https://xrewards-c0524.web.app/admin
- **Firebase project:** `xrewards-c0524`

## Member web app

The website now mirrors the iOS member experience:

| Tab | Features |
|-----|----------|
| **Home** | Points balance, dividend estimate, active revenue streams, guest preview banner |
| **Earn** | All 6 revenue categories with point tables and referral submission |
| **Activity** | Transaction history + referrals filter |
| **Team** | Team stats, invite sheet |
| **Profile** | Account, How It Works, Dividends, support links, language toggle |

Also includes:

- **Guest mode** — anonymous Firebase auth, mock preview data, cannot submit referrals
- **Sign in / Sign up** — email/password + Google
- **简体中文 / English** — default Simplified Chinese (same as iOS)
- **Live data** — `getRewardsData`, `submitReferral`, `updateProfile` via Cloud Functions

## Admin dashboard

Moved to `/admin` (referrals inbox, member points, conversion bonuses).

## App Check (required for admin sign-in)

This project enforces **App Check on Firebase Authentication**. The web dashboard must register App Check too.

### One-time setup

1. **Firebase Console → App Check → Apps**
2. Select the **Web** app (`1:437299972021:web:3555266d7c38338eab3bfc`)
3. Click **Register** → choose **reCAPTCHA Enterprise** (recommended; 10k free/month)
   - Legacy **reCAPTCHA v3** still works if you prefer — set `VITE_APP_CHECK_USE_ENTERPRISE=false`
4. Firebase/Google Cloud will create a **site key** — copy it into `.env`:

```bash
VITE_FIREBASE_RECAPTCHA_SITE_KEY=your-recaptcha-v3-site-key
```

5. **Local development:** keep `VITE_APP_CHECK_DEBUG=true` in `.env`
6. Run `npm run dev`, open the browser console, copy the **App Check debug token**
7. **Firebase Console → App Check → Manage debug tokens** → add that token

8. **Production hosting:** after deploy, reCAPTCHA v3 protects the live site (add your hosting domain in reCAPTCHA settings if prompted).

### Error: `auth/firebase-app-check-token-is-invalid`

- reCAPTCHA site key missing or wrong in `.env`
- Web app not registered in App Check
- Debug token not registered (local dev)
- Rebuild and redeploy hosting after updating `.env`

## Local development

```bash
cd XRewardsWeb
cp .env.example .env   # already present if cloned
npm install
npm run dev
```

Deploy hosting from the **repo root** (or use the script):

```bash
./XRewardsWeb/scripts/deploy-hosting.sh
```

## First-time admin setup

1. In **Firebase Console → Authentication**, create an admin user (email/password) — use a dedicated ops email, not a member test account.

2. Copy that user's **UID** from Authentication.

3. In **Firestore**, create:

```
adminUsers/{UID}
  active: true
  email: "ops@yourcompany.com"
  createdAt: (timestamp)
```

4. Deploy Cloud Functions (includes admin callables):

```bash
./scripts/deploy-functions.sh
```

5. Deploy the dashboard (from repo root):

```bash
chmod +x XRewardsWeb/scripts/deploy-hosting.sh
./XRewardsWeb/scripts/deploy-hosting.sh
```

6. Open the hosting URL and sign in with the admin account.

## Admin capabilities

| Screen | What it does |
|--------|----------------|
| **Referrals** | All member referrals from the iOS app |
| **Confirm lead** | Moves 10 lead points from pending → confirmed |
| **Award sale** | Adds conversion points (e.g. 2,500 insurance) when purchase completes |
| **Members** | Points balances for all XRewards users |
| **Member detail** | Full transaction / reward history |

## Data model

Member submissions still write to:

- `users/{uid}/referrals/{id}`
- `users/{uid}/transactions/{id}`

Each submission also mirrors to:

- `adminReferrals/{referrerUid}_{referralId}`

## Default conversion points

| Category | Sale bonus |
|----------|------------|
| Insurance | 2,500 |
| Loans | 1,000 |
| Real Estate | 10,000 |
| App Ecosystem | 200 |
| Content | 500 |
| Training | 1,000 |

Override per award in the dashboard prompt.

## Deploy functions only

From monorepo (or use the script from this repo):

```bash
./XRewardsWeb/scripts/deploy-functions.sh
```

Or directly:

```bash
cd ../../../../KidsAdventure/adventure-platform-monorepo
./deploy_xrewards_functions.sh
```
