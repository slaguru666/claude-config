# Claude — FoundryVTT Development

## Who I am
Tim Evans. I build FoundryVTT game systems and modules for SLA Industries and other games. GitHub: slaguru666. Gitea: `gitea.oneoffgames.net`.

## At the start of every conversation
Search Graphiti for context relevant to the task — call `search_memory_facts` with a query about the current system or feature. If Graphiti is unreachable, say so.

## Communication
- Concise, direct — lead with answer not reasoning
- No emojis unless asked
- Reference file:line when pointing to code

## Working Style
- Smallest correct change; no bundled refactors
- Read existing code first; match existing patterns
- No invented APIs or FoundryVTT APIs not verified in the codebase or docs
- Verify before asserting

## Primary System: zero-engine (SLA Industries)
- Foundry compatibility: v13+ (verified v14.361)
- Single source file: `zero-engine.mjs` (~6500 lines)
- System ID: `zero-engine`
- Version: 1.6.x (active development)
- Actor types: `character` (PC), `npc` — `vehicle` sheet exists but not registered
- Item types: weapon, armor, equipment, ammo, specialty, ebb
- Roll mechanic: Year Zero Engine — Attribute + Skill d6s, success on 6s
- Stress dice: adds banes (1s) to rolls; push costs +1 Stress
- 8 races: human, ebon, brainwaster, stormer, shaktar, wraithraider, frother, vevaphon
- 8 training packages applied at character creation
- Ebb (magic) system: flux resource, discipline-based formulae, catastrophe risk for Brain Wasters
- Vevaphon morph forms with instability table
- 14 status conditions with per-roll dice penalties
- Key modules embedded in system: sla-bpn-dispatch, sla-briefing-desk, sla-gear-cache, sla-npc-director, sla-ops-clock, sla-shift-ledger
- Repo: `https://github.com/slaguru666/zero-engine`

## Other Active Systems/Modules (GitHub: slaguru666)
- `sla-bpn-dispatch`, `sla-briefing-desk`, `sla-gear-cache`, `sla-npc-director`, `sla-ops-clock`, `sla-mothership-compendium`
- `npc-portrait-pack`, `npc-quick-cards`, `scifi-deckplan-generator`, `quick-battlemap-builder`
- `codex-ops-kit` — portable Claude ops kit

## Key Paths (Mac Mini)
- Systems: `~/FoundryVTT/Data/systems/<system-id>/`
- Modules: `~/FoundryVTT/Data/modules/<module-id>/`
- Active world: SLA_Industries

## Foundry Patterns to Follow
- Sheets extend `foundry.appv1.sheets.ActorSheet` / `ItemSheet`
- Data prep in `getData()`, mutations via `actor.update()` / `item.update()`
- Hook registration at module level (not inside classes)
- Handlebars templates in `templates/`; partials registered in `init` hook
- Localisation strings in `lang/en.json`
- Pack data in `packs/*.json`, built via `build-packs.mjs`
