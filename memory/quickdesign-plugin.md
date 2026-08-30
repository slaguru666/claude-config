---
name: quickdesign-plugin
description: QuickDesign AI-media plugin and CLI — both installed 2026-08-30; marketplace id is claude-community, and the CLI still needs `quickdesign login`.
metadata:
  type: reference
---

`quickdesign@claude-community` — AI media generation (UGC/talking-avatar video, multi-segment promos, image edits, video upscale) via Seedance 2.0 R2V/I2V, Kling 3 Pro, Sora 2, Nano Banana 2, GPT Image, Topaz upscale.

- Marketplace: `anthropics/claude-plugins-community`, but its declared **name is `claude-community`**, not the repo name — so the plugin id is `quickdesign@claude-community`. Installing by repo name fails.
- Upstream (the actual product): https://github.com/ottasilver/quickdesign-cli — https://quickdesign.io. Community-contributed, not Anthropic-authored.
- Installed at user scope, v0.8.0, 2026-08-30. Cache: `~/.claude/plugins/cache/claude-community/quickdesign/0.8.0`.
- Wraps a `quickdesign` binary, installed globally 2026-08-30 (`npm install -g @quickdesign/cli`, v0.8.0, at `~/nodejs/quickdesign`). **Not authed yet** — `quickdesign whoami` says "Not logged in"; run `quickdesign login` (OAuth browser flow, token to `~/.config/quickdesign/auth.json`; `--token-stdin` or `QUICKDESIGN_TOKEN` for headless/CI). Hosted paid SaaS backend.
- **Do NOT run `quickdesign init`** — it copies the same skill into `~/.claude/skills/quickdesign`, duplicating the plugin copy. Use `quickdesign login` alone.
- Skill hard rule worth knowing: `seedance-2.0-r2v` is the default for *all* UGC/avatar/promo work — do not "downgrade" to `seedance-2.0-i2v` just because the clip is short; i2v forfeits multi-`--reference-image` and `--reference-audio` voice continuity.

Related: [[claude-plugin-install-cli]]
