# Repository Guidelines

## Project Structure & Module Organization

This repository synchronizes Claude configuration across machines.

- `CLAUDE.md` contains global Claude Code instructions.
- `settings.json` stores shared settings, permissions, plugins, and non-secret environment defaults.
- `memory/` contains persistent Markdown memory copied into the current user's encoded Claude project directory.
- `projects/` contains instructions for manually configured claude.ai Projects.
- `prompts/` contains reusable session-start prompts.
- `install.sh` copies repository state into `~/.claude/` and configures optional CLI/MCP dependencies.
- `sync.sh` copies live configuration back into the repository, commits it, and pushes it.

Keep machine-specific permissions and transient state out of version control, especially `settings.local.json`.

## Development and Validation Commands

There is no compiled build or automated test suite. Validate changes with:

```bash
bash -n install.sh sync.sh       # Check shell syntax
jq empty settings.json           # Validate JSON syntax
git diff --check                 # Find whitespace errors
./install.sh                     # Install tracked config locally
./sync.sh "Describe the change"  # Import live state, commit, and push
```

Run `install.sh` deliberately: it overwrites live files under `~/.claude/` after backing up `settings.json`. Run `sync.sh` only when ready to commit and push; it also replaces tracked `memory/*.md` with the live memory set.

## Coding Style & Naming Conventions

Shell scripts use Bash, four-space indentation, quoted variable expansions, and `set -euo pipefail`. Prefer uppercase names for environment-derived constants (`CLAUDE_DIR`) and descriptive local names. Keep scripts portable across Linux and macOS unless a path is intentionally host-specific.

Use concise Markdown headings and short operational instructions. Name memory and project files with lowercase, descriptive, underscore-separated names, for example `infra_minis_remote_access.md`.

## Testing Guidelines

For shell changes, run syntax checks and manually exercise only the affected branch. Confirm copied paths and backup behavior without exposing credentials. For `settings.json`, run `jq empty` and review plugin identifiers and permission patterns carefully.

## Commit & Pull Request Guidelines

Recent commits use short, imperative summaries such as `Add GitHub MCP server setup to install.sh`. Keep each commit focused and explain affected files or systems. Pull requests should include a concise rationale, validation commands run, platform impact, and any manual installation steps. Never commit access tokens, private keys, or machine-local permission files.
