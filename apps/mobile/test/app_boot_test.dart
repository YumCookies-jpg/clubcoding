import 'package:apipantau/app.dart';
import 'package:apipantau/core/l10n/app_strings.dart';
import 'package:apipantau/data/auth/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _appFor(AuthState auth) {
  return ProviderScope(
    overrides: [
      authStateProvider.overrideWithValue(AsyncData<AuthState>(auth)),
    ],
    child: const ApiPantauApp(),
  );
}

void main() {
  testWidgets('signed-out user is redirected to login', (tester) async {
    await tester.pumpWidget(_appFor(const AuthSignedOut()));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.loginPlaceholder), findsOneWidget);
  });

  testWidgets('signed-in user lands on the map placeholder', (tester) async {
    await tester.pumpWidget(_appFor(const AuthSignedIn(userId: 'test-user')));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.mapPlaceholder), findsOneWidget);
  });

  testWidgets('loading state shows the splash page', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authStateProvider.overrideWithValue(const AsyncLoading<AuthState>()),
        ],
        child: const ApiPantauApp(),
      ),
    );
    await tester.pump();

    expect(find.text(AppStrings.splashTitle), findsOneWidget);
  });

  testWidgets('configuration error screen is actionable', (tester) async {
    await tester.pumpWidget(
      const ConfigErrorApp(message: 'SUPABASE_URL tidak valid'),
    );
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.configErrorTitle), findsOneWidget);
    expect(find.text('SUPABASE_URL tidak valid'), findsOneWidget);
  });
}
