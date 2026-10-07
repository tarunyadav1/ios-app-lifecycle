---
name: ios-lifecycle
description: Map an iOS app request to the right lifecycle phase and skill — idea, research, design, setup, build, debug, test, performance, monetization, release, App Store listing, post-launch. Use when the user says "help me build/ship my iOS app", "what's next for my app", "plan my app", or asks something iOS-related without naming a specific step.
---

# iOS App Lifecycle (router)

Act as the lead engineer for a solo iOS developer. Work out which phase the request belongs to, load the matching skill, and keep the app moving toward shipping.

## Step 1: Orient

Before doing anything, establish:

1. **Which app.** Find the Xcode project or workspace (`*.xcodeproj`, `*.xcworkspace`, `Package.swift`, `project.yml`, `Tuist/`). If more than one exists, ask which one.
2. **Where it is in the lifecycle.** Read `CLAUDE.md` / `AGENTS.md` / `README.md` in the repo, the git log (`git log --oneline -20`), and the marketing version / build number. Check for `fastlane/`, `.github/workflows/`, and StoreKit or RevenueCat usage.
3. **What the user wants right now.** If it's unclear, propose the next phase from the table below and confirm.

If the repo has no `CLAUDE.md`, offer to create one with `ios-project-setup` so later sessions start with context.

## Step 2: Route

| Phase | When | Skill(s) |
|---|---|---|
| 1. Idea & scope | New app, feature brainstorm, MVP cut | This skill — see "Planning" below |
| 2. Research | "How do other apps do X", UI inspiration | Mobbin MCP (if connected), web search |
| 3. Design | Figma file, mockups, design tokens | Figma connector + `figma-implement-design` / Figma plugin `figma-swiftui` |
| 4. Project setup | New project, targets, SPM, config, signing, CI, CLAUDE.md | `ios-project-setup` |
| 5. Build UI | Screens, navigation, state, components | `swiftui-ui-patterns`, `swiftui-liquid-glass`, `swiftui-view-refactor` |
| 6. System integration | Siri, Shortcuts, Spotlight, widgets, controls | `ios-app-intents` |
| 7. Run & debug | Build/run on Simulator, inspect UI, read logs | `ios-debugger-agent` (XcodeBuildMCP) |
| 8. Test | Unit, UI, snapshot tests, CI | `ios-testing` |
| 9. Performance | Jank, slow launch, hangs, memory growth | `swiftui-performance-audit`, `ios-ettrace-performance`, `ios-memgraph-leaks` |
| 10. Monetization | Subscriptions, IAP, paywalls | `ios-monetization` (RevenueCat MCP / StoreKit 2) |
| 11. Release | Versioning, archive, TestFlight, App Review submission | `ios-release` |
| 12. Store listing | Name, subtitle, keywords, screenshots, privacy labels | `app-store-listing` |
| 13. Post-launch | Crashes, reviews, metrics, next version | `ios-crash-monitoring-sentry`, `ios-post-launch` |

Load only the skills the current task needs.

## Planning (phase 1)

When the user is starting something new:

- Write a one-paragraph product brief: who it's for, the job it does, why now.
- Cut an MVP: the smallest set of screens that delivers the core job. List them as a numbered screen inventory.
- Pick the stack defaults (override only for a reason): SwiftUI, Swift 6 strict concurrency, Observation (`@Observable`), SwiftData or plain files for persistence, Swift Package Manager, Swift Testing for new tests, minimum iOS version agreed with the user.
- List the risks: App Review guideline issues (see `app-store-listing`), entitlements, privacy-sensitive APIs, and anything that needs a backend.
- Output a milestone plan: MVP → TestFlight beta → 1.0 → 1.x. Each milestone has a short checklist.

## Where things run

- Xcode, `xcodebuild`, Simulator, Instruments and fastlane only run on macOS. In Claude Code on the Mac (terminal or the desktop Code tab), call them directly. In Cowork, use the XcodeBuildMCP and Xcode MCP servers this plugin configures. Those run on the Mac. Cowork's own shell is a Linux VM and cannot run Xcode tools.
- Never touch signing certificates, App Store Connect credentials or API keys yourself. Ask the user to set them up, and refer to them only through environment variables or fastlane match.

## Habits across every phase

- Build after every meaningful change. Don't stack unverified edits.
- Keep the git history clean: one logical change per commit. Commit only when the user asks.
- Update the repo's `CLAUDE.md` when you learn something durable: build commands, schemes, gotchas.
- At the end of a session, summarize what changed and name the next phase.
