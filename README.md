# claude-config

Private repo syncing Claude Code config across machines.

## What's tracked

| File | Source | Destination |
|------|--------|-------------|
| `CLAUDE.md` | `~/.claude/CLAUDE.md` | Global Claude Code instructions |
| `settings.json` | `~/.claude/settings.json` | Permissions, model, env vars |
| `memory/*.md` | `~/.claude/projects/-Users-<username>/memory/` | Persistent memory files |
| `skills/` | `~/.claude/skills/` | Shared skills (e.g. `rpg` — scenario-writing system) |

**Not tracked:** `settings.local.json` — accumulates one-off permissions per session, machine-specific.

**Sync order matters:** `sync.sh` copies *live state over the repo* (memory and skills
included, with deletes). Always `git pull && ./install.sh` **before** working, and
`./sync.sh` after — syncing from a machine that hasn't installed the latest pull will
remove the other machines' memory/skill files from the repo.

**CLI dependencies:** `install.sh` also installs the Codex CLI (`npm install -g @openai/codex`) and the
QuickDesign CLI (`npm install -g @quickdesign/cli`) when missing,
since the `codex@openai-codex` and `quickdesign@claude-community` plugins shell out to them. Requires `npm` on
the target machine. QuickDesign also needs a one-off `quickdesign login` per machine (OAuth; not synced).

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

Memory files live under `~/.claude/projects/<project-key>/memory/`, where `<project-key>` is
the home directory with `/` replaced by `-`. The scripts derive this from `$HOME` automatically,
so it resolves correctly on macOS (`-Users-<username>`) and Linux (`-home-<username>`).
