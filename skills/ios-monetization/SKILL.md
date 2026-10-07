---
name: ios-monetization
description: Add and verify in-app purchases and subscriptions in an iOS app with RevenueCat or StoreKit 2 — products, offerings, entitlements, paywalls, restore, sandbox and StoreKit-config testing, and revenue metrics. Use for "add a paywall", "set up subscriptions", "RevenueCat", "StoreKit", "why isn't my purchase working", or pricing questions.
---

# iOS Monetization

## 1. Decide the stack

- If the project already uses RevenueCat (`import RevenueCat`, `Purchases.configure`) or StoreKit 2 directly, stay with it.
- For a new setup, recommend RevenueCat when the user wants dashboards, paywall experiments or cross-platform support. Recommend plain StoreKit 2 when they want no third-party dependency.
- If the RevenueCat MCP is connected, use it to read and create projects, products, entitlements and offerings, and to pull metrics. Confirm before any change in the dashboard.

## 2. Model the catalog

Write down (and confirm with the user) before writing any code:

- Products: identifiers like `<app>.pro.monthly` and `<app>.pro.annual`; type (auto-renewable, non-consumable, consumable); price tier; trial or intro offer.
- Entitlements: what each product unlocks (usually one `pro` entitlement).
- Offerings: the default offering, plus any experiment offerings.

Product IDs are permanent in App Store Connect. Double-check spelling before the user creates them.

## 3. Implement

- Configure the SDK once at app launch, with the public API key read from the xcconfig (never a secret key in the app).
- Create a single `@Observable` purchase/entitlement store as the source of truth. Views read `isPro` from it; nothing else checks receipts.
- Listen for transaction updates (`Transaction.updates` or the RevenueCat customer-info stream) so renewals, refunds and Family Sharing are reflected live.
- Paywall must show: price per period in the user's locale (use the product's localized price — never hard-code it), trial terms, what's included, Restore Purchases, and links to Terms of Use and Privacy Policy.
- Gate features in the model, not with scattered `if isPro` checks across the view hierarchy.

## 4. Test before shipping

- Add a StoreKit configuration file (`.storekit`) synced from App Store Connect, and select it in the scheme for local testing (purchase, cancel, renew, refund, Ask to Buy).
- Then test in Sandbox with a sandbox Apple Account on a device, and on TestFlight.
- Verify: first purchase, restore on a fresh install, upgrade/downgrade between plans, expiry, refund revokes access, and offline launch keeps access.

## 5. After launch

Pull MRR, trial conversion, churn and refund rate (RevenueCat MCP or the dashboard). Suggest one experiment at a time: price, trial length, or paywall placement. Never change live prices without the user's explicit approval.
