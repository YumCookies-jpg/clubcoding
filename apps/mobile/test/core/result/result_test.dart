import 'package:apipantau/core/result/app_failure.dart';
import 'package:apipantau/core/result/result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Ok folds to the success branch', () {
    const Result<int> result = Ok(7);

    expect(result.isOk, isTrue);
    expect(result.isErr, isFalse);
    expect(result.valueOrNull, 7);
    expect(result.failureOrNull, isNull);
    expect(
      result.fold(
        (value) => 'ok:$value',
        (failure) => 'err:${failure.debugCode}',
      ),
      'ok:7',
    );
  });

  test('Err folds to the failure branch', () {
    const Result<int> result = Err(NetworkFailure());

    expect(result.isOk, isFalse);
    expect(result.isErr, isTrue);
    expect(result.valueOrNull, isNull);
    expect(result.failureOrNull, isA<NetworkFailure>());
    expect(
      result.fold(
        (value) => 'ok:$value',
        (failure) => 'err:${failure.debugCode}',
      ),
      'err:network',
    );
  });
}
