import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../supabase/supabase_providers.dart';

/// Shell-level auth state. It deliberately hides Supabase `Session` from the
/// router and widgets so redirects are testable without a live project.
sealed class AuthState {
  const AuthState();
}

final class AuthSignedOut extends AuthState {
  const AuthSignedOut();
}

final class AuthSignedIn extends AuthState {
  const AuthSignedIn({required this.userId});

  final String userId;
}

final authStateProvider = StreamProvider<AuthState>((ref) async* {
  final client = ref.watch(supabaseClientProvider);
  yield _fromSession(client.auth.currentSession);
  yield* client.auth.onAuthStateChange.map(
    (event) => _fromSession(event.session),
  );
});

AuthState _fromSession(Session? session) {
  if (session == null) return const AuthSignedOut();
  return AuthSignedIn(userId: session.user.id);
}
