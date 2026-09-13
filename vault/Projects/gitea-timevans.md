---
type: project
status: active
repo: none
path: gitea.timevans.uk
updated: 2026-09-13
---

# Gitea (timevans.uk)

**What it is** — The private Gitea instance used for Loom, RingBRP design work and
backups. A second instance exists at `gitea.oneoffgames.net` — not the same thing.

**Where it lives** — `gitea.timevans.uk`. Git over **SSH on port 2222**, not 22:

```
ssh://git@gitea.timevans.uk:2222/<user>/<repo>.git
```

The authenticating key is `~/.ssh/id_ed25519`, registered as "Mac5". Port 22 answers
but its host key differs and it rejects the key.

**Current state** — In use.

**Next steps** — none.

**Key decisions**
- Use the **SSH remote**, not HTTPS. There is no stored HTTPS credential on this Mac —
  no helper, no keychain token — so an HTTPS push fails with "could not read Username".
- Repos are publicly readable over HTTPS, so Foundry manifest URLs of the form
  `https://gitea.timevans.uk/<user>/<repo>/raw/branch/main/system.json` resolve
  anonymously and work for *Install System → Manifest URL*.

**Gotchas**
- **Two accounts.** The Mac's browser is signed in as `tevans`; the Mac's SSH key is
  `slaguru666`. The New Repository form therefore offers only `tevans` as owner, and
  `?owner=` in the URL does **not** override it — a repo created that way lands under
  the wrong account and this Mac cannot push to it. Create `slaguru666` repos while
  signed in as `slaguru666`.
- **Push-to-create is disabled** and there is no API token on the Mac, so a new repo
  must exist in the web UI before the first push.
- A **deploy key is scoped to one repository**, and Gitea rejects duplicate key
  content — generate a fresh key per repo.
- `tevans/loom-adventures` is misleadingly named: it holds the `vanity-roller` PWA,
  not Loom data. Loom backs up to `tevans/loom-data`.

Related: [[loom]], [[custodians-ringbrp]], [[CONVENTIONS]]
