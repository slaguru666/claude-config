---
name: infra-gitea-timevans
description: "gitea.timevans.uk pushes over SSH on port 2222, not 22 — HTTPS has no stored credential"
metadata: 
  node_type: memory
  type: reference
  originSessionId: 710730ff-4590-4412-82b8-d6ae6765d92b
  modified: 2026-09-09T20:10:00.000Z
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

**The Mac's browser is signed in as `tevans`, while the Mac's SSH key is `slaguru666`.** The New Repository form therefore offers only `tevans` as owner, and `?owner=` in the URL does NOT override it — a repo created that way lands under the wrong account and this Mac cannot push to it. Create repos for `slaguru666` while signed in as `slaguru666`. Gitea also has **push-to-create disabled**, and there is no API token on the Mac, so a new repo must exist before the first push.

**`tevans` is a second account on this instance**, separate from `slaguru666` — the Mac's "Mac5" key is `slaguru666` and cannot read `tevans` repos. A **deploy key is scoped to one repository** and Gitea rejects the same key content on a second one, so generate a fresh key per repo. Note `tevans/loom-adventures` is misleadingly named: it holds the `vanity-roller` PWA, not Loom data; Loom backs up to `tevans/loom-data` ([[loom-app]]).

Related: [[ringbrp-project]], [[feedback_semaphore_gitea_url]], [[loom-app]], [[infra-oneoffgames-vps]]
