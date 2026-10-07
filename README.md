# iOS App Lifecycle — a Claude plugin

Plan, build, test, ship and grow an iOS app with Claude. This plugin gives Claude 16 skills that cover the whole lifecycle of an iOS app, and connects it to Xcode, the iOS Simulator, RevenueCat and Mobbin.

It works in **Claude Cowork** (the Claude desktop app) and in **Claude Code** (terminal, IDE or the desktop Code tab).

```
 Idea ─▶ Research ─▶ Design ─▶ Setup ─▶ Build ─▶ Debug ─▶ Test ─▶ Perf ─▶ Monetize ─▶ Release ─▶ Store listing ─▶ Post-launch ─┐
   ▲                                                                                                                         │
   └──────────────────────────────────────────── next version ◀──────────────────────────────────────────────────────────────┘
```

---

## Contents

- [What you get](#what-you-get)
- [Requirements](#requirements)
- [Install](#install)
- [Connect the tools](#connect-the-tools)
- [How to use it](#how-to-use-it)
- [Skill reference](#skill-reference)
- [Example workflows](#example-workflows)
- [Safety model](#safety-model)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License and credits](#license-and-credits)

---

## What you get

| Phase | Skill | What Claude does |
|---|---|---|
| Any | `ios-lifecycle` | Works out where your app is, then routes the request to the right skill. **Start here.** |
| Setup | `ios-project-setup` | Sets up the project structure, xcconfigs, SPM, extensions, signing and CI, and writes the repo's `CLAUDE.md` |
| Build UI | `swiftui-ui-patterns` | Builds navigation, state, lists, sheets, forms and more, with 30+ pattern references |
| Build UI | `swiftui-liquid-glass` | Adopts and reviews iOS 26+ Liquid Glass |
| Build UI | `swiftui-view-refactor` | Splits large views and tightens data flow and Observation |
| System | `ios-app-intents` | Adds App Intents, entities and App Shortcuts for Siri, Spotlight, widgets and controls |
| Debug | `ios-debugger-agent` | Builds, runs, taps through and reads the logs of your app on the Simulator via XcodeBuildMCP |
| Test | `ios-testing` | Writes and runs Swift Testing, XCTest and XCUITest tests, and fixes failing ones |
| Perf | `swiftui-performance-audit` | Audits SwiftUI rendering performance, starting from the code |
| Perf | `ios-ettrace-performance` | Captures and reads ETTrace flame graphs (launch, scrolling, slow flows) |
| Perf | `ios-memgraph-leaks` | Captures and diffs memgraphs to find retain cycles and leaks |
| Monetize | `ios-monetization` | Sets up RevenueCat or StoreKit 2 products, entitlements, paywalls and sandbox testing |
| Release | `ios-release` | Runs a pre-flight checklist, versioning, archive, TestFlight and App Review submission (fastlane / xcodebuild) |
| Listing | `app-store-listing` | Writes the name, subtitle, keywords and description within character limits, plans screenshots and privacy labels, and pre-checks App Review guidelines |
| Post-launch | `ios-crash-monitoring-sentry` | Read-only Sentry queries for crashes and errors |
| Post-launch | `ios-post-launch` | Weekly health report, crash triage, review reply drafts, next-version backlog |

### MCP servers included

| Server | Type | Used for |
|---|---|---|
| `XcodeBuildMCP` | local (`npx xcodebuildmcp`) | Build, run and test on the Simulator; UI automation; logs |
| `xcode` | local (`xcrun mcpbridge`) | Xcode's own MCP bridge (Xcode 26.3+) |
| `revenuecat` | remote HTTP | Products, offerings, entitlements and revenue metrics |
| `mobbin` | remote HTTP | Real-world app UI references for design research |

Figma isn't bundled. Connect the official **Figma** connector (see below) for design-to-code and code-to-design.

---

## Requirements

- macOS with **Xcode** installed (`xcode-select -p` should print a path)
- **Node.js 18+** (for `npx xcodebuildmcp`)
- Optional: **fastlane** (`brew install fastlane` or a project `Gemfile`), **Ruby/Bundler**
- Optional accounts: Apple Developer Program, RevenueCat, Mobbin, Sentry, Figma

> **Cowork note:** Cowork's built-in shell is a Linux sandbox, so it cannot run `xcodebuild` itself. Xcode work goes through the local MCP servers above, which run on your Mac. For long build, test and release sessions, Claude Code on your Mac is the smoothest option.

---

## Install

### Claude Code

```bash
# 1. Add this repo as a plugin marketplace
/plugin marketplace add <github-user>/ios-app-lifecycle

# 2. Install the plugin
/plugin install ios-app-lifecycle@ios-app-lifecycle

# 3. Restart Claude Code, then check that the skills are loaded
/plugin
```

Or clone it and point Claude Code at the folder:

```bash
git clone https://github.com/<github-user>/ios-app-lifecycle.git
/plugin marketplace add ./ios-app-lifecycle
/plugin install ios-app-lifecycle@ios-app-lifecycle
```

### Claude Cowork (desktop app)

1. Download the latest `ios-app-lifecycle.plugin` from [Releases](../../releases), or build it yourself:
   ```bash
   git clone https://github.com/<github-user>/ios-app-lifecycle.git
   cd ios-app-lifecycle && zip -r ../ios-app-lifecycle.plugin . -x ".git/*" "*.DS_Store"
   ```
2. In the Claude desktop app, open **Customize → Plugins → Upload plugin** (or drag the `.plugin` file into a chat) and accept it.
3. Type `/` in a new task. The skills appear under **iOS App Lifecycle**.

---

## Connect the tools

| Tool | How |
|---|---|
| **Figma** | Claude → Settings → Connectors → **Figma** → Connect. Optionally install the official Figma plugin for its `figma-swiftui` skill. |
| **RevenueCat** | Comes with the plugin. On first use you'll be asked to sign in (OAuth). |
| **Mobbin** | Comes with the plugin. Sign in when prompted (needs a Mobbin account). |
| **XcodeBuildMCP** | Comes with the plugin. First run downloads it via `npx`. Allow Terminal / Claude to control the Simulator if macOS asks. |
| **Xcode MCP bridge** | Needs a recent Xcode with `xcrun mcpbridge`. If your Xcode doesn't have it, delete the `xcode` entry from `.mcp.json`. |
| **Sentry** | Create a read-only auth token (`project:read`, `event:read`, `org:read`) and export `SENTRY_AUTH_TOKEN`, `SENTRY_ORG` and `SENTRY_PROJECT` in your shell profile. Never paste tokens into chat. |
| **App Store Connect (fastlane)** | Create an App Store Connect API key, then export `APP_STORE_CONNECT_API_KEY_KEY_ID`, `APP_STORE_CONNECT_API_KEY_ISSUER_ID` and `APP_STORE_CONNECT_API_KEY_KEY` (or the key file path) for fastlane. |
| **Linear** (optional) | Claude → Settings → Connectors → Linear, so `ios-post-launch` can file the next-version backlog. |

---

## How to use it

You don't need to remember skill names. Describe what you want, and `ios-lifecycle` routes the request to the right skill. You can also call a skill directly with `/skill-name`.

Good first prompts:

- *"Look at this repo and tell me where the app is in its lifecycle and what to do next."*
- *"Set up CLAUDE.md for this project."* → `ios-project-setup`
- *"Build the settings screen from this Figma link: …"* → Figma + `swiftui-ui-patterns`
- *"Run the app on the simulator and walk through onboarding."* → `ios-debugger-agent`
- *"Scrolling the feed is janky, find out why."* → `swiftui-performance-audit` → `ios-ettrace-performance`
- *"Add a monthly and an annual subscription with a 7-day trial using RevenueCat."* → `ios-monetization`
- *"Ship a TestFlight build."* → `ios-release`
- *"Write my App Store listing and check it against review guidelines."* → `app-store-listing`
- *"Weekly health check."* → `ios-post-launch`

**Tip:** run `ios-project-setup` once per repo. The `CLAUDE.md` it writes (build commands, schemes, simulator, conventions) makes every later session faster and more accurate.

---

## Skill reference

Each skill lives in `skills/<name>/SKILL.md`, with optional `references/` (loaded on demand) and `scripts/`.

<details>
<summary><b>ios-lifecycle</b> — router and planner</summary>

Orients on the repo (project type, version, fastlane, StoreKit/RevenueCat), maps the request to one of 13 phases, and loads the matching skills. For new apps it writes a product brief, an MVP screen inventory, stack defaults, risks and a milestone plan.
</details>

<details>
<summary><b>ios-project-setup</b></summary>

Folder layout, Swift 6 strict concurrency, xcconfigs per environment, a git-ignored secrets xcconfig, `PrivacyInfo.xcprivacy`, extension targets with App Groups, signing guidance, the repo `CLAUDE.md` template, and an optional GitHub Actions CI workflow.
</details>

<details>
<summary><b>ios-testing</b></summary>

Picks Swift Testing, XCTest, XCUITest, snapshot or performance tests depending on the job; covers testable-code patterns, running single tests, reading `.xcresult`, release-time test runs, and CI result bundles.
</details>

<details>
<summary><b>ios-release</b></summary>

An executed pre-flight checklist (version/build, Release config, privacy manifest, encryption flag, entitlements, account deletion, paywall rules), fastlane lanes or `xcodebuild archive/export`, TestFlight notes, App Review submission with phased release, git tagging, fastlane bootstrap, and rejection handling. It always asks before uploading or submitting.
</details>

<details>
<summary><b>app-store-listing</b></summary>

Metadata with enforced limits (name 30, subtitle 30, keywords 100 bytes, promo 170, description 4,000), a screenshot plan with Simulator status-bar overrides, privacy nutrition labels derived from the code, age rating, and a guideline pre-flight (2.1, 2.3, 3.1.x, 4.2, 4.8, 5.1.x). It can write `fastlane/metadata/<locale>/`.
</details>

<details>
<summary><b>ios-monetization</b></summary>

Choosing RevenueCat or StoreKit 2, catalog modeling (products, entitlements, offerings), a single observable entitlement store, paywall compliance, StoreKit config, Sandbox and TestFlight test matrices, and post-launch experiments.
</details>

<details>
<summary><b>ios-post-launch</b></summary>

A weekly health report (stability, performance, revenue, reviews, funnel), symbolicated crash triage that ends in a test and a fix, review reply drafts, ratings prompt guidance, and a prioritized next-version backlog (optionally filed in Linear).
</details>

<details>
<summary><b>Adapted skills</b> (from OpenAI's open-source <code>build-ios-apps</code> and <code>sentry</code> plugins)</summary>

`swiftui-ui-patterns`, `swiftui-liquid-glass`, `swiftui-view-refactor`, `swiftui-performance-audit`, `ios-app-intents`, `ios-debugger-agent`, `ios-ettrace-performance`, `ios-memgraph-leaks`, `ios-crash-monitoring-sentry`. See [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).
</details>

---

## Example workflows

**From zero to TestFlight**

1. *"I want to build an app that … — plan the MVP."* (`ios-lifecycle`)
2. *"Find 5 onboarding flows on Mobbin for apps like this."* (Mobbin)
3. *"Create the project and CLAUDE.md."* (`ios-project-setup`)
4. *"Build these screens from the Figma file."* (Figma + `swiftui-ui-patterns`)
5. *"Run it on the simulator and fix anything broken."* (`ios-debugger-agent`)
6. *"Add tests for the core model and the onboarding UI flow."* (`ios-testing`)
7. *"Set up fastlane and push a TestFlight build."* (`ios-release`)

**Release day**

*"Prepare 1.2.0: run the pre-flight, write What's New from the commits, update the listing, and show me the exact fastlane command before running it."*

**Monday morning**

*"Weekly health check for the app, then draft replies to the new 1–3 star reviews."*

---

## Safety model

- **Irreversible actions need your OK.** Uploading builds, submitting for review, changing RevenueCat products or prices, and posting review replies are always shown to you first. Claude drafts and waits for your go-ahead.
- **No secrets in chat or in the repo.** Certificates, `.p8` keys, passwords and tokens stay in your keychain or environment variables. The skills refer to them only by environment variable name.
- **Read-only monitoring.** The Sentry skill only reads.

---

## Troubleshooting

| Symptom | Fix |
|---|---|
| `XcodeBuildMCP` tools don't appear | Check that `node -v` is 18 or later, then restart Claude. Run `npx -y xcodebuildmcp@latest --help` once in Terminal to pre-download it. |
| `xcrun: error: unable to find utility "mcpbridge"` | Your Xcode version doesn't include the bridge. Update Xcode, or remove the `xcode` server from `.mcp.json`. |
| "No booted simulator" | Boot one first: `xcrun simctl boot "iPhone 17"` (use a name from `xcrun simctl list devices available`). |
| fastlane can't authenticate | Check the App Store Connect API key environment variables, and that the key has the App Manager role. |
| Tool names look like `mcp__plugin_..._XcodeBuildMCP__...` | That's normal: plugin MCP tools get a prefix. Skills refer to the tools by their base names. |
| Cowork says it can't run `xcodebuild` | That's expected. Use the MCP tools, or run the session in Claude Code on your Mac. |

---

## Contributing

1. Fork the repo and create a branch.
2. Add or edit a skill under `skills/<kebab-case-name>/SKILL.md`. Keep the body under about 3,000 words and put longer material in `references/`.
3. Write the frontmatter `description` in the third person, with real trigger phrases.
4. Test locally: `/plugin marketplace add ./ios-app-lifecycle` → `/plugin install ios-app-lifecycle@ios-app-lifecycle`.
5. Open a PR that describes what the skill does and when it should trigger.

---

## License and credits

MIT © 2026 Tarun. Includes skills adapted from [openai/plugins](https://github.com/openai/plugins) (MIT and Apache-2.0). See [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).

Not affiliated with Apple, OpenAI, RevenueCat, Mobbin, Sentry or Figma. All trademarks belong to their owners.
