# Claude.ai Projects — Setup Guide

These files are the custom instructions for claude.ai Projects. Each Project gives the web/browser surface the same context that Claude Code gets from CLAUDE.md and memory files.

## Projects to create

| File | Project name | Use for |
|------|-------------|---------|
| `general.md` | General Engineering | Catch-all: scripting, tooling, anything that doesn't fit another project |
| `foundry-dev.md` | FoundryVTT Dev | zero-engine, modules, Foundry system/module work |
| `infrastructure.md` | Infrastructure | VPS, Docker, Gitea, CI/CD, server work |
| `rpg-creative.md` | RPG & Creative | SLA Industries writing, Stormbringer, convention prep |

## How to set up a Project

1. Go to claude.ai → **Projects** → **New Project**
2. Name it (use the names in the table above for consistency)
3. Open **Project Instructions** and paste the contents of the relevant `.md` file
4. Save

## Keeping Projects in sync

When `CLAUDE.md` or domain knowledge changes:
1. Update the relevant file in `projects/`
2. Run `./sync.sh` to commit and push
3. Manually paste the updated file into the Project's instructions on claude.ai

There's no API to push instructions automatically — this step stays manual.

## Why Graphiti matters here

Each instruction file starts with a Graphiti session-start call. Graphiti MCP is already connected to claude.ai, so every Project conversation has access to live memory — facts, decisions, project state — that Graphiti learned from Claude Code sessions. This is what makes the web surface dynamic rather than just static context.
