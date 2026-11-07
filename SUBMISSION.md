# Directory submissions

What each directory asks for, and the answers for glp1.health. The server needs no login, so no directory needs a test account.

## Before any submission

- [ ] Deploy the website with the public `/mcp` server, and check `https://www.glp1.health/mcp` in a browser (the page) and with the `curl` in the README (the tools).
- [x] Create the GitHub repository `wegravel/glp1.health-mcp` and push this folder.
- [ ] Add the URL as a custom connector in Claude and as a developer-mode app in ChatGPT. Run every tool once in each.
- [ ] Record a short demo video (a program, a ranking, the price index) at a link a reviewer can open. ChatGPT requires it.
- [ ] Run `claude plugin validate --strict .` here. It must pass.

Screenshots are for MCP Apps only (servers that draw a UI in the chat). This server returns text, so Claude needs none.

## Risk: prescription drugs

OpenAI's [submission guidelines](https://developers.openai.com/apps-sdk/app-submission-guidelines) list "prescription-only drugs (for example, insulin, antibiotics, Ozempic, opioids)" among the goods a plugin may not "sell, promote, facilitate, or meaningfully enable". They also forbid ads and comparative or price claims in the listing.

What the listing does about it:

- It describes reference information only: reviews, scores, FDA facts, a price index from public data, guides.
- Tool answers link to glp1.health pages, never to a program's sign-up page, a checkout or a `/go/` referral link.
- The listing text names no program, no price and no promotion.
- `commerce` is `false`, and the commerce note says glp1.health sells and prescribes nothing.

OpenAI may still reject the listing. The server stays usable in ChatGPT through developer mode, and in every other client.

## Official MCP Registry

```sh
brew install mcp-publisher   # once
mcp-publisher login github   # as a member of the wegravel org
mcp-publisher publish        # reads server.json
```

Bump `version` in `server.json`, `plugin.json` and both plugin folders on each release.

## Claude: Connectors Directory

Portal: [claude.ai/directory/manage](https://claude.ai/directory/manage) → **Submit new** → **MCP connector**. Guide: [Submit a connector](https://claude.com/docs/connectors/building/submission). Any paid Claude plan can submit. The portal saves each step in the browser.

After you submit, an automatic scan checks the policy and lists the connector as a **Community** connector. Some submissions also get a review by a person. Status and feedback appear in the portal. Escalations: `mcp-review@anthropic.com`.

| Step | Answer |
| --- | --- |
| Connection | `https://www.glp1.health/mcp` |
| Tools | Synced from the server. Every tool has a title and `readOnlyHint: true`. |
| Server name | glp1.health |
| One-liner | Research GLP-1 telehealth programs in the US with glp1.health reviews, scores, FDA facts and the GLP-1 price index. |
| Description | See [Long description](#long-description). |
| Categories | Health, Data and analytics (pick the closest the portal offers) |
| Documentation URL | https://www.glp1.health/mcp |
| Privacy policy URL | https://www.glp1.health/privacy-policy |
| Support contact | contact@glp1.health |
| Icon | `assets/logo.png` |
| URL slug | `glp1-health` (permanent) |
| Use cases | Compare how glp1.health reviews programs, read a ranking, check the price index, read a guide. Reads data only. |
| What users need | Nothing. No account. |
| Authentication | None |
| Data handling | Our own API and database. No personal health data collected. Sponsored content: none in the answers. The site earns referral fees, but the tools return no partner or sign-up link, and a fee does not change a score or a rank. |
| Allowed link URIs | `https://www.glp1.health` (only for a connector that opens links; harmless to give) |
| Test & launch | No account needed. Confirm you ran every tool as a custom connector in Claude. |
| Compliance | Seven acknowledgments. All are required. |

The directory policy counts healthcare as a high-risk use and asks for a clear disclosure to the user. The server instructions and `glp1_about` say that glp1.health gives no medical advice and that the user must talk to a licensed clinician.

### Carousel screenshots

PNG, at least 1000px wide, cropped to the app's answer, without the prompt. 3 to 5 images, each with its prompt:

| File | Prompt |
| --- | --- |
| `screenshots/1-program.png` | What does glp1.health say about the Embody program? |
| `screenshots/2-ranking.png` | Show me glp1.health's ranking of compounded semaglutide programs. |
| `screenshots/3-price-index.png` | What does the glp1.health price index say about GLP-1 costs right now? |
| `screenshots/4-guide.png` | Find the glp1.health guide on missed doses and summarize it. |

## Claude: plugin directory

The same portal also takes plugins. A plugin listed there reaches claude.ai, Cowork and Claude Code. This repository is the plugin: `.claude-plugin/plugin.json` and `.mcp.json`. Guide: [Submit a plugin](https://claude.com/docs/plugins/submit).

1. Push this folder to the public GitHub repository `wegravel/glp1.health-mcp`.
2. Run `claude plugin validate --strict .`.
3. Portal → **Submit new** → **Plugin**, with the repository URL.
4. Submit the server as a connector too (above). The portal pairs the two.

Anthropic's official marketplace (`claude-plugins-official`) takes no submissions through the portal.

Without any directory, a Claude Code user installs the plugin from this repository:

```sh
claude plugin install glp1-health --marketplace wegravel/glp1.health-mcp
```

## ChatGPT: plugin directory

Portal: [platform.openai.com/plugins](https://platform.openai.com/plugins) → **Upload new or existing plugin**. Guide: [Submission](https://developers.openai.com/apps-sdk/deploy/submission), [guidelines](https://developers.openai.com/apps-sdk/app-submission-guidelines).

1. Verify the business in the OpenAI organization settings, and set `developerName` in `plugin.json` to the verified legal name. Only an owner, or a member with **Apps Management Write**, can submit.
2. Build the ZIP: `./scripts/package-openai.sh`. Upload `dist/glp1-health-chatgpt.zip`.
3. **Domain verification:** copy the token the portal shows. The website serves it as plain text at `https://www.glp1.health/.well-known/openai-apps-challenge` from the `OPENAI_APPS_CHALLENGE_TOKEN` environment variable. Set it in Coolify, redeploy, then click Verify.
4. **MCP connection:** choose **No authentication**.
5. **Review details:** no test account. Add the demo video's URL to `review.demo_recording_url` in `plugin.json` (required), then rebuild the ZIP. `plugin.json` already holds the 5 positive and 3 negative test cases; run each one in developer mode first.
6. Fix any findings, then **Submit for review** and accept the attestations. Only one review runs at a time. The answer comes by email; to appeal, reply to it.
7. After approval, select **Publish plugin**.

OpenAI scans the server every day after that. After a change to the tools, ask for a new scan in the portal. The server's URL cannot change between versions.

### Rules that shaped the listing

- No prices, no promotions, no program names and no comparisons in the listing text.
- `displayName` and `shortDescription`: 30 characters or fewer. `longDescription`: 4,000 or fewer.
- No links to checkout or sign-up pages in tool answers.
- Country list: `["US"]`. The data covers US programs only.

## Other directories

| Directory | How |
| --- | --- |
| [Glama](https://glama.ai/mcp/servers) | Submit the GitHub URL. `glama.json` claims it. |
| [Smithery](https://smithery.ai) | **Publish** → remote server → `https://www.glp1.health/mcp`. |
| [mcp.so](https://mcp.so) | **Submit** with the GitHub URL. |
| [PulseMCP](https://www.pulsemcp.com/submit) | Submit the GitHub URL. It also reads the official registry. |

## Long description

glp1.health is an independent reference site about GLP-1 medications and the telehealth programs that offer them in the United States.

Ask about a program and glp1.health returns what its review records: the medications it lists, its plans, its score out of 10 with each part of the score, whether the FDA has a warning letter on file for it, and when the facts were last checked. Ask for a ranking and it returns the glp1.health list in the same order as the website. Ask about cost and it returns the glp1.health price index, built from public data such as the CMS drug price surveys, with its date.

It can also find and read any glp1.health guide, so the answer quotes the page and links to it.

Compounded GLP-1s are not FDA-approved: the FDA doesn't review their safety, effectiveness or quality before they're sold. glp1.health gives no medical advice. Talk to a licensed clinician about any medication decision.

glp1.health reads data only. It needs no account and collects no health information.
