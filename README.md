# claude-config

Private repo syncing Claude Code config across machines.

## Files

| File | Destination |
|------|------------|
| `CLAUDE.md` | `~/.claude/CLAUDE.md` |
| `settings.json` | `~/.claude/settings.json` |
| `memory/MEMORY.md` | `~/.claude/projects/-Users-<username>-Git/memory/MEMORY.md` |
| `memory/gsd-patterns.md` | `~/.claude/projects/-Users-<username>-Git/memory/gsd-patterns.md` |
| `memory/superpowers-patterns.md` | `~/.claude/projects/-Users-<username>-Git/memory/superpowers-patterns.md` |

## Install on a new machine

```bash
git clone https://github.com/slaguru666/claude-config.git
cd claude-config
chmod +x install.sh
./install.sh
```

The install script uses `whoami` to resolve the correct memory path automatically — no manual path editing needed.

## Keeping in sync

After editing any config file on one machine:

```bash
cd ~/Git/claude-config
cp ~/.claude/CLAUDE.md .
cp ~/.claude/settings.json .
cp ~/.claude/projects/-Users-$(whoami)-Git/memory/*.md memory/
git add -A
git commit -m "sync config"
git push
```

On the other machine:

```bash
cd ~/Git/claude-config
git pull
./install.sh
```
