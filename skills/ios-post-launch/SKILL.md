---
name: ios-post-launch
description: Run the loop after an iOS release — crash and hang triage, App Store review replies, ratings prompts, metrics review, and planning the next version. Use for "how is the launch going", "triage crashes", "reply to reviews", "what should v1.1 be", or a weekly app health check.
---

# iOS Post-launch Loop

## Weekly health check

Collect what's available and summarize it in one short report:

1. **Stability** — the crash-free sessions/users rate and the top crashes by count. Sources: Sentry (`ios-crash-monitoring-sentry`), the Xcode Organizer (Crashes, Hangs, Energy), or App Store Connect.
2. **Performance** — new hangs, launch-time regressions, memory terminations. Route any fixes to `swiftui-performance-audit`, `ios-ettrace-performance` or `ios-memgraph-leaks`.
3. **Revenue** — from `ios-monetization` (if the app is monetized).
4. **Ratings and reviews** — the new reviews since last week, grouped by theme (bug, feature request, confusion, praise).
5. **Funnel** — any analytics the user has (onboarding completion, activation, retention).

End with the top 3 actions, ranked by user impact.

## Crash triage

For each top crash:

- Symbolicate it (dSYMs must be uploaded; `ios-ettrace-performance` has a dSYM collection script).
- Find the faulting frame in the app's code, reproduce it if you can (`ios-debugger-agent`), write a failing test (`ios-testing`), and fix it.
- Note the affected versions and whether a hotfix release is justified. If it is, hand off to `ios-release`.

## Review replies

- Draft replies: thank the user, address the specific issue, say if it's fixed or planned. Never promise dates, and never ask for a better rating in exchange for anything.
- Present the drafts for the user to post. Don't post them yourself.

## Ratings prompt

Use `RequestReviewAction` / `requestReview` only after a success moment (a task completed, a few sessions in). Never right after launch or after an error. The system limits how often the prompt can appear, so don't build custom pre-prompts that ask "do you like the app?" first.

## Plan the next version

Turn the report into a short, prioritized backlog for the next version: fixes first, then the most-requested features that fit the product, then experiments. If Linear is connected, offer to create the issues.
