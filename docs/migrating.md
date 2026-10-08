# Migrating your iOS workflow to Claude Code (from Codex, Cursor, Copilot, Windsurf)

This guide is for iOS developers moving to **Claude Code** or **Claude Cowork** from **OpenAI Codex**, **Cursor**, **GitHub Copilot**, **Windsurf** or another AI coding agent. It shows where each piece of your old setup goes so your skills, MCP servers, project instructions and habits come with you.

- [1. Install the plugin](#1-install-the-plugin)
- [2. Skills: SKILL.md works almost everywhere](#2-skills-skillmd-works-almost-everywhere)
- [3. MCP servers: config.toml → .mcp.json](#3-mcp-servers-configtoml--mcpjson)
- [4. Project instructions: AGENTS.md / .cursorrules → CLAUDE.md](#4-project-instructions-agentsmd--cursorrules--claudemd)
- [5. Computer use and the in-app browser](#5-computer-use-and-the-in-app-browser)
- [6. Permissions and sandbox](#6-permissions-and-sandbox)
- [7. Cheat sheet](#7-cheat-sheet)

---

## 1. Install the plugin

```bash
/plugin marketplace add tarunyadav1/ios-app-lifecycle
/plugin install ios-app-lifecycle@ios-app-lifecycle
```

This gives you all 8 skills from Codex's `build-ios-apps` plugin, adapted for Claude, plus 7 new lifecycle skills and the MCP servers.

## 2. Skills: SKILL.md works almost everywhere

Codex skills (`~/.codex/skills/<name>/SKILL.md`) and Claude skills use the same format: YAML frontmatter with `name` and `description`, then markdown instructions, optional `references/` and `scripts/`.

To move your own Codex skills:

```bash
# Claude Code (personal skills)
mkdir -p ~/.claude/skills
cp -R ~/.codex/skills/<skill-name> ~/.claude/skills/
```

Then check each `SKILL.md` for Codex-only references:

| Codex-only thing | Replace with |
|---|---|
| `codex mcp add …` / `codex mcp login …` | A Claude connector (Settings → Connectors) or an `.mcp.json` entry |
| `sandbox_permissions=require_escalated` | Remove it. Claude asks for permission when it needs it |
| `write_stdin` / TTY instructions | "Run in an interactive terminal" |
| Paths like `<path-to-skill>` | `${CLAUDE_PLUGIN_ROOT}/skills/<name>` inside a plugin, or an absolute path |
| The Codex in-app browser or `node_repl` | The Claude in Chrome extension, Claude's built-in browser, or XcodeBuildMCP for the Simulator |

## 3. MCP servers: config.toml → .mcp.json

Codex stores MCP servers in TOML; Claude uses JSON.

**Codex (`~/.codex/config.toml`)**

```toml
[mcp_servers.xcode]
command = "xcrun"
args = ["mcpbridge"]

[mcp_servers.search-console]
command = "/Users/me/.local/bin/gsc-mcp"
[mcp_servers.search-console.env]
GOOGLE_SERVICE_ACCOUNT_FILE = "/Users/me/.config/gsc/sa.json"

[mcp_servers.figma]
url = "https://mcp.figma.com/mcp"
```

**Claude (`.mcp.json` in a project, or via `claude mcp add`)**

```json
{
  "mcpServers": {
    "xcode": { "command": "xcrun", "args": ["mcpbridge"] },
    "search-console": {
      "command": "/Users/me/.local/bin/gsc-mcp",
      "env": { "GOOGLE_SERVICE_ACCOUNT_FILE": "/Users/me/.config/gsc/sa.json" }
    },
    "figma": { "type": "http", "url": "https://mcp.figma.com/mcp" }
  }
}
```

Or from the CLI:

```bash
claude mcp add xcode -- xcrun mcpbridge
claude mcp add --transport http figma https://mcp.figma.com/mcp
```

For the **Claude desktop app**, add local servers under Settings → Developer → Edit Config, and remote servers under Settings → Connectors → Add custom connector. Figma, Linear, GitHub and many others are available as one-click connectors.

> Skip Codex-internal servers such as `node_repl` and `computer-use`. They only run inside the Codex app.

## 4. Project instructions: AGENTS.md / .cursorrules → CLAUDE.md

| Tool | File |
|---|---|
| Codex | `AGENTS.md` |
| Cursor | `.cursorrules` / `.cursor/rules/*.mdc` |
| Copilot | `.github/copilot-instructions.md` |
| Windsurf | `.windsurfrules` |
| **Claude Code** | **`CLAUDE.md`** |

Easiest path: ask Claude *"Set up CLAUDE.md for this project"*. The `ios-project-setup` skill writes it with your schemes, build and test commands, simulator name and conventions. To reuse an existing `AGENTS.md`, add one line to `CLAUDE.md`:

```markdown
@AGENTS.md
```

## 5. Computer use and the in-app browser

| Codex | Claude |
|---|---|
| Codex Computer Use app | Claude's computer use (enable it in the desktop app's settings) |
| In-app browser Simulator mirror | XcodeBuildMCP: `screenshot`, `snapshot_ui`, `tap`, `type_text`, `record_sim_video` |
| Browser automation | Claude in Chrome, or Claude's built-in browser |

## 6. Permissions and sandbox

Codex's `approval_policy` and `sandbox_mode` correspond to Claude Code's permission modes and `settings.json` allow and deny rules. A sensible iOS setup is to allow `xcodebuild`, `xcrun simctl`, `swift` and `git status/diff/log` without prompts, and keep prompts for `git push`, `fastlane` and anything that uploads.

## 7. Cheat sheet

| I want to… | Say |
|---|---|
| Get oriented in a repo | "Where is this app in its lifecycle? What's next?" |
| Recreate my AGENTS.md | "Set up CLAUDE.md for this project." |
| Run on the simulator | "Build and run on the iPhone 17 simulator, then take a screenshot." |
| Ship | "Run the release pre-flight and push a TestFlight build." |
| Write the store listing | "Write my App Store listing and run the review pre-check." |
