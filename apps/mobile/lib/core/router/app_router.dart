import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/auth/auth_providers.dart';
import '../../features/alerts/presentation/alerts_page.dart';
import '../../features/auth/presentation/login_page.dart';
import '../../features/map/presentation/map_page.dart';
import '../../features/profile/presentation/profile_page.dart';
import '../../features/report/presentation/report_page.dart';
import '../../features/verify/presentation/verify_page.dart';
import '../l10n/app_strings.dart';
import '../widgets/app_error_view.dart';
import '../widgets/splash_page.dart';

abstract final class Routes {
  static const splash = '/splash';
  static const login = '/login';
  static const map = '/map';
  static const report = '/report';
  static const alerts = '/alerts';
  static const verify = '/verify';
  static const profile = '/profile';

  /// Reserved for AP-052 (FCM deep link); not registered in M1.
  static const incidentPattern = '/incident/:id';

  static String incident(String id) => '/incident/$id';
}

final routerProvider = Provider<GoRouter>((ref) {
  final refresh = ValueNotifier<int>(0);
  ref.listen<AsyncValue<AuthState>>(
    authStateProvider,
    (previous, next) => refresh.value++,
  );
  ref.onDispose(refresh.dispose);

  return GoRouter(
    initialLocation: Routes.splash,
    refreshListenable: refresh,
    redirect: (context, state) {
      final auth = ref.read(authStateProvider);
      final path = state.uri.path;

      if (auth.isLoading) {
        return path == Routes.splash ? null : Routes.splash;
      }

      final signedIn = auth.value is AuthSignedIn;
      if (!signedIn) {
        return path == Routes.login ? null : Routes.login;
      }
      if (path == Routes.login || path == Routes.splash) {
        return Routes.map;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: Routes.splash,
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: Routes.login,
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: Routes.map,
        name: 'map',
        builder: (context, state) => const MapPage(),
      ),
      GoRoute(
        path: Routes.report,
        name: 'report',
        builder: (context, state) => const ReportPage(),
      ),
      GoRoute(
        path: Routes.alerts,
        name: 'alerts',
        builder: (context, state) => const AlertsPage(),
      ),
      GoRoute(
        path: Routes.verify,
        name: 'verify',
        builder: (context, state) => const VerifyPage(),
      ),
      GoRoute(
        path: Routes.profile,
        name: 'profile',
        builder: (context, state) => const ProfilePage(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text(AppStrings.appName)),
      body: AppErrorView(
        message: AppStrings.notFoundTitle,
        onRetry: () => context.go(Routes.map),
        retryLabel: AppStrings.backToMap,
      ),
    ),
  );
});
