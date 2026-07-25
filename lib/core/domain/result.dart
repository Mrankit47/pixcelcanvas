import 'package:equatable/equatable.dart';
import 'package:pixelcanvas/core/domain/failure.dart';

/// Functional style monad type representing Success or Failure per Blueprint §6.1.
///
/// **Purpose**: Replaces exception throwing with explicit typed return values.
sealed class Result<T> extends Equatable {
  /// Creates a [Result].
  const Result();

  /// True if result is [Success].
  bool get isSuccess => this is Success<T>;

  /// True if result is [FailureResult].
  bool get isFailure => this is FailureResult<T>;

  /// Fold method pattern matching success and failure branches.
  R fold<R>(R Function(T data) onSuccess, R Function(Failure failure) onFailure) {
    return switch (this) {
      Success<T>(:final data) => onSuccess(data),
      FailureResult<T>(:final failure) => onFailure(failure),
    };
  }
}

/// Represents successful operation with payload [data].
final class Success<T> extends Result<T> {
  /// Creates a [Success] result.
  const Success(this.data);

  /// Success payload data.
  final T data;

  @override
  List<Object?> get props => [data];
}

/// Represents failed operation with domain [failure].
final class FailureResult<T> extends Result<T> {
  /// Creates a [FailureResult] with a [Failure].
  const FailureResult(this.failure);

  /// Failure detail.
  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
