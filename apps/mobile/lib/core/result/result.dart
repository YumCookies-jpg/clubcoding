import 'app_failure.dart';

/// Explicit result for commands and writes. Reads use Riverpod's AsyncValue.
sealed class Result<T> {
  const Result();

  bool get isOk => this is Ok<T>;
  bool get isErr => this is Err<T>;

  T? get valueOrNull => switch (this) {
    Ok<T>(value: final value) => value,
    Err<T>() => null,
  };

  AppFailure? get failureOrNull => switch (this) {
    Ok<T>() => null,
    Err<T>(failure: final failure) => failure,
  };

  R fold<R>(R Function(T value) onOk, R Function(AppFailure failure) onErr) {
    return switch (this) {
      Ok<T>(value: final value) => onOk(value),
      Err<T>(failure: final failure) => onErr(failure),
    };
  }
}

final class Ok<T> extends Result<T> {
  const Ok(this.value);

  final T value;
}

final class Err<T> extends Result<T> {
  const Err(this.failure);

  final AppFailure failure;
}
