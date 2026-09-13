---
type: project
status: complete
repo: none — not in git
path: ~/haunt
updated: 2026-09-13
---

# Haunt

**What it is** — A generative horror ambience machine, mirroring [[esper]]'s
six-panel architecture. Single file, Web Audio, no deps (~770 lines). Built
2026-08-22.

**Where it lives** — `~/haunt/index.html`, launch config `haunt`, port **8767**.
Hosted at `https://web.oneoffgames.com/sound/haunt.html` ([[oneoffgames-vps]]).

**Current state** — Complete. 14 scenes (asylum, woods, house, boiler, ritual,
cosmic, hospital, ship, cornfield, crypt, station, cabin, carnival, numbers).
Master params: tension — which drives everything — plus pulse, key, scale,
dissonance, darkness, proximity. 36 synthesised layers including whispers, breathing,
footsteps, creaks, knocks, chains, crows, wolves, a numbers-station voice, screams,
Shepard tone, reverse swells, stingers. Conductor: tension arc → jump scare (silence
gain node → stinger, then flash), evolve, journey, 16 cues. State in `haunt-v1`.

**Next steps** — none.

**Key decisions**
- Not in git. Ask before creating a repo.

**Gotchas**
- The three earliest apps share helper code **by copy** — port fixes across.
- Test in batches under ~25 s.

Related: [[drift]], [[esper]], [[grimoire]], [[nexus]]
