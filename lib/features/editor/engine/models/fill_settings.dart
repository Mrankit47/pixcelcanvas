import 'package:equatable/equatable.dart';

/// Configuration parameters for Bucket Fill tool per Blueprint §8.1.
class FillSettings extends Equatable {
  /// Creates a [FillSettings].
  const FillSettings({
    this.contiguous = true,
    this.tolerance = 0,
  });

  /// Contiguous fill mode (true) or global canvas fill (false).
  final bool contiguous;

  /// Color matching tolerance percentage (0 = exact match).
  final int tolerance;

  @override
  List<Object?> get props => [contiguous, tolerance];
}
