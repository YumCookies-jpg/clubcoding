# ApiPantau — Team & Ownership

Small team, five weeks, one demo. This file says who owns what so tasks do not queue behind
one person. Seats are fixed; names are updated when staffing changes.

## Seats

| Seat | Name | Mandate | Primary paths |
|---|---|---|---|
| **TL** | Fikri | Scope, architecture, CI, cross-seat unblocking, release, pitch | `AGENTS.md`, `.github/`, `design-log/`, `apps/mobile/lib/core/` (review) |
| **MOB-A** | Sabil | Flutter: reporting flow, offline queue, verification UI | `apps/mobile/lib/features/{report,verify}/` |
| **MOB-B** | _TBD_ | Flutter: map, auth UI, push handling, release build | `apps/mobile/lib/features/{auth,map,alerts}/` |
| **BE** | Fajri | Supabase: schema, RLS, RPC, Edge Functions, FIRMS, FCM fan-out | `supabase/` |
| **WEB** | Evan | Admin dashboard, stats queries, CSV, audit views | `apps/admin/` |
| **QA** | Anang | Product design, UX flows, test plans, field test, demo data | `docs/ux/`, `apps/mobile/test/` (review), `supabase/seed.sql` (review) |

Each person has **one accountable seat**. Helping another seat is fine; owning two is not.
Design logs record the author seat, not a name, so seats survive staff changes.

## Ownership of shared surfaces

| Surface | Accountable | Must review changes |
|---|---|---|
| `supabase/migrations/**` | BE | TL (destructive/schema), WEB if dashboard queries affected |
| `supabase/functions/**` | BE | TL |
| `apps/mobile/lib/core/**` | TL | MOB-A, MOB-B |
| `apps/mobile/lib/data/**` | MOB-A | BE (model shape), MOB-B |
| Design log index / template | TL | — |
| `docs/BACKLOG.md` status | task owner | TL (scope changes) |
| `docs/TEAM.md` | TL | all seats |
| Demo script / pitch data | TL | QA, WEB |

## RACI for recurring activities

| Activity | R | A | C | I |
|---|---|---|---|---|
| Weekly scope decision | TL | TL | all seats | — |
| Schema / RLS change | BE | BE | TL, WEB | all |
| Design log review | author | TL | affected seats | — |
| Release APK | MOB-B | TL | QA | all |
| Field test | QA | TL | MOB-A, MOB-B | BE, WEB |
| Demo data & narrative | QA | TL | WEB | all |
| Incident during demo week | TL | TL | BE, MOB-B | all |

## Rituals (keep them short)

| When | Ritual | Output |
|---|---|---|
| Mon 09:00, 30 min | Planning: pick tasks from backlog, confirm deps | Each person has 1 task `In Progress`, WIP limit respected |
| Wed 14:00, 45 min | Design review: next `M`/`L` log | Log approved or returned with questions |
| Fri 16:00, 30 min | Demo on a real device from `main` | Green/red milestone, descope list if red |
| Daily, async | Post: done / next / blocked | Blockers raised within the hour, not at Friday |

## Working agreement

1. **Ask early, in writing.** Questions go into the design log, not a private chat.
2. **No orphan work.** Every branch maps to an `AP-NNN` task; every task has one owner.
3. **Review within 4 working hours.** A PR idle for a day is a delivery risk.
4. **Small PRs.** Target < 400 changed lines; split schema from UI.
5. **Demo-able `main`.** If it cannot be shown Friday, it does not merge half-done.
6. **Cut scope, not quality.** Descope order is pre-agreed in the backlog; the TL announces
   cuts at Friday demo, never silently.
7. **Android is the release target.** iOS builds stay green but do not gate the demo.

## Capacity assumptions

- 5 weeks × 5 days × 6 seats = 150 person-days gross.
- Minus 10% ceremonies/reviews and 10% contingency → **~120 usable person-days**.
- Planned P0 work is ~91 person-days, leaving ~29 days for bugs, field test, and P1 polish.
- One seat may be part-time; if so, cut from the P1 section first, then the pre-agreed
  descope list in `docs/BACKLOG.md`.
