---
name: infra-minis-browser-automation
description: "timevans-MINI-S has Playwright MCP (headless Chromium) so Claude can view + control any web page reachable from the host, incl. the router"
metadata: 
  node_type: memory
  type: reference
  originSessionId: e24d82e5-1bd0-48dc-99e6-9a4a434f0d2d
---

On [[infra-minis-remote-access]] (`timevans-MINI-S`) Claude Code can drive a real browser via the
**Playwright MCP** server — letting it look at and remote-control web pages (screenshot, read DOM,
click, type, navigate). Because the headless Chromium runs on the host (192.168.1.6), it can reach
LAN-only UIs: the **Zyxel DX3301-T0 router at http://192.168.1.1**, plus Portainer/Gitea/Nextcloud/Seafile.

**Setup (already done):**
- Server registered (user scope, in `~/.claude.json`, NOT in the synced claude-config repo):
  `claude mcp add playwright --scope user -- npx -y @playwright/mcp@latest --headless --browser chromium`
- Browser binary installed: `npx -y playwright@latest install chromium` (chrome-headless-shell in
  `~/.cache/ms-playwright`). System libs were already present on Zorin — no extra apt deps needed.
- Verified: headless Chromium screenshotted the Zyxel login page successfully.

**Tools:** `mcp__playwright__browser_navigate`, `browser_snapshot`, `browser_take_screenshot`,
`browser_click`, `browser_type`, etc. Fetch their schemas with ToolSearch when needed.

**Gotcha:** MCP tools load only at Claude Code startup, so after adding the server a **restart is
required** before the browser_* tools are callable.

**To control the router:** need the Zyxel admin username/password (device-sticker creds or whatever
it was changed to); log in via the browser then navigate. Use is per-session and local only.

**Why:** user wants Claude to inspect/operate the router web UI (e.g. for the planned reverse-proxy /
port-forward work) and other web UIs on the LAN. Related infra: [[infra-minis-docker-stacks]].
