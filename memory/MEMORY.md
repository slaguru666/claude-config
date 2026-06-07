# Memory index

- [Midjourney bridge](midjourney_bridge.md) — `mj-gen "<prompt>"` drops a PNG on disk; full pipeline via Discord, no MJ API needed.
- [GitHub account](user_github.md) — username: slaguru666; 19 repos, mostly SLA Industries Foundry VTT modules.
- [Semaphore Gitea URL](feedback_semaphore_gitea_url.md) — use `http://gitea:3000/tevans/<repo>.git` inside Semaphore, not the external Cloudflare URL
- [Plugin sync](project_plugin_sync.md) — keep Claude Code plugins identical across all servers via the claude-config repo (settings.json enabledPlugins); run sync.sh after install/remove
- [MINI-S remote access](infra_minis_remote_access.md) — timevans-MINI-S: static 192.168.1.6, key-only SSH + fail2ban, Zyxel DX3301-T0 port-forward 2222->22 (Voneus)
