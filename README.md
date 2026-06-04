# claude-config

Private repo syncing Claude Code config across machines.

## What's tracked

| File | Source | Destination |
|------|--------|-------------|
| `CLAUDE.md` | `~/.claude/CLAUDE.md` | Global Claude Code instructions |
| `settings.json` | `~/.claude/settings.json` | Permissions, model, env vars |
| `memory/*.md` | `~/.claude/projects/-Users-<username>/memory/` | Persistent memory files |

**Not tracked:** `settings.local.json` — accumulates one-off permissions per session, machine-specific.

## Install on a new machine

```bash
git clone https://github.com/slaguru666/claude-config.git ~/Git/claude-config
cd ~/Git/claude-config
chmod +x install.sh sync.sh
./install.sh
```

## Sync after changes

Pull the latest live state into the repo and push:

```bash
cd ~/Git/claude-config
./sync.sh                    # syncs, commits, pushes with default message
./sync.sh "my commit msg"    # custom message
```

On another machine, pull and reinstall:

```bash
cd ~/Git/claude-config
git pull
./install.sh
```

## Memory path

Memory files live at `~/.claude/projects/-Users-<username>/memory/`. The scripts resolve
`<username>` via `whoami` automatically.
