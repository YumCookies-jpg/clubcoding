# Design Log Index

Read this before any work. Then read the logs relevant to your task.

Status: `Proposed` (awaiting review) · `Approved` (implementation may start) ·
`Implementing` · `Done` · `Superseded` · `Planned` (number reserved, not written yet).

## Foundation

| # | Title | Status | Owner | Description |
|---|-------|--------|-------|-------------|
| 0001 | [Project Foundation & Delivery Setup](0001-project-foundation.md) | Approved | TL | Monorepo layout, stack lock, environments, branching, design-log adoption |

## Data & Backend

| # | Title | Status | Owner | Description |
|---|-------|--------|-------|-------------|
| 0002 | [Data model, PostGIS schema & RLS](0002-data-model-and-rls.md) | Proposed | BE | `AP-003`/`AP-004`; basis in PRD §12 |
| 0010 | FIRMS ingest & incident clustering | Planned | BE | `AP-040`–`AP-042`; dedup key, schedule, DBSCAN |
| 0011 | Radius notification fan-out | Planned | BE | `AP-050`–`AP-051`; FCM v1, reach query, idempotency |

## Mobile

| # | Title | Status | Owner | Description |
|---|-------|--------|-------|-------------|
| 0003 | Flutter app shell & state conventions | Planned | MOB-A | `AP-005`; routing, Riverpod, config injection |
| 0005 | UX flows & design tokens | Planned | QA | `AP-008`; report/map/alerts/verify flows |
| 0006 | Auth & role model | Planned | MOB-A / BE | `AP-010`; OTP, profile bootstrap, role claim |
| 0007 | 1-tap report flow | Planned | MOB-A | `AP-020`–`AP-021`; capture, compression, EXIF |
| 0008 | Offline queue & sync engine | Planned | MOB-A | `AP-022`; drift, retry/backoff, conflict rules |
| 0009 | Map layers & clustering | Planned | MOB-B | `AP-030`–`AP-033`; layers, bbox, confidence UI |

## Verification

| # | Title | Status | Owner | Description |
|---|-------|--------|-------|-------------|
| 0012 | Verification queue & audit trail | Planned | MOB-A / BE | `AP-060`–`AP-062`; actions, attribution, double confirm |

## Admin

| # | Title | Status | Owner | Description |
|---|-------|--------|-------|-------------|
| 0004 | Admin shell & dashboard architecture | Planned | WEB | `AP-006`, `AP-070`–`AP-075`; stats RPC, role guard, export |
