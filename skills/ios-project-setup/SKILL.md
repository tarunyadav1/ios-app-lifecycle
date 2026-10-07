---
name: ios-project-setup
description: Set up or clean up an iOS project foundation — new Xcode project or XcodeGen/Tuist spec, targets and schemes, build configurations and xcconfigs, Swift Package dependencies, bundle IDs and capabilities, signing, a repo CLAUDE.md, and CI. Use when starting a new iOS app, adding a target (widget, extension, watch), or when "the project setup is a mess".
---

# iOS Project Setup

## 1. Inspect before changing

- Detect the project style: plain `.xcodeproj`, XcodeGen (`project.yml`), Tuist (`Project.swift`), or SPM-only (`Package.swift`).
- List the schemes and targets: `xcodebuild -list -json` (or the XcodeBuildMCP discovery tools).
- Note the deployment target, Swift version, strict-concurrency setting, bundle IDs, team ID, and entitlements files.
- Don't convert project styles unless the user asks.

## 2. New project defaults

Unless the user says otherwise:

- Structure: `App/` (entry point, app wiring), `Features/<Feature>/` (views, models, view models), `Core/` (networking, persistence, utilities), `Resources/`, `Tests/`, `UITests/`.
- For larger apps, put features in local Swift packages (`Packages/`). This speeds up builds and previews.
- Swift 6 language mode with complete concurrency checking. `@MainActor` on UI types.
- Use `.xcconfig` files for Debug, Release and (optionally) Staging. Keep the bundle ID suffix, API base URL and feature flags in the xcconfig, not in code.
- No secrets in the repo. Use a git-ignored `Secrets.xcconfig` with a committed `Secrets.example.xcconfig`.
- Keep `PrivacyInfo.xcprivacy` from day one. Declare required-reason APIs as you adopt them.

## 3. Extensions and extra targets

For widgets, Live Activities, App Intents extensions, share extensions, or watchOS:

- Share code through a framework or local package, not by adding files to several targets.
- Set up an App Group when the app and extension share data, and keep the identifier in one constant.
- Match the deployment targets and versions to the main app (`MARKETING_VERSION`, `CURRENT_PROJECT_VERSION`).

## 4. Signing

- Prefer automatic signing for development. For release, use fastlane match or Xcode Cloud managed signing. See `ios-release`.
- Never create, export or move certificates or private keys yourself. Explain what's needed and let the user do it.

## 5. Repo CLAUDE.md

Create or update `CLAUDE.md` at the repo root with:

```markdown
# <App name>
- What: one line on what the app does
- Open: <App>.xcodeproj | <App>.xcworkspace
- Schemes: <App> (Debug/Release), <App>Tests
- Build: xcodebuild -scheme <App> -destination 'platform=iOS Simulator,name=iPhone 17' build
- Test:  xcodebuild -scheme <App> -destination 'platform=iOS Simulator,name=iPhone 17' test
- Release: bundle exec fastlane beta | release
- Min iOS: <x>  Swift: 6  Concurrency: complete
- Conventions: <state management, folder layout, naming>
- Gotchas: <anything that bit us>
```

Use a simulator name that actually exists on this Mac (`xcrun simctl list devices available`).

## 6. CI (optional)

Offer a GitHub Actions workflow on a `macos-latest` runner (or Xcode Cloud) that builds and tests on every PR. Select the Xcode version explicitly. Cache SPM in `~/Library/Developer/Xcode/DerivedData/**/SourcePackages`.

## 7. Verify

Do a clean build and test run for every scheme you touched. Report what was changed and the commands to reproduce.
