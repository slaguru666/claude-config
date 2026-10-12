---
name: infra-mac-gh-credential-helper
description: On the Mac, git gets GitHub credentials from gh; gh was missing once and every HTTPS push died — resolved 2026-10-12 by brew install gh, and the token was already in the keyring
metadata:
  type: reference
---

`~/.gitconfig` sets, for both `https://github.com` and `https://gist.github.com`:

    helper = !/opt/homebrew/bin/gh auth git-credential

**Resolved 12 October 2026: `brew install gh` (2.102.0).** The binary was simply absent while
the config still pointed at it, so every HTTPS push to GitHub died with
`could not read Username for 'https://github.com': Device not configured` — including the
push at the end of `~/Git/claude-config/sync.sh`, which committed the vault locally and
silently failed to publish it.

**The login survived the missing binary.** `gh auth status` came back already logged in as
`slaguru666` from the keyring, scopes `gist, read:org, repo, workflow`. **No re-auth was
needed and none should be offered** — if this breaks again, check whether the binary exists
before assuming the credential is gone.

If `gh` is ever missing again and installing it is not wanted, this pushes without touching
`~/.gitconfig`, because the credential is also in the keychain:

    git -c credential."https://github.com".helper=osxkeychain push origin main

Gitea remotes are unaffected: they use SSH on port 2222 ([[infra-gitea-timevans]]).
Relevant whenever a session ends with [[project_plugin_sync]]'s sync.sh.
