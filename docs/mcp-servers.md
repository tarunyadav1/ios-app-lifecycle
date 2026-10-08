# MCP servers for iOS development (XcodeBuildMCP, Xcode MCP, RevenueCat, Mobbin, Figma)

The plugin's `.mcp.json` configures these Model Context Protocol servers, so the AI agent can build, run and test your iOS app, manage subscriptions and research UI.

| Server | Transport | What the agent can do | Setup |
|---|---|---|---|
| **XcodeBuildMCP** | stdio (`npx -y xcodebuildmcp@latest mcp`) | Build and run on the Simulator, run tests, coverage, UI automation (tap, swipe, type), screenshots, screen recording, logs, LLDB debugging | Node 18+, Xcode. Nothing else. |
| **Xcode MCP bridge** | stdio (`xcrun mcpbridge`) | Build, run, test, read crash and field-performance logs, render SwiftUI previews, edit build settings and string catalogs, search Apple documentation | A recent Xcode that ships `mcpbridge` (Xcode 26.x) |
| **RevenueCat** | HTTP `https://mcp.revenuecat.ai/mcp` | Read and create products, entitlements and offerings; read revenue metrics | Sign in with OAuth on first use |
| **Mobbin** | HTTP `https://api.mobbin.com/mcp` | Search real-world app screens and flows for design references | A Mobbin account |
| **Figma** *(connector, not bundled)* | HTTP | Design-to-code, code-to-design, design tokens, Code Connect | Claude → Settings → Connectors → Figma |

## Choosing which servers to enable

- Remove any server you don't use from `.mcp.json`. Fewer tools means faster, more focused sessions.
- `XCODEBUILDMCP_ENABLED_WORKFLOWS` limits XcodeBuildMCP to `simulator,ui-automation,debugging,logging`. Add `device` to work with physical devices if your XcodeBuildMCP version supports it.

## Claude Code: add servers manually

```bash
claude mcp add XcodeBuildMCP -e XCODEBUILDMCP_ENABLED_WORKFLOWS=simulator,ui-automation,debugging,logging -- npx -y xcodebuildmcp@latest mcp
claude mcp add xcode -- xcrun mcpbridge
claude mcp add --transport http revenuecat https://mcp.revenuecat.ai/mcp
claude mcp add --transport http mobbin https://api.mobbin.com/mcp
```

## Codex config.toml

```toml
[mcp_servers.XcodeBuildMCP]
command = "npx"
args = ["-y", "xcodebuildmcp@latest", "mcp"]
[mcp_servers.XcodeBuildMCP.env]
XCODEBUILDMCP_ENABLED_WORKFLOWS = "simulator,ui-automation,debugging,logging"

[mcp_servers.xcode]
command = "xcrun"
args = ["mcpbridge"]

[mcp_servers.revenuecat]
url = "https://mcp.revenuecat.ai/mcp"

[mcp_servers.mobbin]
url = "https://api.mobbin.com/mcp"
```

## Tool naming

Inside a plugin, tool names get a prefix, for example `mcp__plugin_ios-app-lifecycle_XcodeBuildMCP__build_run_sim`. The skills refer to tools by their base name (`build_run_sim`), and Claude resolves the prefix itself.

## Claude Cowork note

Cowork's shell runs in a Linux sandbox, but stdio MCP servers run on your Mac. Xcode and Simulator work therefore goes through these servers. For long build, test and release sessions, Claude Code in the terminal is the smoothest option.
