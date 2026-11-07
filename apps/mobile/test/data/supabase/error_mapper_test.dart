import 'dart:async';
import 'dart:io';

import 'package:apipantau/core/result/app_failure.dart';
import 'package:apipantau/data/supabase/error_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  test('SocketException maps to NetworkFailure', () {
    expect(
      mapException(const SocketException('offline')),
      isA<NetworkFailure>(),
    );
  });

  test('TimeoutException maps to NetworkFailure', () {
    expect(mapException(TimeoutException('slow')), isA<NetworkFailure>());
  });

  test('AuthException maps to AuthFailure with its code', () {
    final failure = mapException(
      const AuthException('invalid', code: 'invalid_otp'),
    );

    expect(failure, isA<AuthFailure>());
    expect((failure as AuthFailure).code, 'invalid_otp');
  });

  test('Postgrest permission code maps to PermissionFailure', () {
    expect(
      mapException(const PostgrestException(message: 'denied', code: '42501')),
      isA<PermissionFailure>(),
    );
  });

  test('Postgrest constraint code maps to ValidationFailure', () {
    expect(
      mapException(
        const PostgrestException(message: 'bad value', code: '23514'),
      ),
      isA<ValidationFailure>(),
    );
  });

  test('Unknown exceptions map to UnknownFailure', () {
    expect(mapException(StateError('boom')), isA<UnknownFailure>());
  });
}
