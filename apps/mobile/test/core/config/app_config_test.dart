import 'package:apipantau/core/config/app_config.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppConfig.fromValues', () {
    test('accepts a valid configuration', () {
      final config = AppConfig.fromValues(
        env: 'staging',
        supabaseUrl: 'https://demo.supabase.co',
        supabaseAnonKey: 'anon-key',
      );

      expect(config.env, AppEnv.staging);
      expect(Uri.parse(config.supabaseUrl).host, 'demo.supabase.co');
      expect(config.supabaseAnonKey, 'anon-key');
    });

    test('defaults a blank APP_ENV to local', () {
      final config = AppConfig.fromValues(
        env: '',
        supabaseUrl: 'https://demo.supabase.co',
        supabaseAnonKey: 'anon-key',
      );

      expect(config.env, AppEnv.local);
    });

    test('parses APP_ENV case-insensitively', () {
      final config = AppConfig.fromValues(
        env: 'STAGING',
        supabaseUrl: 'https://demo.supabase.co',
        supabaseAnonKey: 'anon-key',
      );

      expect(config.env, AppEnv.staging);
    });

    test('rejects a blank SUPABASE_URL', () {
      expect(
        () => AppConfig.fromValues(
          env: 'local',
          supabaseUrl: '   ',
          supabaseAnonKey: 'anon-key',
        ),
        throwsA(isA<ConfigException>()),
      );
    });

    test('rejects a non-http SUPABASE_URL', () {
      expect(
        () => AppConfig.fromValues(
          env: 'local',
          supabaseUrl: 'ftp://demo.supabase.co',
          supabaseAnonKey: 'anon-key',
        ),
        throwsA(isA<ConfigException>()),
      );
    });

    test('rejects a blank SUPABASE_ANON_KEY', () {
      expect(
        () => AppConfig.fromValues(
          env: 'local',
          supabaseUrl: 'https://demo.supabase.co',
          supabaseAnonKey: '  ',
        ),
        throwsA(isA<ConfigException>()),
      );
    });

    test('rejects an unknown APP_ENV', () {
      expect(
        () => AppConfig.fromValues(
          env: 'production',
          supabaseUrl: 'https://demo.supabase.co',
          supabaseAnonKey: 'anon-key',
        ),
        throwsA(isA<ConfigException>()),
      );
    });

    test('rejects http when APP_ENV is prod', () {
      expect(
        () => AppConfig.fromValues(
          env: 'prod',
          supabaseUrl: 'http://demo.supabase.co',
          supabaseAnonKey: 'anon-key',
        ),
        throwsA(isA<ConfigException>()),
      );
    });
  });
}
