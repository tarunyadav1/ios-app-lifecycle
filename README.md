<div align="center">

# iOS App Lifecycle — Claude Code & Codex Plugin for iOS Development

**AI agent skills for building, testing, and shipping iOS apps with Swift, SwiftUI and Xcode.**
Plan → design → build → debug → test → profile → monetize → TestFlight → App Store → post-launch, all in one plugin.

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Claude Code plugin](https://img.shields.io/badge/Claude_Code-plugin-D97757)](#install-in-claude-code)
[![Claude Cowork](https://img.shields.io/badge/Claude_Cowork-plugin-D97757)](#install-in-claude-cowork-desktop-app)
[![Codex compatible](https://img.shields.io/badge/OpenAI_Codex-compatible-black)](#install-in-openai-codex)
[![Swift 6](https://img.shields.io/badge/Swift-6-F05138?logo=swift&logoColor=white)](https://swift.org)
[![iOS 17–26](https://img.shields.io/badge/iOS-17%E2%80%9326-000?logo=apple)](https://developer.apple.com/ios/)
[![Skills](https://img.shields.io/badge/skills-16-success)](docs/skills.md)

[Quick start](#quick-start) · [Skills](docs/skills.md) · [Coming from Codex / Cursor / Copilot?](docs/migrating.md) · [Workflows](docs/workflows.md) · [MCP servers](docs/mcp-servers.md) · [FAQ](docs/faq.md)

</div>

---

**iOS App Lifecycle** is an open-source plugin that turns **Claude Code**, **Claude Cowork** and **OpenAI Codex** into an iOS engineer for the whole job. It bundles **16 agent skills** (`SKILL.md`) and **4 MCP servers** (XcodeBuildMCP, Xcode MCP bridge, RevenueCat, Mobbin), so your AI coding assistant can:

- 🧭 **Plan** an MVP and a milestone roadmap for a new iPhone or iPad app
- 🎨 **Turn Figma designs into SwiftUI** and pull UI references from Mobbin
- 🏗️ **Set up an Xcode project**: xcconfigs, Swift Package Manager, extensions, signing, CI, and a repo `CLAUDE.md`
- 🧩 **Build SwiftUI screens**: NavigationStack, TabView, sheets, forms, lists, **Liquid Glass** (iOS 26)
- ⚡ **Add App Intents**: Siri, Shortcuts, Spotlight, widgets, Control Center
- 🐞 **Build, run and debug on the iOS Simulator**: tap through the UI, read logs, use LLDB
- ✅ **Write tests**: Swift Testing, XCTest, XCUITest, snapshot tests
- 🚀 **Fix performance**: SwiftUI rendering audits, ETTrace flame graphs, memory leaks and memgraphs
- 💰 **Add subscriptions and in-app purchases** with **RevenueCat** or **StoreKit 2**, including paywall compliance
- 📦 **Ship releases**: version bumps, **fastlane**, `xcodebuild archive`, **TestFlight**, **App Store Connect** submission
- 🔎 **Write the App Store listing (ASO)**: title, subtitle, keywords, screenshots, privacy labels, and an **App Review guidelines** pre-check
- 📈 **Run post-launch**: Sentry crash triage, App Store review replies, a weekly app health report, a v1.1 backlog

> Built by an indie iOS developer who moved from Codex to Claude and wanted the whole iOS toolchain to come along.

---

## Table of contents

- [Who is this for](#who-is-this-for)
- [Quick start](#quick-start)
  - [Install in Claude Code](#install-in-claude-code)
  - [Install in Claude Cowork (desktop app)](#install-in-claude-cowork-desktop-app)
  - [Install in OpenAI Codex](#install-in-openai-codex)
- [The iOS lifecycle, skill by skill](#the-ios-lifecycle-skill-by-skill)
- [Coming from Codex, Cursor, Copilot or Xcode AI?](#coming-from-codex-cursor-copilot-or-xcode-ai)
- [Example prompts](#example-prompts)
- [Requirements](#requirements)
- [Safety](#safety)
- [FAQ](#faq)
- [Contributing](#contributing)
- [License and credits](#license-and-credits)

---

## Who is this for

- **Indie iOS developers and solo founders** who want one AI agent to take an app from idea to the App Store
- **Developers moving from OpenAI Codex, Cursor, GitHub Copilot or Windsurf** to Claude Code who need their iOS workflow to carry over
- **SwiftUI developers** who want current patterns (Observation, Swift 6 concurrency, Liquid Glass) instead of outdated UIKit-era answers
- **Teams** that want consistent release checklists, App Review pre-flights and crash triage

## Quick start

### Install in Claude Code

```bash
/plugin marketplace add tarunyadav1/ios-app-lifecycle
/plugin install ios-app-lifecycle@ios-app-lifecycle
```

Restart Claude Code. Then, in your Xcode project folder, ask:

```text
Look at this repo, tell me where the app is in its lifecycle, and set up CLAUDE.md.
```

### Install in Claude Cowork (desktop app)

1. Download `ios-app-lifecycle.plugin` from the [latest release](https://github.com/tarunyadav1/ios-app-lifecycle/releases/latest), or build it yourself with `./scripts/build-plugin.sh`.
2. Drag it into a Claude chat (or go to **Customize → Plugins → Upload**) and accept it.
3. Type `/` to see the skills.

### Install in OpenAI Codex

The skills use the open `SKILL.md` format, so Codex can load them directly:

```bash
git clone https://github.com/tarunyadav1/ios-app-lifecycle.git
cp -R ios-app-lifecycle/skills/* ~/.codex/skills/
```

Then add the MCP servers to `~/.codex/config.toml`. The snippet is in [docs/mcp-servers.md](docs/mcp-servers.md#codex-configtoml). The repo also includes a `.codex-plugin/plugin.json` manifest for Codex plugin tooling. See the [migration guide](docs/migrating.md) for Cursor, Copilot and other agents.

## The iOS lifecycle, skill by skill

| # | Phase | Skill | What the agent does |
|---|---|---|---|
| 0 | **Router** | [`ios-lifecycle`](skills/ios-lifecycle/SKILL.md) | Works out where your app is and hands off to the right skill. Plans MVPs and milestones. |
| 1 | **Project setup** | [`ios-project-setup`](skills/ios-project-setup/SKILL.md) | Xcode project structure, xcconfig environments, SPM, App Groups, signing, GitHub Actions CI, `CLAUDE.md` |
| 2 | **SwiftUI UI** | [`swiftui-ui-patterns`](skills/swiftui-ui-patterns/SKILL.md) | NavigationStack, TabView, sheets, forms, lists, search, haptics, deep links: 30+ references |
| 3 | **Liquid Glass** | [`swiftui-liquid-glass`](skills/swiftui-liquid-glass/SKILL.md) | iOS 26 Liquid Glass adoption and review |
| 4 | **Refactor** | [`swiftui-view-refactor`](skills/swiftui-view-refactor/SKILL.md) | Split large views, `@Observable` ownership, model–view patterns |
| 5 | **App Intents** | [`ios-app-intents`](skills/ios-app-intents/SKILL.md) | Siri, Shortcuts, Spotlight, widgets, controls, App Shortcuts |
| 6 | **Debugging** | [`ios-debugger-agent`](skills/ios-debugger-agent/SKILL.md) | Build and run on the Simulator, UI automation, logs, LLDB (XcodeBuildMCP) |
| 7 | **Testing** | [`ios-testing`](skills/ios-testing/SKILL.md) | Swift Testing, XCTest, XCUITest, snapshot tests, `.xcresult`, CI |
| 8 | **Performance** | [`swiftui-performance-audit`](skills/swiftui-performance-audit/SKILL.md) | Janky scrolling, expensive body updates, hangs |
| 9 | **Profiling** | [`ios-ettrace-performance`](skills/ios-ettrace-performance/SKILL.md) | ETTrace flame graphs, launch time, dSYM symbolication |
| 10 | **Memory** | [`ios-memgraph-leaks`](skills/ios-memgraph-leaks/SKILL.md) | Retain cycles, leaks, memgraph diffing |
| 11 | **Monetization** | [`ios-monetization`](skills/ios-monetization/SKILL.md) | RevenueCat, StoreKit 2, subscriptions, paywalls, sandbox testing |
| 12 | **Release** | [`ios-release`](skills/ios-release/SKILL.md) | Pre-flight checklist, fastlane, archive, TestFlight, App Review submission |
| 13 | **App Store / ASO** | [`app-store-listing`](skills/app-store-listing/SKILL.md) | Title, subtitle, keywords, screenshots, privacy labels, guideline pre-check |
| 14 | **Crash monitoring** | [`ios-crash-monitoring-sentry`](skills/ios-crash-monitoring-sentry/SKILL.md) | Read-only Sentry issue and event queries |
| 15 | **Post-launch** | [`ios-post-launch`](skills/ios-post-launch/SKILL.md) | Weekly health report, crash triage, review replies, next-version backlog |

Full details: **[docs/skills.md](docs/skills.md)** · MCP servers: **[docs/mcp-servers.md](docs/mcp-servers.md)**

## Coming from Codex, Cursor, Copilot or Xcode AI?

| You used… | Here you get… |
|---|---|
| Codex `build-ios-apps` plugin | All 8 of its skills (MIT), adapted for Claude, **plus** 7 new lifecycle skills |
| Codex `config.toml` MCP servers | A ready-made `.mcp.json` and a [config.toml → JSON converter table](docs/migrating.md#3-mcp-servers-configtoml--mcpjson) |
| Codex `AGENTS.md` | `CLAUDE.md`, generated per repo by `ios-project-setup` (keep `AGENTS.md` too; both can coexist) |
| Codex computer use / in-app browser | XcodeBuildMCP Simulator automation + Claude's own computer use |
| Cursor rules / Copilot instructions | Skills that load on demand, so no giant rules file |
| Xcode's built-in AI | Works alongside it through the **Xcode MCP bridge** (`xcrun mcpbridge`) |

➡️ **Step-by-step guide: [docs/migrating.md](docs/migrating.md)**

## Example prompts

```text
Plan an MVP for a habit-tracking iPhone app and give me a milestone roadmap.
Build the onboarding screens from this Figma link: https://figma.com/design/...
Run the app on the iPhone 17 simulator and walk through sign-up. Report anything broken.
The feed scrolls janky on older devices. Find out why and fix it.
Add a monthly and an annual subscription with a 7-day free trial using RevenueCat.
Set up fastlane and push a TestFlight build. Show me the command before running it.
Write my App Store title, subtitle and keywords, and check the app against App Review guidelines.
Weekly health check: crashes, reviews, revenue. Then draft replies to the 1–3★ reviews.
```

More end-to-end recipes: **[docs/workflows.md](docs/workflows.md)**

## Requirements

- macOS with **Xcode 16+** (Xcode 26 recommended for Liquid Glass and the Xcode MCP bridge)
- **Node.js 18+** for XcodeBuildMCP (`npx`)
- Optional: **fastlane**, an Apple Developer Program account, RevenueCat, Sentry, Figma, Mobbin

## Safety

- **Nothing irreversible happens without your OK.** Uploads, App Review submissions, price changes and review replies are always shown to you first.
- **No secrets in chat or git.** Certificates, `.p8` keys and tokens stay in your keychain or environment variables.
- **Read-only monitoring.** The Sentry skill never writes.

## FAQ

**Is this an official Apple, Anthropic or OpenAI project?** No. It's an independent open-source project.

**Does it work with UIKit?** Yes. The debugging, testing, profiling, release, ASO and monetization skills don't care which UI framework you use; the UI skills focus on SwiftUI.

**Does it work with React Native, Expo or Flutter?** The release, App Store, monetization and post-launch skills apply. The SwiftUI skills don't.

**Can I use only some of the skills?** Yes. Copy any folder from `skills/` into your agent's skills directory.

More answers: **[docs/faq.md](docs/faq.md)**

## Contributing

PRs welcome: new skills, better references, bug fixes. See [CONTRIBUTING.md](CONTRIBUTING.md). If this saved you time, please ⭐ the repo so other iOS developers can find it.

## License and credits

MIT © 2026 [Tarun](https://github.com/tarunyadav1). Includes skills adapted from [openai/plugins](https://github.com/openai/plugins) (MIT / Apache-2.0). See [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).
Not affiliated with Apple, Anthropic, OpenAI, RevenueCat, Sentry, Figma or Mobbin. All trademarks belong to their owners.

<sub>**Keywords:** Claude Code plugin, Claude Code skills, Claude Cowork plugin, Codex plugin, Codex skills, AGENTS.md, CLAUDE.md, MCP server, XcodeBuildMCP, Xcode MCP, iOS development, iOS app development, Swift, SwiftUI, Swift 6, Xcode, iOS Simulator, Liquid Glass, iOS 26, App Intents, Siri Shortcuts, WidgetKit, Swift Testing, XCTest, XCUITest, Instruments, ETTrace, memory leaks, fastlane, TestFlight, App Store Connect, App Store submission, App Review guidelines, ASO, App Store Optimization, app screenshots, privacy manifest, RevenueCat, StoreKit 2, in-app purchases, subscriptions, paywall, Sentry, crash reporting, Figma to SwiftUI, Mobbin, AI coding agent, AI pair programmer, indie iOS developer, vibe coding iOS app.</sub>
