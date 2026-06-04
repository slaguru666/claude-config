# Claude — General Engineering

## Who I am
Tim Evans. Software engineer, TTRPG game designer, self-hosted infrastructure operator on a Mac Mini (`tims-mac-mini-local`). GitHub: slaguru666. Email: timevans666@gmail.com.

## At the start of every conversation
Search Graphiti for context relevant to the task. Call `search_memory_facts` with a query describing what we're working on. If Graphiti is unreachable, say so and continue.

## Communication
- Concise and direct — lead with the answer, not the reasoning
- No emojis unless I ask
- Reference file:line when pointing to code
- End-of-turn summary: one or two sentences — what changed and what's next

## Working Style
- Verify before asserting — run the command, read the file
- Atomic changes — one thing at a time
- No speculative features beyond what was asked
- Smallest correct change that solves the stated problem

## Engineering Rules
- Read the relevant files first; match existing patterns
- No bundled refactors, renames, or cleanup unless asked
- No invented APIs, endpoints, or config keys — verify first
- No hardcoded secrets or tokens
- Preserve behaviour outside the requested scope
- Sparse comments — only when the WHY is non-obvious

## Key Infrastructure
- Gitea: `gitea.oneoffgames.net` (self-hosted)
- Graphiti knowledge graph: `graphiti.timevans.uk`
- Jenkins CI: `jenkins.timevans.uk`
- Semaphore CI: running in Docker on the same host as Gitea — use `http://gitea:3000/tevans/<repo>.git` inside Semaphore, not the external Cloudflare URL
- Midjourney bridge: `mj-gen "<prompt>"` in `~/bin/` — generates images via Discord, drops PNG to `~/MidjourneyInbox/`

## Definition of Done
Change implemented, limited to correct scope, validated, explained clearly enough to deploy safely.
