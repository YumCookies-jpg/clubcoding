import 'dart:async';
import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/result/app_failure.dart';

/// Single translation point from SDK/network exceptions to UI-safe failures.
AppFailure mapException(Object error) {
  if (error is SocketException || error is TimeoutException) {
    return const NetworkFailure();
  }
  if (error is AuthException) {
    return AuthFailure(error.code ?? error.statusCode ?? 'unknown');
  }
  if (error is PostgrestException) {
    final code = error.code ?? '';
    if (code == '42501') {
      return const PermissionFailure();
    }
    if (code == 'PGRST301') {
      return const AuthFailure('jwt_expired');
    }
    if (code.startsWith('22') || code.startsWith('23') || code == 'PGRST116') {
      return const ValidationFailure();
    }
    return ServerFailure(code.isEmpty ? null : code);
  }
  return const UnknownFailure();
}
