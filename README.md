# glp1.health MCP server

The [MCP](https://modelcontextprotocol.io) server for [glp1.health](https://www.glp1.health): GLP-1 telehealth programs in the US, their scores and plans, FDA warning-letter facts, the GLP-1 price index and the glp1.health guides, in ChatGPT, Claude and any MCP client.

- **URL:** `https://www.glp1.health/mcp`
- **Transport:** Streamable HTTP
- **Auth:** none. The server is free and public. No account, no API key.
- **Docs:** <https://www.glp1.health/mcp>

This repository holds the server metadata and the plugin packages. The server runs on glp1.health.

## Tools

All tools only read data.

| Tool | Returns |
| --- | --- |
| `glp1_about` | What the site is, how it earns money, how scores and ranks work, and the medical disclaimer. |
| `glp1_search` | Find live pages and program reviews by words. Each result has its title, link and section. |
| `glp1_programs` | Every program glp1.health reviews, in the order of the comparison table, with its score, lowest monthly price and FDA warning-letter fact. Filter by medication or form. |
| `glp1_program` | One program: its plans and standing prices, live promotions, score by dimension, safety facts and the date the prices were checked. |
| `glp1_rankings` | A ranking page in the order the page shows it, with the same prices. Without a slug, the list of rankings. |
| `glp1_price_index` | The open GLP-1 price index: what each drug costs a month without insurance, with its date and its CSV files. |
| `glp1_page` | One page as text, with its figures filled in, its date, its medical reviewer and its sources. |

## Resources

| URI | Content |
| --- | --- |
| `glp1://about` | The `glp1_about` text as a markdown document. |

## How to read the answers

- A **score** runs from 0 to 10. Higher is better. Each answer says what each part counts for.
- A **standing price** is what a plan costs with no code and no sale. A **promotion** is a sale or a code. It changes no score and no rank.
- **Compounded GLP-1s** are not FDA-approved: the FDA doesn't review their safety, effectiveness or quality before they're sold. They are not the same product as Wegovy or Zepbound.
- glp1.health gives no medical advice. Talk to a licensed clinician about any medication decision.
- glp1.health earns referral fees from some programs. A fee does not change a score or a rank. See the [affiliate disclosure](https://www.glp1.health/affiliate-disclosure).

## Setup

### ChatGPT

Open **Settings → Apps → Advanced settings** and turn on developer mode. Then create an app with the URL `https://www.glp1.health/mcp` and **No authentication**.

### Claude

Open **Settings → Connectors → Add custom connector**. Paste `https://www.glp1.health/mcp`. Leave the OAuth fields empty.

### Claude Code

```sh
claude mcp add --transport http glp1-health https://www.glp1.health/mcp
```

Or install this repository as a plugin: it ships `.claude-plugin/plugin.json` and `.mcp.json`.

### Cursor

Add this to `~/.cursor/mcp.json`:

```json
{
  "mcpServers": {
    "glp1-health": {
      "url": "https://www.glp1.health/mcp"
    }
  }
}
```

### VS Code

Add this to `.vscode/mcp.json`:

```json
{
  "servers": {
    "glp1-health": {
      "type": "http",
      "url": "https://www.glp1.health/mcp"
    }
  }
}
```

### Any other client

Point the client at `https://www.glp1.health/mcp` with the Streamable HTTP transport. To test by hand:

```sh
curl -X POST https://www.glp1.health/mcp \
  -H 'content-type: application/json' \
  -H 'accept: application/json, text/event-stream' \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/list"}'
```

## Plugin packages

| File | For |
| --- | --- |
| `plugin.json`, `mcp.json`, `assets/` | The ChatGPT plugin directory ([Agent Plugins](https://agent-plugins.org) format, OpenAI listing under `extensions.com.openai`). |
| `.claude-plugin/plugin.json`, `.mcp.json` | Claude Code plugins. |
| `.grok-plugin/plugin.json`, `.mcp.json` | Grok Build plugins. |

To build the ZIP for [platform.openai.com/plugins](https://platform.openai.com/plugins):

```sh
./scripts/package-openai.sh
```

The ZIP lands in `dist/glp1-health-chatgpt.zip`. [SUBMISSION.md](SUBMISSION.md) lists what each directory asks for.

## Registry metadata

- `server.json` follows the [official MCP Registry](https://registry.modelcontextprotocol.io) schema.
- `glama.json` claims the listing on [Glama](https://glama.ai/mcp/servers).

To publish to the official registry:

```sh
mcp-publisher login github
mcp-publisher publish
```

## Limits

- US programs and US prices only.
- The server reads data only. It cannot sign you up, prescribe or sell anything.
- Please cache answers for a few minutes rather than polling. Prices are checked on a schedule, not every second.

## License

MIT
