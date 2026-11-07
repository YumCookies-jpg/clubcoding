import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app.dart';
import 'core/config/app_config.dart';
import 'core/l10n/app_strings.dart';
import 'data/supabase/supabase_providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final AppConfig config;
  try {
    config = AppConfig.fromEnvironment();
  } on ConfigException catch (error) {
    runApp(
      ConfigErrorApp(
        message: '${error.message}\n\n${AppStrings.configErrorHint}',
      ),
    );
    return;
  }

  await Supabase.initialize(
    url: config.supabaseUrl,
    publishableKey: config.supabaseAnonKey,
  );

  runApp(
    ProviderScope(
      overrides: [
        configProvider.overrideWithValue(config),
        supabaseClientProvider.overrideWithValue(Supabase.instance.client),
      ],
      child: const ApiPantauApp(),
    ),
  );
}
