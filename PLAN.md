# XRewards iOS — Implementation Plan

> **Repository:** [https://github.com/mikeboomsung/XRewardsiOS.git](https://github.com/mikeboomsung/XRewardsiOS.git) (remote exists; **local git not initialized yet**)  
> **Reference design:** `Diagram.png` (platform overview infographic)  
> **Current state:** Fresh SwiftUI Xcode project (`XRewards`) with placeholder `ContentView`; `GoogleService-Info.plist` added; entitlements configured for Apple Sign In, push (`aps-environment`), and **App Attest**; **FCM push**, **Auth (Apple, Google, Email, Anonymous)**, **Cloud Firestore**, and **Realtime Database** enabled in Firebase Console
> **Language rollout:** English first → Simplified Chinese (`zh-Hans`) second

### Firebase project (configured)

| Setting | Value |
|---------|-------|
| Firebase project name | XRewards |
| Project ID | `xrewards-c0524` |
| Project number | `437299972021` |
| iOS app nickname | XRewards iOS |
| Bundle ID | `com.vaiholding.XRewards` |
| Apple Team ID | `XS89J2Z82F` |
| Google App ID | `1:437299972021:ios:51f9db6ce2271692ab3bfc` |
| Config file | `XRewards/GoogleService-Info.plist` (in repo) |
| App Check | **App Attest only** — DeviceCheck provider **not** used |
| Push notifications | **Enabled** — Firebase Cloud Messaging; APNs configured in Firebase Console |
| Authentication | **Enabled** — Apple, Google, Email/Password, Anonymous (Firebase Authentication) |
| Cloud Firestore | **Enabled** — primary app data store (Phase 3) |
| Realtime Database | **Enabled** — available for low-latency / live data (use case TBD) |

---

## 1. Product Summary

XRewards is a **team-based, multi-stream rewards platform** where members earn **permanent points** from real business activities (insurance, loans, real estate, app ecosystem, content creation). Platform profits feed a **monthly reward pool** (30–50% of profits), and members receive dividends proportional to their share of total points — a “passive income” model where points never expire.

The iOS app is the **member-facing hub** for:

- Understanding the business model and value proposition
- Tracking points, earnings history, and monthly dividends
- Discovering and acting on revenue opportunities across categories
- Managing team membership and growth
- Accessing training, events, and support resources

---

## 2. Core Concepts (from Diagram)

### 2.1 Five Value Pillars

| Pillar | Chinese (reference) | English (v1 copy) | App expression |
|--------|---------------------|-------------------|----------------|
| Visible income | 能赚钱 | Make Money | Dashboard with clear earnings + point totals |
| Passive income | 持续赚 | Continuous Earning | Dividend history, “passive income” explainer |
| Fair rules | 有保障 | Security & Fairness | Transparent rules, reward pool %, settlement schedule |
| Community | 有归属 | Belonging | Team view, culture/training section |
| Personal growth | 有成长 | Growth | Training, events, promotion path |

### 2.2 Revenue Categories (Business Modules)

| Category | Icon (SF Symbol) | Example actions | Point range (from diagram) |
|----------|------------------|-----------------|----------------------------|
| Insurance | `umbrella.fill` | Referral, sale | 100–500 / 500–5,000 |
| Loans | `building.columns.fill` | Referral, sale | 200–1,000 / 1,000–10,000 |
| Real Estate | `house.fill` | Sale | 2,000–20,000 |
| App Ecosystem | `apps.iphone` | Download, paid conversion | 5–20 / 50–500 |
| Content Creation | `square.and.pencil` | Share, publish | 50–1,000 |
| Training & Events | `person.3.fill` | Attend, host | 100–5,000 |

### 2.3 Points & Reward Pool Rules

- Points are **permanently valid** and **accumulate** — never reset.
- Each confirmed transaction binds to the referring member permanently.
- **30–50%** of platform profit enters the reward pool each period.
- **Monthly settlement:** dividend = `(user points / total platform points) × reward pool`.
- Retention narrative: long-term passive income vs. one-time commission models (90% vs 20% chart in diagram).

### 2.4 Member Workflow (5 Steps)

Use as onboarding / “How It Works” flow:

1. **Act** — Recommend a customer or create value (one-time action, permanent binding).
2. **Confirm** — Transaction verified; points credited permanently.
3. **Pool** — Platform profit flows into the reward pool.
4. **Dividend** — Monthly payout based on point proportion.
5. **Sustain** — Points remain valid; income continues over time.

---

## 3. App Scope & Phasing

### Phase 0 — Foundation (Week 1)

- [ ] Initialize git repo, add `.gitignore`, connect to GitHub remote, initial push
- [x] Add `GoogleService-Info.plist` to `XRewards/` (matches bundle ID `com.vaiholding.XRewards`)
- [ ] Add Firebase SDK via Swift Package Manager (see §4.5)
- [ ] Bootstrap Firebase + **App Check (App Attest provider)** in `XRewardsApp` (see §4.5)
- [ ] Register App Attest key in Firebase Console after first device run
- [ ] Restrict target to **iPhone only** (project currently supports macOS/iPad/visionOS — narrow scope for v1)
- [ ] Project structure, design tokens, navigation shell
- [ ] English String Catalog (`Localizable.xcstrings`) — all user-facing strings from day one
- [ ] Mock data layer for development without backend

### Phase 1 — English MVP (Weeks 2–5)

Read-only + lightweight interaction app demonstrating full product story:

| Screen | Purpose |
|--------|---------|
| **Home / Dashboard** | Point balance, estimated monthly dividend, active streams summary |
| **Earn** | Category grid with point ranges and “Learn more” per category |
| **How It Works** | 5-step workflow + reward pool explainer |
| **Activity** | Point transaction history (earned, pending, confirmed) |
| **Dividends** | Monthly payout history + current-period estimate |
| **Team** | Team size, structure placeholder, invite CTA |
| **Profile / Settings** | Account, language (disabled until Phase 2), rules & support links |

**MVP does not require:** real payments, live CRM integrations, or admin tools.

### Phase 2 — Chinese Localization (Week 6)

- [ ] Add `zh-Hans` to project localizations
- [ ] Translate all String Catalog keys (reference `Diagram.png` terminology)
- [ ] Verify layout: longer English vs. compact Chinese labels
- [ ] In-app language override in Settings (optional; system locale is default)
- [ ] App Store metadata in both languages

### Phase 3 — Backend Integration (Weeks 7–10)

- [ ] **Firebase Auth** — wire Apple, Google, Email, and Anonymous sign-in (**all enabled in Console**); link anonymous → permanent account when user upgrades
- [ ] **Cloud Firestore** — replace mock service with live reads/writes; security rules + App Check enforcement (**Console enabled**)
- [ ] **Realtime Database** (optional) — use only if a feature needs RTDB; avoid duplicating Firestore documents
- [ ] Attach **App Check token** on all Firebase requests (Firestore, Auth, FCM, RTDB if used)
- [ ] Cloud Functions for server-side logic (dividend settlement, point confirmation) — TBD
- [ ] Real point balances, activity feed, dividend calculations (Firestore-backed)
- [ ] **Firebase Cloud Messaging** — wire client SDK, permission prompt, token registration, notification handlers (monthly dividend, point confirmed, team updates); **Console + APNs already enabled**
- [ ] Deep links for referrals / invite flow

### Phase 4 — Growth Features (Post-MVP)

- Referral link generation & sharing
- In-app training content (video/articles)
- Leaderboards / team analytics
- KYC / payout method management
- Partner app deep links (App Ecosystem category)

---

## 4. Technical Architecture

### 4.1 Stack

| Layer | Choice | Notes |
|-------|--------|-------|
| UI | SwiftUI | Already in project; **deployment target iOS 16.6** in Xcode — bump to **iOS 17+** recommended for `@Observable` and modern APIs |
| Architecture | MVVM + `@Observable` | Match Swift 5.9+ patterns; project uses `@MainActor` default |
| Navigation | `NavigationStack` + tab bar | 5 tabs: Home, Earn, Activity, Team, Profile |
| Backend / BaaS | **Firebase** | Project `xrewards-c0524`; config in `GoogleService-Info.plist` |
| Primary database | **Cloud Firestore** | **Console enabled** — users, transactions, dividends, team, categories |
| Live / secondary DB | **Realtime Database** | **Console enabled** — optional (e.g. live pool ticker, presence); default to Firestore unless latency requires RTDB |
| App integrity | **Firebase App Check — App Attest** | Attest only; **no DeviceCheck provider** (per Firebase Console setup) |
| Auth (Phase 3) | **Firebase Authentication** | **Console enabled:** Apple, Google, Email/Password, Anonymous; Apple entitlement + `GoogleService-Info.plist` `CLIENT_ID` ready |
| Push | **Firebase Cloud Messaging** | **Enabled in Firebase Console** (APNs key uploaded); `aps-environment` entitlement = `development`; client wiring in Phase 3 |
| Networking | `URLSession` + async/await | Wrap in `APIClient` protocol; attach App Check token + Firebase ID token on protected calls |
| Persistence (local) | Keychain + Firestore cache | Auth tokens in Keychain; Firestore SDK provides offline persistence for dashboard/activity |
| Localization | String Catalogs | `LOCALIZATION_PREFERS_STRING_CATALOGS = YES` already enabled |
| Dependencies | Firebase iOS SDK + Google Sign-In (SPM) | Phase 0: `FirebaseCore`, `FirebaseAppCheck` · Phase 3: `FirebaseAuth`, `FirebaseFirestore`, `FirebaseDatabase` (if RTDB used), `FirebaseMessaging`, `GoogleSignIn` |

### 4.2 Proposed Folder Structure

```
XRewards/
├── App/
│   └── XRewardsApp.swift          # Firebase.configure() + App Check bootstrap
├── GoogleService-Info.plist       # Firebase iOS config (committed)
├── XRewards.entitlements          # Apple Sign In, push, App Attest
├── Core/
│   ├── Design/
│   │   ├── Theme.swift              # Colors, typography, spacing
│   │   └── Components/              # Reusable UI (cards, badges, charts)
│   ├── Models/
│   │   ├── PointTransaction.swift
│   │   ├── RevenueCategory.swift
│   │   ├── DividendPeriod.swift
│   │   ├── TeamMember.swift
│   │   └── UserProfile.swift
│   ├── Services/
│   │   ├── MockRewardsService.swift
│   │   ├── FirestoreRewardsService.swift  # Live Firestore reads (Phase 3)
│   │   ├── RewardsService.swift           # Protocol
│   │   ├── AuthService.swift              # Firebase Auth wrapper (Phase 3)
│   │   └── APIClient.swift                # Cloud Functions HTTP (if needed)
│   └── Extensions/
├── Features/
│   ├── Auth/                        # Login, sign-up, account linking (Phase 3)
│   ├── Home/
│   ├── Earn/
│   ├── HowItWorks/
│   ├── Activity/
│   ├── Dividends/
│   ├── Team/
│   └── Profile/
├── Resources/
│   ├── Assets.xcassets
│   └── Localizable.xcstrings
└── Preview Content/
    └── PreviewData.swift
```

### 4.3 Data Models (Domain)

```swift
// Conceptual — implement in Phase 0/1

enum RevenueCategory: String, CaseIterable, Identifiable {
    case insurance, loans, realEstate, appEcosystem, content, training
}

enum TransactionStatus: String {
    case pending, confirmed, rejected
}

struct PointTransaction: Identifiable {
    let id: UUID
    let category: RevenueCategory
    let action: String           // e.g. "Insurance Referral"
    let points: Int
    let status: TransactionStatus
    let createdAt: Date
    let confirmedAt: Date?
}

struct DividendPeriod: Identifiable {
    let id: UUID
    let month: Date
    let poolAmount: Decimal
    let totalPlatformPoints: Int
    let userPoints: Int
    let userShare: Decimal       // 0.0–1.0
    let payoutAmount: Decimal
    let status: DividendStatus   // estimated, processing, paid
}

struct DashboardSummary {
    let totalPoints: Int
    let pendingPoints: Int
    let estimatedMonthlyDividend: Decimal
    let rewardPoolPercentRange: ClosedRange<Int>  // 30...50
    let lastSettlementDate: Date?
    let activeCategories: [RevenueCategory]
}

struct TeamSummary {
    let directMembers: Int
    let totalDownline: Int
    let teamPoints: Int
}
```

### 4.4 Data Layer — Firestore Schema (Phase 3)

**Cloud Firestore** is the **primary** backend for member data. **Realtime Database** is enabled but used only when a feature needs RTDB’s low-latency listeners (avoid storing the same data in both).

**Proposed Firestore collections** (align with §4.3 domain models):

```
users/{uid}
  ├── profile: { name, memberSince, memberId, locale }
  ├── points: { total, pending }
  └── fcmTokens/{tokenId}: { token, updatedAt }

users/{uid}/transactions/{transactionId}
  ├── category, action, points, status, createdAt, confirmedAt

users/{uid}/dividends/{periodId}
  ├── month, poolAmount, totalPlatformPoints, userPoints, userShare, payoutAmount, status

users/{uid}/team
  ├── directMembers, totalDownline, teamPoints, uplineUid (optional)

categories/{categoryId}          # static or admin-managed point rules
  ├── nameKey, icon, pointRanges, descriptionKey

platform/currentPeriod           # singleton doc for live dividend estimate
  ├── poolAmount, totalPlatformPoints, poolPercent, settlementDate

referrals/{referralId}           # Phase 4
  ├── uid, code, createdAt
```

**Swift mapping:** `FirestoreRewardsService` implements `RewardsService`; decode Firestore documents into `PointTransaction`, `DividendPeriod`, `DashboardSummary`, etc.

**Security rules (Phase 3 — before production):**

- Require `request.auth != null` for all member data
- Scope reads/writes to `users/{uid}` where `request.auth.uid == uid`
- Enable **App Check** enforcement for Firestore in Firebase Console
- `categories` and `platform/currentPeriod`: read-only for authenticated users; writes via Admin SDK / Cloud Functions only

**Optional Realtime Database paths** (only if needed):

```
live/rewardPool          # real-time pool total for dashboard ticker
presence/{uid}           # online status (Phase 4)
```

**REST / Cloud Functions** (optional complement — not required if Firestore covers reads):

| Trigger | Purpose |
|---------|---------|
| Callable: `confirmTransaction` | Admin/automation confirms pending points |
| Callable: `settleDividends` | Monthly dividend batch (server-side math) |
| HTTP: legacy integrations | CRM webhooks → write Firestore via Functions |

*Mock service (`MockRewardsService`) returns static data matching these shapes during Phase 1.*

### 4.5 Firebase, App Check, Auth, Database & Push Setup

**Swift Package Manager** — add the [Firebase iOS SDK](https://github.com/firebase/firebase-ios-sdk) to the Xcode project:

| Product | Phase | Purpose |
|---------|-------|---------|
| `FirebaseCore` | 0 | SDK initialization |
| `FirebaseAppCheck` | 0 | App Attest attestation on every Firebase/backend request |
| `FirebaseAuth` | 3 | Apple, Google, Email/Password, Anonymous — **Console enabled**; client login UI + session |
| `FirebaseFirestore` | 3 | Primary data store — **Console enabled**; user profile, transactions, dividends, team |
| `FirebaseDatabase` | 3 (optional) | Realtime Database — **Console enabled**; add only if a feature needs RTDB listeners |
| `FirebaseMessaging` | 3 | Push notifications — **Console enabled**; register FCM token + handle notifications in app |

**App launch bootstrap** (implement in Phase 0):

```swift
import FirebaseCore
import FirebaseAppCheck

@main
struct XRewardsApp: App {
    init() {
        #if targetEnvironment(simulator)
        // Simulator: App Attest unavailable — use debug provider + register token in Firebase Console
        AppCheck.setAppCheckProviderFactory(AppCheckDebugProviderFactory())
        #else
        // Physical iPhone (Debug or Release): App Attest only (NOT DeviceCheck)
        AppCheck.setAppCheckProviderFactory(AppAttestProviderFactory())
        #endif
        FirebaseApp.configure()
    }
    // ...
}
```

**App Attest vs DeviceCheck (decision locked):**

| Provider | Use in XRewards |
|----------|-----------------|
| **App Attest** | ✅ Production attestation (iOS 14+, physical devices, signed builds) |
| **DeviceCheck** | ❌ Not enabled — do not add `DeviceCheckProviderFactory` |
| **Debug provider** | ✅ Simulator only (`#if targetEnvironment(simulator)`) |

**Entitlements** (`XRewards.entitlements` — already present):

- `com.apple.developer.devicecheck.appattest-environment` → `development` (switch to `production` for App Store release)
- `com.apple.developer.applesignin` → Default
- `aps-environment` → `development` (switch to `production` before App Store release)

**Authentication (Firebase Authentication — Console enabled):**

| Provider | Firebase Console | iOS client (Phase 3) |
|----------|------------------|----------------------|
| **Apple** | ✅ Enabled | `AuthenticationServices` + `OAuthProvider.appleCredential`; entitlement already in `XRewards.entitlements` |
| **Google** | ✅ Enabled | [Google Sign-In iOS SDK](https://github.com/google/GoogleSignIn-iOS) + `GoogleAuthProvider`; add URL scheme from `REVERSED_CLIENT_ID` in plist |
| **Email / Password** | ✅ Enabled | Email + password sign-up/sign-in forms; enable email verification in Console if required |
| **Anonymous** | ✅ Enabled | `Auth.auth().signInAnonymously()` for guest browse; **link** to Apple/Google/Email when user registers (`link(with:)` / `link(withEmail:password:)`) |
| Phone OTP | ❌ Not enabled | Add later if needed for China / SMS flows |
| WeChat | ❌ Not enabled | Separate provider; evaluate for zh-Hans market |

**Google Sign-In URL scheme** (add to Info.plist in Phase 3):

```
REVERSED_CLIENT_ID = com.googleusercontent.apps.437299972021-6sv3lt43t2alq9lgpf83uudj3rq3u0ma
```

**Suggested auth UX (Phase 3):**

1. **Phase 1 MVP:** No login gate — mock data only.
2. **Phase 3 launch:** Optional anonymous session on first open → prompt sign-in when viewing real balances, team, or dividends.
3. **Login screen:** Primary buttons — Continue with Apple, Continue with Google; secondary — Email sign-in / sign-up.
4. **Account linking:** If user started anonymous, preserve UID when linking to a permanent provider.
5. **Profile → Sign out:** `Auth.auth().signOut()`; clear Keychain tokens.

**Push notifications (Firebase Cloud Messaging — Console enabled):**

| Layer | Status |
|-------|--------|
| Firebase Console → Cloud Messaging | ✅ Enabled; APNs authentication key uploaded |
| Xcode capability / entitlements | ✅ `aps-environment` present |
| Apple Developer → Push Notifications capability | ✅ Required for device builds |
| Client SDK (`FirebaseMessaging`) | Phase 3 — request permission, register token, handle foreground/background payloads |

**Phase 3 client setup** (when implementing push):

1. Add `FirebaseMessaging` SPM product; set `UNUserNotificationCenter` delegate and `MessagingDelegate`.
2. Request notification permission on first launch or after sign-in.
3. Register for remote notifications; forward APNs token to FCM via `Messaging.messaging().apnsToken`.
4. Subscribe to topics or store FCM token per user in backend (e.g. dividend alerts, point confirmed, team updates).
5. Handle notification tap → deep link to Activity, Dividends, or Team tab.

**Cloud Firestore & Realtime Database (Console enabled):**

| Layer | Status |
|-------|--------|
| Cloud Firestore | ✅ Enabled — **primary** data store for Phase 3 |
| Realtime Database | ✅ Enabled — optional for live/low-latency features only |
| Firestore security rules | Phase 3 — auth-scoped rules + App Check enforcement before production |
| Offline persistence | Built into Firestore iOS SDK — dashboard/activity usable offline after first fetch |

**Phase 3 client setup** (when implementing Firestore):

1. Add `FirebaseFirestore` SPM product; enable persistence (default on iOS).
2. Implement `FirestoreRewardsService` behind `RewardsService` protocol; swap mock → live via dependency injection.
3. Listen to `users/{uid}` and subcollections with `addSnapshotListener` for live dashboard/activity updates.
4. Write FCM tokens to `users/{uid}/fcmTokens` after sign-in.
5. Publish Firestore security rules; enable App Check enforcement for Firestore in Console.
6. Add `FirebaseDatabase` **only** if implementing RTDB paths (e.g. live reward pool ticker).

**Firebase Console checklist (post–first device run):**

1. **App Check → Apps → XRewards iOS** — confirm App Attest provider is registered (not DeviceCheck).
2. After first signed build on a physical device, verify the App Attest key appears under registered apps.
3. **Debug builds:** App Check → Manage debug tokens → register token printed in Xcode console.
4. ~~Upload APNs authentication key~~ — **done** (push enabled in Firebase Console).
5. **Phase 3:** Send test message from Firebase Console → Cloud Messaging to verify end-to-end delivery on device.
6. ~~Enable Auth providers (Apple, Google, Email, Anonymous)~~ — **done** in Firebase Console → Authentication → Sign-in method.
7. ~~Enable Cloud Firestore and Realtime Database~~ — **done** in Firebase Console.
8. **Phase 3:** Deploy Firestore security rules; enable App Check enforcement for Firestore (and RTDB if used).
9. **Phase 3:** Seed `categories` collection and `platform/currentPeriod` doc for dividend estimates.
10. Enforce App Check on Cloud Functions when added.

**Simulator note:** App Attest does not run on Simulator — use the debug provider there only. **Physical iPhone** (primary test device) uses App Attest in both Debug and Release builds; verify the key appears in Firebase Console after the first device run.

---

## 5. UI / UX Design System

Derived from `Diagram.png`:

### 5.1 Visual Identity

| Token | Value | Usage |
|-------|-------|-------|
| Background primary | Deep navy `#0A1628` | Screen backgrounds |
| Background card | `#132238` | Cards, list rows |
| Accent gold | `#D4AF37` | CTAs, point highlights, icons |
| Text primary | White `#FFFFFF` | Headlines |
| Text secondary | `#A0AEC0` | Body, captions |
| Success | `#48BB78` | Confirmed transactions |
| Pending | `#ECC94B` | Pending state |

Add colors to `Assets.xcassets` as named color sets (supports light/dark if needed later).

### 5.2 Typography

- **Large title:** Dashboard point total (`.largeTitle.bold()`)
- **Title 2:** Section headers
- **Headline:** Card titles
- **Subheadline / Caption:** Metadata, dates, status

Use SF Pro; ensure Dynamic Type support for accessibility.

### 5.3 Key Components

| Component | Used on |
|-----------|---------|
| `PointBalanceCard` | Home — hero metric |
| `DividendEstimateCard` | Home — monthly estimate |
| `CategoryTile` | Earn grid |
| `TransactionRow` | Activity list |
| `WorkflowStepView` | How It Works |
| `RetentionChartView` | How It Works / marketing (90% vs 20% line chart) |
| `ValuePillarRow` | Home or About — 5 pillars |
| `TeamStatCard` | Team tab |

### 5.4 Navigation

```
TabView
├── Home          → Dashboard + quick links to How It Works
├── Earn          → Category grid → Category detail
├── Activity      → Transaction list → Transaction detail
├── Team          → Team summary + invite
└── Profile       → Settings, rules, support, language (Phase 2)
```

---

## 6. Screen Specifications

### 6.1 Home (Dashboard)

**Header:** Greeting + notification bell (Phase 3)

**Hero section:**
- Total points (large, gold accent)
- Subtitle: “Permanent · Never expire”

**Cards (vertical stack):**
1. Estimated this month’s dividend (amount + “Based on current pool”)
2. Pending points (awaiting confirmation)
3. Active revenue streams (chips for categories with recent activity)

**Footer:** Link to “How passive income works” → How It Works screen

### 6.2 Earn

**Grid (2 columns):** One tile per `RevenueCategory`

Each tile shows:
- Icon + category name
- Point range (e.g. “100 – 5,000 pts”)
- Tap → **Category Detail** with:
  - Description of actions (referral vs sale)
  - Point table per action type
  - CTA: “Start earning” (Phase 3: opens referral flow; MVP: informational)

### 6.3 How It Works

- **5-step horizontal stepper** (or vertical timeline on small phones)
- **Reward pool diagram:** 30–50% of profit → pool → proportional split
- **Retention chart:** Traditional one-time vs XRewards long-term model
- **Five value pillars** section

### 6.4 Activity

- Segmented filter: All | Pending | Confirmed
- List of `PointTransaction` rows: category icon, action, points (+/-), date, status badge
- Pull-to-refresh (Phase 3)

### 6.5 Dividends

- **Current period card:** estimated payout, pool size, your share %, settlement date
- **History list:** past months with paid amounts
- Explainer footer: calculation formula in plain language

### 6.6 Team

- Stats: direct members, total team, team points
- Placeholder for org chart / member list (Phase 4)
- **Invite button** → share sheet with referral message (Phase 4)

### 6.7 Profile & Settings

- User name, member ID, join date
- Links: Reward rules, FAQ, Contact support
- **Language** (Phase 2): System default | English | 简体中文
- Sign out (Phase 3)

---

## 7. Localization Strategy

### 7.1 Principles

1. **English is the source language** — all keys authored in English first.
2. **No hard-coded UI strings** — use String Catalog from Phase 0.
3. **Reference terminology** from `Diagram.png` for Chinese consistency.

### 7.2 Key Term Glossary

| English | 简体中文 (zh-Hans) | Notes |
|---------|-------------------|-------|
| Points | 积分 | Core currency |
| Reward Pool | 奖励池 | |
| Dividend | 分红 | Monthly payout |
| Passive Income | 持续收益 | Avoid literal “躺赚” in formal UI; usable in marketing copy |
| Permanent | 永久有效 | Points never expire |
| Referral | 推荐 | |
| Confirmed | 已确认 | Transaction status |
| Pending | 待确认 | |
| Insurance | 保险 | |
| Loans | 贷款 | |
| Real Estate | 房产 | |
| App Ecosystem | 应用生态 | |
| Content Creation | 内容创作 | |
| Training & Events | 培训与活动 | |
| Make Money | 能赚钱 | Value pillar |
| Continuous Earning | 持续赚 | Value pillar |
| Security & Fairness | 有保障 | Value pillar |
| Belonging | 有归属 | Value pillar |
| Growth | 有成长 | Value pillar |

### 7.3 Implementation Steps (Phase 2)

1. Xcode → Project → Info → Localizations → add **Chinese (Simplified)**
2. Export/import `Localizable.xcstrings` for translator review
3. Test on device with Settings → Language → 简体中文
4. Audit layouts: navigation titles, button widths, multi-line labels
5. Localize App Store Connect listing separately

### 7.4 Formatting

- Use `FormatStyle` / `NumberFormatter` with `Locale.current` for points and currency
- Dates: `Date.FormatStyle(date: .abbreviated, time: .omitted)`
- Currency: store as `Decimal`; display with locale-appropriate symbol when payouts go live

---

## 8. Mock Data (Phase 1)

Provide realistic demo data so the app is presentable without backend:

```json
{
  "user": {
    "name": "Alex Chen",
    "memberSince": "2025-03-15",
    "totalPoints": 12450,
    "pendingPoints": 800
  },
  "estimatedDividend": {
    "amount": 186.75,
    "currency": "USD",
    "settlementDate": "2026-07-01",
    "poolPercent": 40
  },
  "transactions": [
    { "category": "insurance", "action": "Insurance Sale", "points": 2500, "status": "confirmed", "date": "2026-06-01" },
    { "category": "appEcosystem", "action": "App Paid User", "points": 200, "status": "confirmed", "date": "2026-06-10" },
    { "category": "loans", "action": "Loan Referral", "points": 500, "status": "pending", "date": "2026-06-14" }
  ]
}
```

---

## 9. Testing Plan

| Type | Scope |
|------|-------|
| Unit tests | Point share calculation, dividend estimate formula, model decoding |
| UI tests | Tab navigation, How It Works flow, Activity filters |
| Snapshot tests | Optional — dashboard and Earn grid in EN + zh-Hans |
| Manual QA | Dynamic Type, VoiceOver labels, offline mock mode |
| Localization QA | All screens in both languages; no truncated text |

**Dividend formula test case:**

```
userPayout = (userPoints / totalPlatformPoints) × poolAmount
Example: (12450 / 500000) × 7500 = 186.75
```

---

## 10. Security & Compliance (Early Considerations)

- **Firebase App Check (App Attest)** on Firestore, Auth, FCM, and RTDB (if used) — blocks unverified clients
- **No DeviceCheck provider** — single attestation path via App Attest simplifies Console config and client code
- Store auth tokens in **Keychain**, not UserDefaults
- `GoogleService-Info.plist` is committed (standard for Firebase iOS); restrict Firebase API keys in [Google Cloud Console](https://console.cloud.google.com/) by iOS bundle ID
- HTTPS only; certificate pinning optional for v1
- Privacy policy & terms required before App Store submission (financial/rewards apps)
- Clearly disclose: estimates are not guarantees; rules subject to platform policy
- Avoid promising fixed returns in copy — align with diagram’s “proportion-based” language
- GDPR/CCPA: data export & deletion if storing PII (Phase 3+)
- Before App Store release: set App Attest entitlement to `production` and push `aps-environment` to `production`

---

## 11. App Store & Release

| Item | English | Chinese (Phase 2) |
|------|---------|-------------------|
| App name | XRewards | XRewards（易享奖励） — TBD |
| Subtitle | Team rewards & passive income | 团队奖励与持续收益 |
| Category | Finance or Business | Same |
| Screenshots | 6.7" + 6.1" iPhone | Separate set for zh-Hans |
| Age rating | 4+ or 12+ depending on financial content | |

**Version roadmap:**

- **1.0** — English MVP with mock data
- **1.1** — Simplified Chinese localization
- **1.2** — Live backend + auth
- **2.0** — Referrals, push, payouts

---

## 12. Git & Collaboration

```bash
# Initial setup (if not already done)
cd XRewardsiOS
git init
git remote add origin https://github.com/mikeboomsung/XRewardsiOS.git
git add .
git commit -m "Add implementation plan and initial Xcode project"
git branch -M main
git push -u origin main
```

**Branch strategy:**
- `main` — stable, release-ready
- `develop` — integration branch
- `feature/*` — per feature (e.g. `feature/home-dashboard`, `feature/localization-zh-hans`)

**Recommended `.gitignore`:** Xcode user data, DerivedData, `.DS_Store`, `*.xcuserstate`, secrets (`Config.xcconfig` with API keys).  
**Commit:** `GoogleService-Info.plist` (Firebase convention), `XRewards.entitlements`, `PLAN.md`, source.  
**Do not commit:** App Check debug tokens, APNs `.p8` keys, service account JSON.

---

## 13. Open Questions (Resolve Before Phase 3)

| # | Question | Status | Impact |
|---|----------|--------|--------|
| 1 | Backend technology & API spec — existing or greenfield? | **Mostly resolved:** Firebase (`xrewards-c0524`); Firestore + RTDB enabled; Cloud Functions TBD | Data layer & server logic |
| 2 | Auth method: phone OTP, email, WeChat, Apple Sign In? | **Mostly resolved:** Apple, Google, Email, Anonymous enabled in Firebase; phone & WeChat not enabled | Login flow, China market |
| 3 | Payout currency & regions (USD, CNY, both)? | Open | Dividend display |
| 4 | Minimum iOS version (16.6 vs 17+)? | **Leaning 17+** for `@Observable`; current Xcode target is 16.6 | API availability |
| 5 | Is team hierarchy multi-level or direct-only in v1? | Open | Team screen complexity |
| 6 | Real referral deep links / universal links domain? | Open | Invite feature |
| 7 | Admin approval for point confirmation or fully automated? | Open | Activity statuses |
| 8 | Legal review of “passive income” marketing copy for App Store | Open | Copy & screenshots |
| 9 | App Check enforcement scope (which Firebase/API services)? | **Partially resolved:** Firestore, Auth, FCM ready to enforce; RTDB/Functions when used | Security |
| 10 | Require sign-in before MVP browse, or anonymous-first? | Open — Anonymous provider available | Phase 3 gate timing |
| 11 | Firestore-only vs also use Realtime Database? | Open — both enabled; default Firestore primary | Data architecture |

---

## 14. Implementation Order (Checklist)

### Sprint 0 — Repo & Firebase Bootstrap
- [ ] `git init`, `.gitignore`, push to [GitHub remote](https://github.com/mikeboomsung/XRewardsiOS.git)
- [ ] Add Firebase SPM packages (`FirebaseCore`, `FirebaseAppCheck`)
- [ ] Wire App Check: App Attest (release) + debug provider (DEBUG)
- [ ] Narrow `SUPPORTED_PLATFORMS` to iPhone only; set deployment target to iOS 17+
- [ ] Register App Attest / debug token in Firebase Console

### Sprint 1 — Shell & Design System
- [ ] Create folder structure
- [ ] `Theme.swift` + asset colors
- [ ] Tab navigation shell
- [ ] String Catalog with English keys for all tabs/screens

### Sprint 2 — Models & Mock Service
- [ ] Domain models
- [ ] `MockRewardsService` + `PreviewData`
- [ ] `@Observable` view models for Home, Earn, Activity

### Sprint 3 — Core Screens (English)
- [ ] Home dashboard
- [ ] Earn grid + category detail
- [ ] How It Works
- [ ] Activity list

### Sprint 4 — Remaining Screens & Polish
- [ ] Dividends
- [ ] Team
- [ ] Profile
- [ ] Retention chart component
- [ ] Accessibility pass

### Sprint 5 — Chinese Localization
- [ ] Add `zh-Hans` localization
- [ ] Complete translations using glossary
- [ ] Layout QA both languages

### Sprint 6+ — Backend & Launch
- [ ] API integration
- [ ] Auth
- [ ] TestFlight → App Store

---

## 15. Success Criteria

**English MVP (v1.0):**
- All 7 main areas navigable with coherent mock data
- Dashboard shows points, estimate, and pending state
- How It Works accurately reflects diagram business logic
- 100% user-facing strings in String Catalog
- Builds and runs on iPhone simulator and device

**Chinese (v1.1):**
- Full app usable in Simplified Chinese via system locale
- No layout breaks; glossary terms consistent with diagram
- App Store metadata localized

**Production (v1.2+):**
- Live data; secure auth; push for dividend events
- Crash-free rate > 99.5% on TestFlight

---

*Document version: 1.4 · Updated with Cloud Firestore and Realtime Database enabled in Console · June 16, 2026*
