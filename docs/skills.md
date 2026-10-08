# Skills reference: 16 iOS agent skills

Every skill is a folder under `skills/` with a `SKILL.md`. Some also have `references/` (loaded on demand) and `scripts/`. Claude loads a skill automatically when your request matches its description, or you can call it directly with `/ios-app-lifecycle:<skill>` (Claude Code) or `/<skill>`.

| Skill | Source | Extras |
|---|---|---|
| [`ios-lifecycle`](#ios-lifecycle) | original | — |
| [`ios-project-setup`](#ios-project-setup) | original | — |
| [`swiftui-ui-patterns`](#swiftui-ui-patterns) | adapted (openai/plugins) | 30 references |
| [`swiftui-liquid-glass`](#swiftui-liquid-glass) | adapted (openai/plugins) | 1 reference |
| [`swiftui-view-refactor`](#swiftui-view-refactor) | adapted (openai/plugins) | 1 reference |
| [`ios-app-intents`](#ios-app-intents) | adapted (openai/plugins) | 4 references |
| [`ios-debugger-agent`](#ios-debugger-agent) | adapted (openai/plugins) | — |
| [`ios-testing`](#ios-testing) | original | — |
| [`swiftui-performance-audit`](#swiftui-performance-audit) | adapted (openai/plugins) | 7 references |
| [`ios-ettrace-performance`](#ios-ettrace-performance) | adapted (openai/plugins) | 2 scripts |
| [`ios-memgraph-leaks`](#ios-memgraph-leaks) | adapted (openai/plugins) | 2 scripts |
| [`ios-monetization`](#ios-monetization) | original | — |
| [`ios-release`](#ios-release) | original | — |
| [`app-store-listing`](#app-store-listing) | original | — |
| [`ios-crash-monitoring-sentry`](#ios-crash-monitoring-sentry) | adapted (openai/plugins) | 1 script |
| [`ios-post-launch`](#ios-post-launch) | original | — |

## ios-lifecycle

Map an iOS app request to the right lifecycle phase and skill — idea, research, design, setup, build, debug, test, performance, monetization, release, App Store listing, post-launch. Use when the user says "help me build/ship my iOS app", "what's next for my app", "plan my app", or asks something iOS-related without naming a specific step.

→ [`skills/ios-lifecycle/SKILL.md`](../skills/ios-lifecycle/SKILL.md)

## ios-project-setup

Set up or clean up an iOS project foundation — new Xcode project or XcodeGen/Tuist spec, targets and schemes, build configurations and xcconfigs, Swift Package dependencies, bundle IDs and capabilities, signing, a repo CLAUDE.md, and CI. Use when starting a new iOS app, adding a target (widget, extension, watch), or when "the project setup is a mess".

→ [`skills/ios-project-setup/SKILL.md`](../skills/ios-project-setup/SKILL.md)

## swiftui-ui-patterns

Build and refactor SwiftUI UI with component patterns and examples. Use when shaping navigation, state, layouts, controls, or screen composition.

→ [`skills/swiftui-ui-patterns/SKILL.md`](../skills/swiftui-ui-patterns/SKILL.md)

## swiftui-liquid-glass

Implement and review iOS 26+ SwiftUI Liquid Glass UI. Use when adopting Liquid Glass or checking its correctness, performance, and design fit.

→ [`skills/swiftui-liquid-glass/SKILL.md`](../skills/swiftui-liquid-glass/SKILL.md)

## swiftui-view-refactor

Refactor SwiftUI view files into stable, testable structure. Use when splitting large views, tightening data flow, or cleaning Observation ownership.

→ [`skills/swiftui-view-refactor/SKILL.md`](../skills/swiftui-view-refactor/SKILL.md)

## ios-app-intents

Design App Intents, app entities, and App Shortcuts for iOS system surfaces. Use when exposing app actions or content to Shortcuts, Siri, Spotlight, widgets, or controls.

→ [`skills/ios-app-intents/SKILL.md`](../skills/ios-app-intents/SKILL.md)

## ios-debugger-agent

Build, run, and debug iOS apps on Simulator with XcodeBuildMCP. Use when launching an app, inspecting simulator UI or logs, or diagnosing runtime behavior.

→ [`skills/ios-debugger-agent/SKILL.md`](../skills/ios-debugger-agent/SKILL.md)

## ios-testing

Write, run and fix tests for iOS apps — Swift Testing and XCTest unit tests, UI tests, snapshot tests, test plans and CI test runs. Use when the user asks to "add tests", "why is this test failing", "set up UI tests", "improve coverage", or before a release.

→ [`skills/ios-testing/SKILL.md`](../skills/ios-testing/SKILL.md)

## swiftui-performance-audit

Audit SwiftUI runtime performance from code first. Use when diagnosing slow rendering, janky scrolling, expensive updates, or profiling needs.

→ [`skills/swiftui-performance-audit/SKILL.md`](../skills/swiftui-performance-audit/SKILL.md)

## ios-ettrace-performance

Capture and interpret iOS Simulator ETTrace profiles. Use when profiling launch or runtime latency, comparing traces, or finding CPU-heavy stacks.

→ [`skills/ios-ettrace-performance/SKILL.md`](../skills/ios-ettrace-performance/SKILL.md)

## ios-memgraph-leaks

Capture and inspect iOS leaks and memgraphs. Use when debugging leaked objects, retain cycles, memory growth, or before/after leak evidence.

→ [`skills/ios-memgraph-leaks/SKILL.md`](../skills/ios-memgraph-leaks/SKILL.md)

## ios-monetization

Add and verify in-app purchases and subscriptions in an iOS app with RevenueCat or StoreKit 2 — products, offerings, entitlements, paywalls, restore, sandbox and StoreKit-config testing, and revenue metrics. Use for "add a paywall", "set up subscriptions", "RevenueCat", "StoreKit", "why isn't my purchase working", or pricing questions.

→ [`skills/ios-monetization/SKILL.md`](../skills/ios-monetization/SKILL.md)

## ios-release

Ship an iOS build — bump the version and build number, run the release checks, archive, upload to TestFlight, and submit for App Review with fastlane, xcodebuild or Xcode Organizer. Use when the user says "ship it", "push a TestFlight build", "submit to the App Store", "cut a release", or "set up fastlane".

→ [`skills/ios-release/SKILL.md`](../skills/ios-release/SKILL.md)

## app-store-listing

Write and audit an App Store product page and pre-check App Review risks — app name, subtitle, keywords, description, promotional text, screenshots and previews, privacy nutrition labels, age rating, and a guideline pre-flight. Use for "write my App Store listing", "ASO", "keywords", "screenshots", "will this pass review", or before a first submission.

→ [`skills/app-store-listing/SKILL.md`](../skills/app-store-listing/SKILL.md)

## ios-crash-monitoring-sentry

Use when the user asks to triage iOS crashes or production errors in Sentry, or to inspect Sentry issues or events, summarize recent production errors, or pull basic Sentry health data via the Sentry API; perform read-only queries with the bundled script and require `SENTRY_AUTH_TOKEN`.

→ [`skills/ios-crash-monitoring-sentry/SKILL.md`](../skills/ios-crash-monitoring-sentry/SKILL.md)

## ios-post-launch

Run the loop after an iOS release — crash and hang triage, App Store review replies, ratings prompts, metrics review, and planning the next version. Use for "how is the launch going", "triage crashes", "reply to reviews", "what should v1.1 be", or a weekly app health check.

→ [`skills/ios-post-launch/SKILL.md`](../skills/ios-post-launch/SKILL.md)
