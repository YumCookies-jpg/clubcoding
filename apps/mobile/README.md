# ApiPantau Mobile

Flutter shell for the ApiPantau field app (community + satellite fire early warning).
M1 scope: boot/config, routing, Riverpod state, theme tokens, and placeholder screens.
The map, offline queue, FCM, and report capture land in later tasks (AP-009, AP-022,
AP-011, AP-020).

## Prerequisites

- Flutter stable with Dart SDK `^3.12.0`
- Android SDK for the debug APK (`minSdk 26`)

## Run

```powershell
flutter pub get
flutter run `
  --dart-define=APP_ENV=local `
  --dart-define=SUPABASE_URL=https://<project>.supabase.co `
  --dart-define=SUPABASE_ANON_KEY=<publishable-anon-key>
```

`APP_ENV` is one of `local`, `staging`, `prod` and defaults to `local`.
`SUPABASE_URL` and `SUPABASE_ANON_KEY` are required. When either is missing or invalid
the app shows a configuration-error screen naming the missing values instead of
starting against the wrong backend.

## Quality gates

```powershell
flutter analyze
dart format --set-exit-if-changed lib test
flutter test
flutter build apk --debug
```

Expected M1 boot behavior:

- no session -> login placeholder;
- session -> map placeholder;
- auth state loading -> splash;
- invalid config -> configuration-error screen.

## Layout

```
lib/
├─ core/      config, router, theme, strings, Result/AppFailure, shared widgets
├─ data/      Supabase client provider, auth state, error mapping
└─ features/  auth, map, report, alerts, verify, profile (placeholders in M1)
```

Import rule: `features/*` may import `core` and `data`; `data` may import `core`;
only `core/router` (the composition root) may import feature pages.
