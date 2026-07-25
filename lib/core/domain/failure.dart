import 'package:equatable/equatable.dart';

/// Sealed base class for domain failures per Blueprint §6.1 & §15.2.
///
/// **Purpose**: Represents explicit typed failures returned by repositories and use cases.
sealed class Failure extends Equatable {
  /// Creates a [Failure].
  const Failure(this.message, [this.cause]);

  /// User-friendly error message.
  final String message;

  /// Underlying root cause or exception.
  final Object? cause;

  @override
  List<Object?> get props => [message, cause];
}

/// Authentication failure (invalid credentials, expired token, unauthorized).
final class AuthenticationFailure extends Failure {
  /// Creates an [AuthenticationFailure].
  const AuthenticationFailure(super.message, [super.cause]);
}

/// Validation failure (invalid input, out-of-bounds coordinate, invalid hex).
final class ValidationFailure extends Failure {
  /// Creates a [ValidationFailure].
  const ValidationFailure(super.message, [super.cause]);
}

/// Network failure (no internet, timeout, server 5xx error).
final class NetworkFailure extends Failure {
  /// Creates a [NetworkFailure].
  const NetworkFailure(super.message, [super.cause]);
}

/// Local storage failure (Isar DB error, disk full, secure storage failure).
final class StorageFailure extends Failure {
  /// Creates a [StorageFailure].
  const StorageFailure(super.message, [super.cause]);
}

/// Unknown unhandled failure.
final class UnknownFailure extends Failure {
  /// Creates an [UnknownFailure].
  const UnknownFailure(super.message, [super.cause]);
}
