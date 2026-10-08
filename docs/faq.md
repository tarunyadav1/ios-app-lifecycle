# FAQ: Claude Code for iOS development

### What is the iOS App Lifecycle plugin?
An open-source bundle of 16 agent skills and 4 MCP servers that teaches Claude Code, Claude Cowork and Codex how to plan, build, test, ship and grow iOS apps with Swift, SwiftUI and Xcode.

### Can Claude Code build and run my iOS app?
Yes. Through **XcodeBuildMCP** and the **Xcode MCP bridge**, Claude can build your scheme, launch it on the iOS Simulator, tap through the UI, take screenshots, read logs and run tests. Claude Code running in your Mac's terminal can also call `xcodebuild` and `xcrun simctl` directly.

### Can it upload to TestFlight and submit to the App Store?
It prepares everything (pre-flight checklist, version bump, release notes, fastlane lane or `xcodebuild` commands) and runs the upload **only after you confirm**. Credentials stay in your environment or keychain.

### Does it work with Codex?
Yes. The skills are plain `SKILL.md` folders. Copy them into `~/.codex/skills/` and add the MCP servers to `config.toml` ([snippet](mcp-servers.md#codex-configtoml)). See [migrating.md](migrating.md).

### Does it work with Cursor, Copilot or Windsurf?
Those tools don't load `SKILL.md` natively, but you can point your rules file at a skill (for example, "follow `skills/ios-release/SKILL.md` when releasing"). The MCP servers work in any MCP-capable client.

### UIKit, React Native, Flutter?
- **UIKit**: debugging, testing, profiling, release, ASO, monetization and post-launch all apply.
- **React Native / Expo / Flutter**: release, App Store listing, monetization and post-launch apply; the SwiftUI skills don't.

### Which iOS and Xcode versions?
The skills target current Swift 6 and SwiftUI (Observation, strict concurrency), with Liquid Glass for iOS 26. Older deployment targets are supported with availability checks. Xcode 16+ is required; Xcode 26 is recommended.

### Is it safe? Will it publish something by itself?
No. Every irreversible action (uploading a build, submitting for review, changing prices, posting review replies) is shown to you first and waits for a yes.

### Do I need RevenueCat, Sentry, Figma or Mobbin?
No. Each one is optional, and the skills fall back to StoreKit 2, the Xcode Organizer, or plain descriptions.

### How do I update?
`/plugin marketplace update ios-app-lifecycle` in Claude Code, or download the newest `.plugin` from Releases.

### How do I contribute a skill?
See [CONTRIBUTING.md](../CONTRIBUTING.md).
