import 'package:equatable/equatable.dart';

/// Single point sample along a drawing stroke sequence per Blueprint §8.1.
class StrokePoint extends Equatable {
  /// Creates a [StrokePoint].
  const StrokePoint({
    required this.x,
    required this.y,
    this.pressure = 1.0,
    this.timestamp,
  });

  /// X pixel coordinate.
  final int x;

  /// Y pixel coordinate.
  final int y;

  /// Optional pressure value.
  final double pressure;

  /// Sample timestamp.
  final DateTime? timestamp;

  @override
  List<Object?> get props => [x, y, pressure, timestamp];
}
