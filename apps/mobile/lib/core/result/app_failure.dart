import '../l10n/app_strings.dart';

/// Command failures are explicit values; widgets never see SDK exceptions.
sealed class AppFailure {
  const AppFailure(this.message);

  final String message;

  String get debugCode;
}

final class NetworkFailure extends AppFailure {
  const NetworkFailure() : super(AppStrings.failureNetwork);

  @override
  String get debugCode => 'network';
}

final class AuthFailure extends AppFailure {
  const AuthFailure([this.code = 'unknown']) : super(AppStrings.failureAuth);

  final String code;

  @override
  String get debugCode => 'auth:$code';
}

final class PermissionFailure extends AppFailure {
  const PermissionFailure() : super(AppStrings.failurePermission);

  @override
  String get debugCode => 'permission';
}

final class ValidationFailure extends AppFailure {
  const ValidationFailure([this.field]) : super(AppStrings.failureValidation);

  final String? field;

  @override
  String get debugCode => field == null ? 'validation' : 'validation:$field';
}

final class ServerFailure extends AppFailure {
  const ServerFailure([this.code]) : super(AppStrings.failureServer);

  final String? code;

  @override
  String get debugCode => code == null ? 'server' : 'server:$code';
}

final class UnknownFailure extends AppFailure {
  const UnknownFailure() : super(AppStrings.failureUnknown);

  @override
  String get debugCode => 'unknown';
}
