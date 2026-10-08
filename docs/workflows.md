# iOS development workflows with Claude Code

Copy-paste recipes for common iOS jobs. Each one lists the prompts to send and the skills they trigger.

- [Idea to TestFlight in a weekend](#idea-to-testflight-in-a-weekend)
- [Figma to SwiftUI](#figma-to-swiftui)
- [Fix a janky scroll or slow launch](#fix-a-janky-scroll-or-slow-launch)
- [Hunt a memory leak](#hunt-a-memory-leak)
- [Add subscriptions with RevenueCat](#add-subscriptions-with-revenuecat)
- [Release day](#release-day)
- [First App Store submission](#first-app-store-submission)
- [Weekly post-launch check](#weekly-post-launch-check)
- [Add Siri and Shortcuts support](#add-siri-and-shortcuts-support)
- [Adopt Liquid Glass for iOS 26](#adopt-liquid-glass-for-ios-26)

---

## Idea to TestFlight in a weekend

1. `Plan an MVP for <idea>. Who is it for, which screens, what are the risks, and a milestone plan.` → **ios-lifecycle**
2. `Find 5 onboarding flows on Mobbin for apps like this and summarize the patterns.` → Mobbin MCP
3. `Create the Xcode project with the structure you recommend, plus CLAUDE.md.` → **ios-project-setup**
4. `Build the MVP screens.` → **swiftui-ui-patterns**
5. `Run it on the simulator and tap through every screen. Fix what's broken.` → **ios-debugger-agent**
6. `Add unit tests for the models and a UI test for onboarding.` → **ios-testing**
7. `Set up fastlane and push a TestFlight build.` → **ios-release**

## Figma to SwiftUI

```text
Implement this screen from Figma using our existing components and tokens: <figma link>
Then run it on the simulator and compare it against the Figma screenshot.
```

Connect the Figma connector first. This uses **figma-implement-design** (or the Figma plugin's `figma-swiftui`), then **swiftui-ui-patterns**, then **ios-debugger-agent**.

## Fix a janky scroll or slow launch

```text
The feed scrolls janky on an iPhone 12. Audit it from the code first, then profile it if needed.
```

→ **swiftui-performance-audit** → **ios-ettrace-performance** (flame graph) → fix → re-measure.

## Hunt a memory leak

```text
Memory keeps growing when I open and close the editor. Capture memgraphs before and after, and find the leak.
```

→ **ios-memgraph-leaks**

## Add subscriptions with RevenueCat

```text
Add Pro with a monthly and an annual subscription and a 7-day trial using RevenueCat.
Model the catalog first, then implement it, then give me a sandbox test checklist.
```

→ **ios-monetization** (uses the RevenueCat MCP; asks before changing anything in the dashboard).

## Release day

```text
Prepare version 1.3.0: run the pre-flight checklist, bump the build number, write What's New
from the commits since the last tag, and show me the exact fastlane command before running it.
```

→ **ios-release** + **app-store-listing**

## First App Store submission

```text
This is my first submission. Write the App Store listing (title, subtitle, keywords, description),
plan the screenshots, build the privacy nutrition label from the code, and run an App Review pre-check.
```

→ **app-store-listing** → **ios-release**

## Weekly post-launch check

```text
Weekly health check: crash-free rate and top crashes, new reviews by theme, revenue. Top 3 actions.
Then draft replies to the new 1–3★ reviews.
```

→ **ios-post-launch** + **ios-crash-monitoring-sentry**. You can schedule this to run every Monday.

## Add Siri and Shortcuts support

```text
Expose "start a recording" and "open last note" to Siri, Shortcuts and Spotlight.
```

→ **ios-app-intents**

## Adopt Liquid Glass for iOS 26

```text
Adopt Liquid Glass in the tab bar and the floating toolbar, with a fallback for iOS 18.
```

→ **swiftui-liquid-glass**
