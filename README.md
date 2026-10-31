# ApiPantau

**Peringatan Dini Kebakaran Hutan & Lahan Berbasis Warga** — a community + satellite early
warning network for Indonesian peat and forest fires.

ApiPantau closes the gap between top-down satellite hotspots (3–24 h latency, false positives)
and the people who see smoke first. Citizens report smoke in seconds; community verifiers
confirm; confirmed incidents trigger radius push alerts — even from areas with poor signal.

> ApiPantau is **not** an emergency service or a replacement for 112/113, BPBD, or official
> government systems. It is a human + satellite sensor network that makes detection faster
> and warnings closer to home.

Product scope: [`docs/PRD-ApiPantau.md`](docs/PRD-ApiPantau.md)

## Status

| | |
|---|---|
| Phase | M1 — Foundation |
| Next milestone | M2 — Reports (offline capture → sync) |
| Backlog | [`docs/BACKLOG.md`](docs/BACKLOG.md) |
| Team & ownership | [`docs/TEAM.md`](docs/TEAM.md) |
| Design decisions | [`design-log/index.md`](design-log/index.md) |

## How we work — Design-Log Methodology

This project follows the [design-log methodology](https://github.com/yoavaa/design-log-methodology):
**read the logs, design in a log, get it approved, then write code, then append results.**

- Agent/human rules: [`AGENTS.md`](AGENTS.md) (Cursor mirror: `.cursor/rules/design-log.mdc`)
- Log index: [`design-log/index.md`](design-log/index.md)
- Template: [`design-log/template.md`](design-log/template.md)

Design → Implement → Append. The Design section is frozen once implementation starts; deviations
are recorded under `## Implementation Results`.

## Planned architecture

| Layer | Choice | Notes |
|---|---|---|
| Mobile | Flutter + Riverpod + `flutter_map` + `drift` | Android first, offline-first reporting |
| Backend | Supabase (Postgres + PostGIS, Auth, Storage, Realtime, Edge Functions, pg_cron) | Geospatial queries and relational data |
| Push | Firebase Cloud Messaging HTTP v1 from an Edge Function | Sent server-side, logged for idempotency |
| Admin | React + Vite + TypeScript + TanStack Query + Recharts | Internal dashboard, static hosting |
| Satellite | NASA FIRMS (VIIRS, MODIS) | Scheduled ingest, dedup, clustering |
| Tiles | OpenStreetMap (base) + Esri World Imagery | No map API key in MVP |

See [Design Log 0001](design-log/0001-project-foundation.md) for the reasoning and constraints.

## Repository layout

```
apps/mobile/      Flutter app (Android first)
apps/admin/       React admin dashboard
supabase/         SQL migrations, Edge Functions, seed data
docs/             PRD, backlog, team charter
design-log/       Indexed design logs — read before coding
```

## Getting started

> The app shells and Supabase project are the first M1 tasks (`AP-005`, `AP-006`, `AP-002`),
> so these commands become available as those land. Nothing below is runnable yet except git.

```powershell
git clone https://github.com/duaempatpct20/clubcoding.git
cd clubcoding

# Mobile (after AP-005)
cd apps/mobile
flutter pub get
flutter run --dart-define=SUPABASE_URL=... --dart-define=SUPABASE_ANON_KEY=...

# Admin (after AP-006)
cd apps/admin
npm install
npm run dev

# Backend (after AP-002)
npx supabase start
npx supabase db reset
```

Configuration comes from environment variables only. Copy `.env.example` → `.env` and never
commit real keys. FIRMS and FCM credentials belong to Edge Functions, not clients.

## Quality gates

| Area | Gate |
|---|---|
| Mobile | `dart format --set-exit-if-changed .`, `flutter analyze`, `flutter test` |
| Admin | `tsc --noEmit`, `eslint`, `vitest` |
| Database | `supabase db reset` applies all migrations cleanly; every table has RLS |
| Process | One cross-seat approval, one `AP-NNN` task per branch, design log updated |

## Contributing

1. Pick a task from [`docs/BACKLOG.md`](docs/BACKLOG.md) that is `Todo` and unblocked.
2. If it is `M`/`L` or touches schema/RLS/auth/ingest/notifications, write the design log first.
3. Branch `feat/AP-NNN-slug`, commit `feat(area): summary (AP-NNN)`.
4. Open a PR, keep it under ~400 lines, request a reviewer from another seat.
5. Append `## Implementation Results` to the design log in the same PR.

## License

MIT — see [`LICENSE`](LICENSE).
