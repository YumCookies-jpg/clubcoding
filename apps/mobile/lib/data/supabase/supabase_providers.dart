import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Overridden with the initialized client in `main()`, so widget tests can
/// run without a live Supabase project.
final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  throw StateError('supabaseClientProvider must be overridden in main().');
});
