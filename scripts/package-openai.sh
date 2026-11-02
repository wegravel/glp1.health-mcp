#!/bin/sh
# Builds the ZIP for the ChatGPT plugin directory (platform.openai.com/plugins).
# The ZIP holds the manifest, the MCP config and the icons. The server needs
# no login, so the ZIP never holds credentials.
set -eu
cd "$(dirname "$0")/.."
mkdir -p dist
rm -f dist/glp1-health-chatgpt.zip
zip -q -X dist/glp1-health-chatgpt.zip plugin.json mcp.json assets/icon.png assets/logo.png
unzip -l dist/glp1-health-chatgpt.zip
