import 'package:equatable/equatable.dart';
import 'package:pixelcanvas/core/domain/value_objects/domain_values.dart';

/// Color Swatch domain value entity per Blueprint §6.1.
///
/// **Purpose**: Represents a single color entry within a palette.
class ColorSwatch extends Equatable {
  /// Creates a [ColorSwatch].
  const ColorSwatch({
    required this.name,
    required this.color,
  });

  /// Swatch name label.
  final String name;

  /// Hex color value object.
  final HexColor color;

  @override
  List<Object?> get props => [name, color];
}
