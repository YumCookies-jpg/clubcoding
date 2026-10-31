# ApiPantau — Agent Rules

This repository follows the **Design-Log Methodology** (https://github.com/yoavaa/design-log-methodology).
AI agents and humans follow the same rules: design first, then implement, then append results.

## Before touching code

1. Read `design-log/index.md`, then the design logs relevant to your task.
2. Check `docs/BACKLOG.md` for the task ID (e.g. `AP-020`) and its owner seat.
3. If the task has no approved design log and is `M`/`L` size, **stop and write one** from
   `design-log/template.md`. Do not implement on assumptions.
4. If the design log has open questions, answer them in place (keep the question, add the answer).

## Design log rules

- Path: `design-log/NNNN-kebab-title.md`, numbered sequentially, never reused.
- Required order: **Decisions for the Implementer (TL;DR)** → Background → Problem →
  Prior Art / Adjacent Mechanisms → Questions and Answers → Design → Implementation Plan →
  Examples (✅/❌) → Trade-offs → Verification Criteria.
- Lead with decisions and non-obvious constraints. Thoroughness below, navigability on top.
- Prior art is the author's job: list adjacent mechanisms/logs and say whether each solves or
  constrains the problem.
- Null hypothesis first: for every new API, type, table, or dependency, state why an existing
  primitive does not suffice. Prefer subtraction.
- Trace runtime claims through real code with `file:line` citations. No abstract hand-waving.
- Ask questions inside the file; do not leave them in chat only.
- Add mermaid diagrams when a flow is easier to see than to read.
- Be brief. Include file paths, type signatures, validation rules, and verification criteria.
- Update `design-log/index.md` whenever a log is created or materially revised.

## Implementation rules

- Follow the plan phases in the design log; write tests first where practical.
- **Freeze the Design section** once implementation starts. All deviations go in a new
  `## Implementation Results` section, appended with date, reason, and test output
  (`X/Y passing`).
- Never silently change scope. New scope = new backlog task + design log or an explicit
  descope note approved by the Tech Lead seat.
- Update `docs/BACKLOG.md` status (`Todo → In Progress → Review → Done`) and append the
  result to the design log in the same PR.

## Code conventions

- Monorepo: `apps/mobile` (Flutter/Dart), `apps/admin` (React + TypeScript), `supabase/`
  (SQL migrations + Edge Functions in TypeScript), `docs/`, `design-log/`.
- Dart: `flutter analyze` clean, `dart format` applied, Riverpod for state.
- TypeScript: strict mode, no `any` in committed code without a comment justifying it.
- SQL: migrations only (`supabase/migrations/`), never edit an applied migration. Every new
  table ships with RLS policies in the same migration.
- Secrets never enter the repo. `.env*` is ignored; use `.env.example` for keys.
- Commits: Conventional Commits (`feat:`, `fix:`, `docs:`, `chore:`, `test:`); reference the
  task ID, e.g. `feat(mobile): 1-tap report flow (AP-020)`.

## Definition of Done (per task)

- Acceptance criteria from the PRD and the design log are met and manually verified.
- Tests added/updated and passing; analyze/lint clean.
- Design log `Implementation Results` appended, index updated.
- Reviewer from a different seat has approved the PR.
