# M1 Kickoff — What to hand each seat

Week 1 goal: **login on a real device writes a profile row, map tiles render, both app shells
build, CI blocks a bad PR.** Nothing from M2 starts this week.

Send every seat this first, then their own block.

> **Read in this order (30 min):** `AGENTS.md` → `design-log/index.md` →
> `design-log/0001-project-foundation.md` (approved) → `docs/BACKLOG.md` §M1 →
> `docs/TEAM.md`. Branch naming: `type/AP-NNN-slug`. One task `In Progress` at a time.
> Design log before code for every `M`/`L` task. Append `## Implementation Results` in the
> same PR. Friday 16:00 demo, on a device, from `main`.

---

## TL — Fikri

**Own this week:** AP-001 (close out), AP-007 (CI), approvals, MOB-B staffing.

1. **Today:** assign the vacant **MOB-B** seat. Until it is filled, Sabil covers `AP-009`
   and `AP-011` moves to M2 week 1 (it only gates M3 alerts).
2. **Approve or return:** DL-0002 (draft ready, needs BE review first), DL-0003 (Sabil),
   DL-0004 (Evan), DL-0005 (Anang). Review within 4 working hours.
3. **AP-007 CI gates** once `apps/mobile` and `apps/admin` exist: format, analyze, test,
   `tsc`, eslint. Then turn on branch protection: PR + 1 cross-seat approval + green CI.
4. **Decisions to force:** O4 iOS scope (default: Android only) and O6 OTP/SMS budget
   (default: email OTP + test numbers) by Wednesday.
5. **Friday:** run the M1 demo and post the red/green list; cut scope, do not extend it.

**Needs from others:** BE gives repo env keys by Tue; Sabil/Evan give repo shells by Wed.

---

## BE — Fajri

**Own this week:** AP-002, AP-003, AP-004, AP-012. Backend is the critical path — unblock it first.

1. **Mon:** create the Supabase org/project (`ap-southeast-1`), local config, and the env
   matrix from DL-0001 §Environment matrix. Hand `SUPABASE_URL` + anon key to Sabil and Evan;
   service-role key stays in your password manager / Edge env only.
2. **Mon–Tue:** review the drafted **DL-0002** (`design-log/0002-data-model-and-rls.md`),
   answer Q1–Q8 in place if you disagree, mark it `Approved`.
3. **Tue:** `AP-003` migrations (tables, constraints, GiST indexes) exactly as DL-0002 says.
4. **Wed:** `AP-004` RLS + `verify_report` RPC. Test with the anon key: hotspots readable,
   reports not.
5. **Thu:** `AP-012` FIRMS `MAP_KEY` + one probe call; paste a sample payload into DL-0010
   as a stub so the M3 work is not starting from guesses.
6. **Fri:** `supabase db reset` clean from scratch is your demo proof.

**Needs from TL:** project ownership/billing approval. **Needs from WEB:** none this week.

**Do not** build the FIRMS ingest function or FCM fan-out yet — that is M3.

---

## MOB-A — Sabil

**Own this week:** DL-0003, AP-005, AP-010 (UI half). Absorbs AP-009 if MOB-B stays vacant.

1. **Mon:** write **DL-0003 — Flutter app shell** from the template. Keep it to routing,
   Riverpod, theme, config injection, folder layout, error screen. Get TL approval before
   generating code.
2. **Mon–Tue:** `AP-005` scaffold `apps/mobile` (`org id.clubcoding`, app `apipantau`,
   Android + iOS). Core only: `core/config`, `core/router`, `core/theme`, `features/`
   placeholders. No report/map logic.
3. **Wed–Thu:** `AP-010` phone OTP login UI against Fajri's project: enter phone → OTP →
   profile lands in `profiles`. Coordinate the contract with Fajri (one message, not a meeting).
4. **If MOB-B vacant:** add `AP-009` map base with OSM/Esri tiles (1.5 d), after AP-005.
5. **Fri demo:** log in on a physical Android device, show the profile row in Supabase.

**Needs from BE:** project URL + anon key by Tue, OTP provider decision by Wed.

---

## MOB-B — _vacant (assign before Mon noon)_

**Own this week:** AP-009, AP-011 (or Sabil takes both if the seat stays empty).

1. **Mon:** review DL-0003 once Sabil drafts it; agree on shared `core/` boundaries before
   either of you edits `apps/mobile/lib/core/**`.
2. **AP-009:** map base layer, OSM + Esri World Imagery tiles, attribution, tile cache config,
   one marker for a hardcoded point. Target: map on device < 3 s on 4G.
3. **AP-011:** create the Firebase project, Android app registration, `google-services.json`
   (gitignored), FCM token printed to logs on device. This is a **spike** — no radius logic.
4. **Fri demo:** map pan/zoom on device + a token in the console.

**Needs from BE:** anon key. **Needs from TL:** Firebase project ownership.

---

## WEB — Evan

**Own this week:** DL-0004, AP-006.

1. **Mon:** write **DL-0004 — Admin shell & dashboard architecture**. Decide: routing,
   query layer, auth guard (role `admin` only), RPC-only data access, no service-role key in
   the client. Get TL approval.
2. **Tue–Wed:** `AP-006` scaffold `apps/admin`: Vite + React + TS + Tailwind, Supabase client,
   TanStack Query, login screen, empty dashboard route, error/empty states.
3. **Thu:** wire the login guard against Fajri's project (any non-admin role is rejected).
4. **Fri demo:** sign in as an admin seed user, land on an empty dashboard shell; a `warga`
   account is refused.

**Needs from BE:** anon key + one admin test user. **Do not** start charts or stats RPC —
that is M4 (`AP-070`+).

---

## QA — Anang

**Own this week:** DL-0005, AP-008. You are the design + verification conscience, not a tester
waiting for builds.

1. **Mon–Tue:** write **DL-0005 — UX flows & design tokens** for the four core flows:
   report (≤ 3 steps), map + incident sheet, alert → map, verifier queue. Include the
   permission rationale copy and the "offline sent" state. Tokens: color, type scale, spacing,
   48 dp targets, dark mode.
2. **Wed:** hand Sabil and the MOB-B hire the flow screens/tokens; they should not invent UI.
3. **Thu:** test strategy for M1–M2: what is a widget test vs. integration test vs. manual
   device check; list the first 10 test cases for the report flow.
4. **Thu:** confirm **2 physical Android devices** (Android 8+) and the field-test contact
   plan. Both are M5 risks if left late.
5. **Fri demo:** walk the flows against the built app; file gaps as `AP-1xx` tasks in the
   backlog instead of verbal notes.

**Needs from TL:** which PRD open questions are decided (name, verifier, pilot).

---

## Decisions only you can make right now

| # | Decision | Owner | Needed by | Default if silent |
|---|---|---|---|---|
| 1 | Fill **MOB-B** seat | Fikri | Mon 12:00 | Sabil takes AP-009, AP-011 slips to M2 |
| 2 | Supabase org/project owner + region | Fikri / Fajri | Mon 12:00 | Fajri owns, `ap-southeast-1` |
| 3 | OTP provider budget (SMS vs email) | Fikri | Wed | Email OTP + fixed test numbers |
| 4 | iOS in scope before demo? | Fikri | Wed | Android only, iOS stays buildable |
| 5 | Firebase project owner | Fikri | Wed | MOB-B hire, fallback Sabil |

## Not this week

- No FIRMS ingest function, no clustering, no FCM fan-out (M3).
- No offline queue / drift (M2, `AP-022`).
- No dashboard charts, CSV, audit viewer (M4).
- No P1 features (AI photo, AQI, weather index).
- No direct table writes from mobile for status changes — `verify_report` only.

## Friday M1 exit checklist (demo from `main`)

- [ ] OTP login on a physical Android device → row in `profiles`.
- [ ] Map renders with OSM/Esri tiles on the device.
- [ ] Admin shell loads; non-admin login is refused.
- [ ] `supabase db reset` + seed runs clean from scratch.
- [ ] CI is green on `main` and red on a deliberately broken PR.
- [ ] DL-0002/0003/0004/0005 approved and indexed; results appended.
