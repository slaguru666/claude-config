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
- **In zsh, `"$ref:src/..."` silently drops everything after the colon.** zsh reads
  `:s` as a history-style substitution modifier on the parameter, so
  `"$ref:src/board/sheet.mjs"` expands to bare `a5e772e` — no error, no warning.
  `git show "$ref:path"` then prints the whole commit (99 KB of message and diff)
  and `git cat-file -p "$ref:path"` returns the commit object (2.6 KB); both hash
  cleanly and look like a plausible file. On 2026-09-13 two sessions produced
  byte-identical wrong md5s this way and spent an evening unable to reproduce each
  other. **Brace it — `"${ref}:path"`** — and verify with
  `git ls-tree -r <ref> -- <path>` then `git cat-file blob <sha>`, checking the byte
  count against `cat-file -s`. bash is unaffected; the shell here is zsh, so this
  applies to any `"$var:suffix"`, not only git.
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
- **No artefact names a session.** Four misattributions in one evening
  (2026-09-13) all came from inferring an actor from a thing: every commit is
  authored `slaguru666`; a deployed file's mtime names only the **last** deploy,
  because `rsync` overwrites; and sessions driving Tim's Chrome share one egress
  IP while their ssh uses another, so one address covers several actors doing
  opposite things minutes apart. Verify a deploy by **content against commits**.
  Ask a peer rather than infer — and when a check you *can* run contradicts a
  peer's account, the fix is a measurement, not a louder account.
- **Never chain a commit off a filtered test run.** `vitest | grep … && git commit`
  commits on *grep's* exit status, which is green whenever the pattern matches
  anything at all — and a `FAIL` pattern matches a failing run more readily than a
  passing one. Read the runner's own status.

## Verifying

- **Hash the object you proved you hashed.** `git show <ref>:<path>` has been observed
  returning the wrong number of bytes (git 2.54.0, no `.gitattributes`), producing
  plausible-looking md5s of nothing. Use `git ls-tree -r <ref> -- <path>` for the blob
  sha, `git cat-file blob <sha>` to read it, and `git cat-file -s <sha>` to confirm the
  size first.
- **Never date a deploy from a deployed file's mtime.** A build that copies a tree
  stamps every file with the latest deploy and erases earlier ones. Compare content.
- **A host's egress is not its browser's egress.** The Claude-in-Chrome extension exits
  from its own address, so `isLocal`, the default route and an ssh source IP say nothing
  about where the driven browser appears to come from. Measure it — fetch an IP echo
  service through the same tool.

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
