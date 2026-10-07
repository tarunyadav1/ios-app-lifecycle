---
name: ios-testing
description: Write, run and fix tests for iOS apps — Swift Testing and XCTest unit tests, UI tests, snapshot tests, test plans and CI test runs. Use when the user asks to "add tests", "why is this test failing", "set up UI tests", "improve coverage", or before a release.
---

# iOS Testing

## Choose the right test

| Need | Use |
|---|---|
| Logic, models, view models, parsing | Swift Testing (`import Testing`, `@Test`, `#expect`) for new code; keep existing XCTest suites as they are |
| Async code | `async` test functions; `confirmation { }` for callbacks; avoid sleeps |
| User flows (onboarding, purchase, settings) | XCUITest with accessibility identifiers |
| Visual regressions | A snapshot library the project already uses (e.g. swift-snapshot-testing); don't add one without asking |
| Performance budgets | `XCTMetric` / `measure(metrics:)` in XCTest |

## Write testable code first

- Inject dependencies (network client, clock, persistence) through initializers or environment values so tests can pass fakes.
- Keep views thin. Put decisions in `@Observable` models and test those.
- Give every interactive element in a UI flow a stable `.accessibilityIdentifier`.
- Use launch arguments (e.g. `-uiTesting`, `-resetState`) to put the app in a known state for UI tests, and stub the network in that mode.

## Run tests

- On the Mac: `xcodebuild test -scheme <Scheme> -destination 'platform=iOS Simulator,name=<device>' [-only-testing:<Target>/<Suite>/<test>]`.
- In Cowork: use the XcodeBuildMCP test tools.
- For a failing test, rerun just that test, read the failure and the `.xcresult` if it's available (`xcrun xcresulttool get test-results summary --path <path>`), fix the cause, rerun, then rerun the whole suite.
- Don't weaken an assertion just to make a test pass. If the test itself is wrong, explain why before changing it.

## Before a release

Run the full suite on the oldest supported iOS version and on the newest one. Report pass/fail counts and any flaky tests (a test that passes when retried is still a bug — log it).

## Test plans and CI

- Use an `.xctestplan` when there are several configurations (locales, UI-test vs unit).
- In CI, add `-resultBundlePath` and upload the `.xcresult` as an artifact when something fails.
