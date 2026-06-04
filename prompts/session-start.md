# Session Start Prompts

Paste one of these at the start of a conversation to orient Claude before describing your task.
Pick the variant that matches the surface and how much context you need.

---

## Standard (claude.ai web — Projects with Graphiti MCP)

```
Before I describe the task: search Graphiti for context relevant to [project/topic].
State what you already know — key facts, recent decisions, active work — in 3–5 bullet points.
Then wait for my task description.
```

---

## Quick (when you just want Graphiti queried, no preamble)

```
Search Graphiti for: [topic]. Summarise what you find in bullets, then I'll describe the task.
```

---

## Claude Code CLI (already has CLAUDE.md + auto-memory, but for a fresh angle)

```
Check MEMORY.md and search Graphiti for context on [project].
State what you already know before I describe the task.
```

---

## Desktop / browser (no Graphiti MCP, no Project instructions)

```
I'm Tim Evans. I'm working on [project]. Key context:
- GitHub: slaguru666
- FoundryVTT system: zero-engine (SLA Industries, YZE, v1.6.x)
- Infrastructure: self-hosted Docker stack on 77.68.99.134 — Gitea, Semaphore, Jenkins, Caddy, Graphiti
- Working style: smallest correct change, verify before asserting, no speculative features

[Paste any relevant excerpt from the appropriate projects/*.md file here if needed]

Now: [describe task]
```

---

## Notes

- On claude.ai **inside a Project**: the Project instructions already carry most context — just use the Quick variant.
- On claude.ai **outside a Project**: use the Desktop variant and paste relevant domain context from `projects/*.md`.
- Graphiti is only queryable where the MCP connector is live (claude.ai web, Claude Code CLI).
