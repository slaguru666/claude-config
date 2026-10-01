---
name: stylish-login-screen
description: "Third-party Foundry module (The Final Artificer, v1.6.2) giving players a click-your-portrait login page; installed on the Mac Mini and the VPS, live in world `classified`; share-URL and blob-navigation gotchas"
metadata:
  node_type: memory
  type: project
  originSessionId: dd0849e9-fb66-43f5-a9ff-cac42b82fd17
  modified: 2026-09-30T17:26:25.771Z
---

**Stylish Login Screen v1.6.2** is installed at `~/FoundryVTT/Data/modules/stylish-login-screen` (Mac Mini, Foundry 14.361) and `/root/foundrydata/Data/modules/stylish-login-screen` on the VPS (Foundry 14.363, systemd `foundryvtt13`). Source zip: `~/Downloads/stylish-login-screen.zip`. Enabled and configured (2026-09-30) in the VPS world `classified` (ringbrp), preset 1 with six portraits; layouts land in `Data/stylish-login-screen-images/<world>/layout-preset-N.json`.

Player URL: `https://foundry.oneoffgames.com/modules/stylish-login-screen/launch.svgz?world=<id>&preset=<n>`. On Foundry 14.361+ module `.html` is served as `text/plain`, so the module uses an SVG launcher that fetches `login.html` and navigates the tab to a `blob:` URL.

Gotchas:
- The module builds its "internet" share URL from Foundry's auto-detected remote address, which is the **bare IP**; nginx routes a bare-IP HTTPS request to the code-server block (401). The module's **Custom base URL** setting is set to `https://foundry.oneoffgames.com` in `classified`; a new world needs it set again.
- The `blob:` top-level navigation is silently blocked in the Claude in-app browser pane (blank white page) but works in real Chrome. Test this page with Claude in Chrome, not the pane.
- Reviewed before install: passwords go only to Foundry's own `/join`; the only external hosts are the author's community-preset index (GitHub) and a submit endpoint on workers.dev.

**Why:** the first attempt to use the share URL failed with a 401 and looked like a broken module. **How to apply:** for any "login page doesn't load" report, check the hostname in the URL first, then the browser. Related: [[infra-oneoffgames-vps]].
