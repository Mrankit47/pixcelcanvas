import 'package:equatable/equatable.dart';

/// Base abstract class for immutable Domain Value Objects per Blueprint §6.1.
///
/// **Purpose**: Encapsulates domain value validation and equality.
/// **Parameters**:
/// - [value]: Underlying value of type [T].
///
/// **Future Extension Notes**: Guarantees valid value object instantiation before reaching data layer.
abstract class ValueObject<T> extends Equatable {
  /// Creates a [ValueObject].
  const ValueObject(this.value);

  /// Underlying raw value.
  final T value;

  @override
  List<Object?> get props => [value];

  @override
  String toString() => '$runtimeType($value)';
}
