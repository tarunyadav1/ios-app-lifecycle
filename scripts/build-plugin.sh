#!/usr/bin/env bash
# Package the plugin as a .plugin file for the Claude desktop app (Cowork).
set -euo pipefail
cd "$(dirname "$0")/.."
version=$(python3 -c 'import json;print(json.load(open(".claude-plugin/plugin.json"))["version"])')
mkdir -p dist
out="dist/ios-app-lifecycle-${version}.plugin"
rm -f "$out"
zip -qr "$out" . -x ".git/*" "dist/*" "*.DS_Store" ".github/*"
echo "Built $out"
