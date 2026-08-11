---
name: infra-gitea-timevans
description: "gitea.timevans.uk pushes over SSH on port 2222, not 22 — HTTPS has no stored credential"
metadata: 
  node_type: memory
  type: reference
  originSessionId: 710730ff-4590-4412-82b8-d6ae6765d92b
  modified: 2026-08-10T19:08:17.601Z
---

`gitea.timevans.uk` (user `slaguru666`) accepts git over **SSH on port 2222**, not the
standard port 22. Remote URL form:

    ssh://git@gitea.timevans.uk:2222/<user>/<repo>.git

The key that authenticates is `~/.ssh/id_ed25519` (registered on Gitea as "Mac5").
Port 22 answers but its host key differs and it rejects the key; port 2222 is the one
that works.

HTTPS has **no stored credential** on this Mac — no credential helper, no token in the
keychain — so `git push` over HTTPS fails with "could not read Username". Use the SSH
remote rather than trying to supply a token.

Repos are publicly readable over HTTPS, so Foundry manifest URLs of the form
`https://gitea.timevans.uk/<user>/<repo>/raw/branch/main/system.json` resolve
anonymously and can be used for *Install System → Manifest URL*.

Related: [[ringbrp-project]], [[feedback_semaphore_gitea_url]]
