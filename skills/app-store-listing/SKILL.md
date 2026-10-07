---
name: app-store-listing
description: Write and audit an App Store product page and pre-check App Review risks — app name, subtitle, keywords, description, promotional text, screenshots and previews, privacy nutrition labels, age rating, and a guideline pre-flight. Use for "write my App Store listing", "ASO", "keywords", "screenshots", "will this pass review", or before a first submission.
---

# App Store Listing & Review Pre-flight

## 1. Gather inputs

Read the app (features, onboarding, paywall), any existing listing (`fastlane/metadata/` if `deliver` is used), and ask for: the target audience, the top 3 competitors, primary markets/locales, and whether the app is free, paid, or freemium.

## 2. Metadata (respect the hard limits)

| Field | Limit | Guidance |
|---|---|---|
| App name | 30 chars | Brand + the strongest keyword if it fits naturally |
| Subtitle | 30 chars | The core benefit; don't repeat words from the name |
| Keywords | 100 bytes, comma-separated, no spaces | Singular forms, no words already in name/subtitle, no competitor trademarks |
| Promotional text | 170 chars | Changeable without a review; use it for the current offer or news |
| Description | 4,000 chars | First 3 lines carry the weight; benefits → features → social proof → subscription terms |
| What's New | 4,000 chars | See `ios-release` |

Count characters with code, not by eye. Output a ready-to-paste block for each field, and (if fastlane `deliver` is used) write the files under `fastlane/metadata/<locale>/`.

## 3. Screenshots and previews

- Plan up to 10 screenshots per device class. The first 3 matter most: each one is a single headline benefit plus the screen that proves it.
- Required sizes change. Check App Store Connect's current screenshot specifications (the largest iPhone size, plus iPad if the app runs on iPad) before rendering.
- Capture clean states in the Simulator with demo data: status bar overridden via `xcrun simctl status_bar <udid> override --time 9:41 --batteryState charged --batteryLevel 100`, then `xcrun simctl io <udid> screenshot`.
- For automation, fastlane `snapshot` + `frameit`, or design the frames in Figma with the Figma connector.

## 4. Privacy and ratings

- Build the privacy nutrition label from the code: list every SDK and what it collects, linked to identity or not, used for tracking or not. Flag any mismatch with `PrivacyInfo.xcprivacy`.
- If the app tracks across apps or websites, it needs App Tracking Transparency before tracking.
- Answer the age-rating questionnaire based on actual content, including user-generated content and web views.

## 5. Review pre-flight

Check the app against the guidelines that most often cause rejections, and report each one as pass / risk / fail, with the evidence:

- **2.1 App completeness** — no crashes, placeholder text, broken links or empty states; a demo account if login is required
- **2.3 Accurate metadata** — screenshots show the real app; no prices or "#1" claims in the name
- **3.1.1 / 3.1.2 In-app purchase and subscriptions** — digital goods use IAP; the paywall shows price, period, what's included, and links to Terms and Privacy; Restore Purchases exists
- **4.2 Minimum functionality** — more than a wrapped website
- **4.8 Login services** — if third-party social login is offered, an equivalent privacy-focused option (e.g. Sign in with Apple) is offered too
- **5.1.1 Data collection** — purpose strings for every permission; account deletion in-app if accounts exist; no forced sign-up for features that don't need it
- **5.1.2 Data use and sharing** — tracking only with ATT consent

Guidelines get revised. When something is borderline, check the current App Review Guidelines on developer.apple.com instead of relying on memory.

## 6. Localization

When adding locales, translate keywords per locale (don't copy them), and localize the screenshot text. Offer to set up `fastlane/metadata` for each locale.
