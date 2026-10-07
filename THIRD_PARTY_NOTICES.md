# Third-party notices

This plugin includes skills adapted from OpenAI's open-source plugin collection
(https://github.com/openai/plugins, commit 5fd93af4cd0c623e020d0cc7e9ce178b4ac1f70f).

| Skill(s) in this repo | Source | License | Changes |
|---|---|---|---|
| `ios-app-intents`, `ios-debugger-agent`, `ios-ettrace-performance`, `ios-memgraph-leaks`, `swiftui-liquid-glass`, `swiftui-performance-audit`, `swiftui-ui-patterns`, `swiftui-view-refactor` | `plugins/build-ios-apps` © OpenAI | MIT | Removed Codex-specific agent metadata; renamed temp-dir prefixes; replaced Codex TTY instructions with generic ones |
| `ios-crash-monitoring-sentry` | `plugins/sentry` | Apache-2.0 (see `skills/ios-crash-monitoring-sentry/LICENSE.txt`) | Renamed the skill; script path now resolves via `${CLAUDE_PLUGIN_ROOT}`; description scoped to iOS crash triage |

All other files are original to this repository and licensed under the MIT License (see `LICENSE`).

## MIT License text for the OpenAI build-ios-apps skills

```
MIT License

Copyright (c) OpenAI

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
