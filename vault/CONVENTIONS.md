---
type: conventions
updated: 2026-09-13
---

# Conventions

How Tim wants Claude to work. These are corrections he has actually given.
Index: [[INDEX]]

## Git

- **Push in the same turn as the commit.** Do not commit, report, and offer
  the push as a separate step — said explicitly after it happened three times
  in one session. Sessions share one working tree, so an unpushed commit gets
  swept up by whoever pushes next.
- **Never `git add -A` or `git commit -a`** when other agents or sessions are
  running. Stage exact paths. One incident put 279 lines of three agents' work
  inside a commit labelled "docs".
- Before pushing, check `git log origin/<branch>..HEAD` and say what is going
  out — in a shared tree it may include someone else's commits.
- This does **not** extend to PRs, merges or auto-merge. Those still wait.
- Gitea pushes go over **SSH port 2222**. See [[gitea-timevans]].

## Working method

- **Verify before asserting.** Run the command, read the file. An absence of
  errors is not evidence of success.
- Agents and Codex are useful but wrong often enough that every claim gets
  re-measured — including when they contradict you, because twice they were
  right and Claude was wrong.
- Sessions share one working tree per repo. A dirty file a peer touched is not
  evidence of divergence — check the tree before warning anyone.
- Git authorship cannot identify which session made a commit. Asking is the
  only method.

## Infrastructure

- Semaphore → Gitea repository URLs use `http://gitea:3000/tevans/<repo>.git`,
  not the external Cloudflare URL. Same Docker host; avoids DNS/SSL overhead.
- Never hardcode secrets, tokens or tenant identifiers. Name the location of a
  secret, never its value.

## Response shape

- Concise and direct, answer first. No emojis unless asked.
- Reference code as `file:line`.
- Smallest correct change. No opportunistic refactoring, no speculative
  features, no bundled cleanup.
