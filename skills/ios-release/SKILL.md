---
name: ios-release
description: Ship an iOS build — bump the version and build number, run the release checks, archive, upload to TestFlight, and submit for App Review with fastlane, xcodebuild or Xcode Organizer. Use when the user says "ship it", "push a TestFlight build", "submit to the App Store", "cut a release", or "set up fastlane".
---

# iOS Release

## 0. Ground rules

- Every step that uploads or submits is irreversible from the user's point of view. Show exactly what will happen (version, build, lane or command, destination) and get a clear yes before running it.
- Never handle Apple ID passwords, certificates, `.p8` keys or match passphrases. Expect them in the environment (`APP_STORE_CONNECT_API_KEY_*`, `MATCH_PASSWORD`) or the keychain, set up by the user.
- Archives and uploads only run on macOS. In Cowork, prepare everything, then hand the user the one command to run in Terminal, or use Claude Code on the Mac.

## 1. Detect the release path

- `fastlane/Fastfile` exists → use its lanes. Read it first and list the lanes and what they do.
- An Xcode Cloud workflow exists → trigger or tag per that workflow.
- Neither exists → offer to set up fastlane (step 6), or walk the user through Xcode → Product → Archive → Distribute App.

## 2. Pre-flight checklist (run it, don't just print it)

- [ ] The working tree is clean and on the release branch; the tests pass (`ios-testing`)
- [ ] `MARKETING_VERSION` follows semver and the build number is higher than the last uploaded build (`agvtool what-version`, or `latest_testflight_build_number` in fastlane)
- [ ] The Release configuration builds with no warnings you introduced
- [ ] No debug flags, test endpoints or verbose logging in Release
- [ ] `PrivacyInfo.xcprivacy` covers every required-reason API and every third-party SDK
- [ ] `ITSAppUsesNonExemptEncryption` is set in Info.plist (usually `NO` if you only use HTTPS)
- [ ] Entitlements match the capabilities enabled for the App ID
- [ ] The app icon and launch screen are present; no placeholder content
- [ ] If the app has accounts: account deletion is available in-app
- [ ] If it has subscriptions: see the paywall checks in `ios-monetization`
- [ ] Release notes are written (step 4)

Report every failed item and stop until it's fixed or the user waives it.

## 3. Build and upload

fastlane (preferred when present):

```bash
bundle exec fastlane beta      # build + upload to TestFlight
bundle exec fastlane release   # build + upload + submit for review (if the lane does that)
```

xcodebuild:

```bash
xcodebuild -scheme <App> -configuration Release -destination 'generic/platform=iOS' \
  -archivePath build/<App>.xcarchive archive
xcodebuild -exportArchive -archivePath build/<App>.xcarchive \
  -exportOptionsPlist ExportOptions.plist -exportPath build/export
xcrun altool --upload-package build/export/<App>.ipa --type ios \
  --apiKey "$ASC_KEY_ID" --apiIssuer "$ASC_ISSUER_ID"
```

(If `altool` isn't available or supported in the installed Xcode, upload with fastlane `pilot` or Apple's Transporter app instead.)

## 4. Release notes and TestFlight

- Turn the commits since the last tag into user-facing "What's New" text: benefits, not implementation. Keep it under about 4 short bullets.
- Write separate TestFlight "What to Test" notes that point testers at the risky areas.
- After the upload finishes processing, remind the user to add the build to the right tester groups.

## 5. Submit for review

- Confirm that the metadata, screenshots and privacy details are current (`app-store-listing`).
- Choose a release method: manual, automatic, or phased (7-day phased rollout is a good default for updates).
- Provide review notes: a demo account if login is required, how to reach gated features, and an explanation of any non-obvious permissions.
- After submitting, tag the commit `v<version>(<build>)` and push the tag when the user asks.

## 6. Setting up fastlane (if asked)

- `Gemfile` with `fastlane`; `bundle install`.
- `fastlane/Appfile` (app_identifier, team_id), `fastlane/Fastfile` with lanes:
  - `tests` — `scan`
  - `beta` — `increment_build_number` (from the latest TestFlight build), `match(type: "appstore")`, `gym`, `pilot`
  - `release` — `beta` steps + `deliver(submit_for_review: false)` by default
- Authenticate with an App Store Connect API key (`app_store_connect_api_key`) loaded from environment variables, never committed.
- Do a dry run with `bundle exec fastlane beta --verbose` only after the user confirms.

## 7. If review rejects the build

Read the rejection message, map it to the guideline number, then propose the smallest fix or a Resolution Center reply. Draft the reply for the user to send; never send it yourself.
