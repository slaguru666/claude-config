---
name: infra-foundry-pack-manifest-broken
description: A Foundry LevelDB pack whose CURRENT names a MANIFEST that is not on disk cannot be opened at all — decide whether the committed state or the working tree is the broken one before restoring
metadata:
  type: reference
---

A Foundry compendium is a LevelDB directory. `CURRENT` holds the name of the live
`MANIFEST-xxxxxx`. If that file is absent the pack **cannot be opened at all**:

```
LEVEL_DATABASE_NOT_OPEN / IO error: .../MANIFEST-000002: No such file or directory
```

This is a *different* failure from the lock error a running world causes
(`LEVEL_LOCKED: Resource temporarily unavailable`), and it persists with no world running —
so it is easy to misread as "the world is still up". Check `active:false` on
`/api/status` first, then compare `CURRENT` against what is on disk:

```bash
for d in packs/*/; do cur=$(tr -d '\n' < "$d/CURRENT"); \
  [ -f "$d/$cur" ] || echo "$(basename $d): CURRENT=$cur MISSING"; done
```

**Before restoring, establish which copy is broken.** In RingBRP (R-320a) all 23 packs were
broken in the working tree while the *committed* state was consistent (`CURRENT` →
`MANIFEST-000004`, both tracked), caused by a world compacting the packs and being
interrupted. `git checkout -- packs/ && git clean -fd packs/` was then correct. Had the
committed state been the broken one, that same command would have destroyed the only good
copy. `git show "HEAD:packs/<name>/CURRENT"` (braces matter, see
[[feedback-check-the-instrument]]) against `git ls-tree HEAD packs/<name>/` answers it.

**Prove the restore, do not assume it.** A half-consistent LevelDB directory looks identical
to a good one from the outside. Open a few packs and count keys:

```js
const db = new ClassicLevel(`packs/${p}`, { valueEncoding: "json" });
await db.open(); let n = 0; for await (const _ of db.iterator()) n++; await db.close();
```

Note also that packs are build artifacts: `bun run build` rewrites them, and launching a
world compacts all of them, which is where the uncommitted churn in this repo comes from.

Related: [[ringbrp-project]], [[infra-foundry-shutdown-kills-server]].
