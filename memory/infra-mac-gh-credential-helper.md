---
name: infra-mac-gh-credential-helper
description: On the Mac, ~/.gitconfig points GitHub credentials at a missing /opt/homebrew/bin/gh, so any HTTPS push to GitHub (including sync.sh's) fails until overridden
metadata:
  type: reference
---

`~/.gitconfig` sets, for both `https://github.com` and `https://gist.github.com`:

    helper = !/opt/homebrew/bin/gh auth git-credential

That binary does not exist on the Mac (`which gh` → not found), so every HTTPS push to
GitHub dies with `could not read Username for 'https://github.com': Device not configured`
— including the push at the end of `~/Git/claude-config/sync.sh`, which therefore commits
the vault locally and silently fails to publish it.

The credential is in the keychain, so this pushes without changing anything:

    git -c credential."https://github.com".helper=osxkeychain push origin main

The `gh auth git-credential` errors still print; they are not fatal once osxkeychain
answers. The real fix is Tim's to make — install `gh`, or point the helper at osxkeychain
in `~/.gitconfig` — so don't edit that file unasked.

Gitea remotes are unaffected: they use SSH on port 2222 ([[infra-gitea-timevans]]).
Relevant whenever a session ends with [[project_plugin_sync]]'s sync.sh.
