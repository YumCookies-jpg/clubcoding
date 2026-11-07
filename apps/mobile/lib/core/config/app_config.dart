import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Build-time environment label. It is a label, never inferred from the URL.
enum AppEnv {
  local('local'),
  staging('staging'),
  prod('prod');

  const AppEnv(this.value);

  final String value;

  static AppEnv parse(String raw) {
    final normalized = raw.trim().toLowerCase();
    if (normalized.isEmpty) return AppEnv.local;
    for (final env in AppEnv.values) {
      if (env.value == normalized) return env;
    }
    throw ConfigException(
      'APP_ENV "$raw" tidak dikenal. Gunakan local, staging, atau prod.',
    );
  }
}

class ConfigException implements Exception {
  const ConfigException(this.message);

  final String message;

  @override
  String toString() => 'ConfigException: $message';
}

@immutable
class AppConfig {
  const AppConfig({
    required this.env,
    required this.supabaseUrl,
    required this.supabaseAnonKey,
  });

  factory AppConfig.fromEnvironment() {
    return AppConfig.fromValues(
      env: const String.fromEnvironment('APP_ENV'),
      supabaseUrl: const String.fromEnvironment('SUPABASE_URL'),
      supabaseAnonKey: const String.fromEnvironment('SUPABASE_ANON_KEY'),
    );
  }

  factory AppConfig.fromValues({
    required String env,
    required String supabaseUrl,
    required String supabaseAnonKey,
  }) {
    final parsedEnv = AppEnv.parse(env);
    final uri = Uri.tryParse(supabaseUrl.trim());
    if (uri == null ||
        !uri.isAbsolute ||
        (uri.scheme != 'https' && uri.scheme != 'http') ||
        uri.host.isEmpty) {
      throw const ConfigException(
        'SUPABASE_URL tidak valid. Set dengan '
        '--dart-define=SUPABASE_URL=https://<project>.supabase.co',
      );
    }
    if (parsedEnv == AppEnv.prod && uri.scheme != 'https') {
      throw const ConfigException(
        'SUPABASE_URL harus https pada APP_ENV=prod.',
      );
    }
    final trimmedKey = supabaseAnonKey.trim();
    if (trimmedKey.isEmpty) {
      throw const ConfigException(
        'SUPABASE_ANON_KEY kosong. Set dengan '
        '--dart-define=SUPABASE_ANON_KEY=<anon-key>',
      );
    }
    return AppConfig(
      env: parsedEnv,
      supabaseUrl: uri.toString(),
      supabaseAnonKey: trimmedKey,
    );
  }

  final AppEnv env;
  final String supabaseUrl;
  final String supabaseAnonKey;

  bool get isProduction => env == AppEnv.prod;
}

/// Overridden with the resolved config in `main()`.
final configProvider = Provider<AppConfig>((ref) {
  throw StateError('configProvider must be overridden in main().');
});
