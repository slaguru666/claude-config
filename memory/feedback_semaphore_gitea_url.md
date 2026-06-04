---
name: feedback-semaphore-gitea-url
description: "Use internal Docker URL for Gitea repos in Semaphore, not the external Cloudflare URL"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: bf7ab50e-b2d9-4f81-b9b7-dd67fcc3a10b
---

When configuring Gitea repositories inside Semaphore, use `http://gitea:3000/tevans/<repo>.git` instead of `https://gitea.oneoffgames.net/tevans/<repo>.git`.

**Why:** Semaphore runs in Docker on the same host as Gitea. The internal container hostname `gitea` resolves directly and avoids Cloudflare DNS/SSL overhead and potential routing issues.

**How to apply:** Any time a Semaphore repository URL needs to be set or updated, default to the `http://gitea:3000/` base URL.
