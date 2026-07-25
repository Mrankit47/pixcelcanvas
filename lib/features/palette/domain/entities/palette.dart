import 'package:pixelcanvas/core/domain/entity.dart';
import 'package:pixelcanvas/features/palette/domain/entities/color_swatch.dart';

/// Palette Domain Entity per Blueprint §6.1.
///
/// **Purpose**: Represents a curated color palette preset (e.g. DB32, PICO-8).
class Palette extends Entity<String> {
  /// Creates a [Palette] domain entity.
  const Palette({
    required String id,
    required this.name,
    required this.swatches,
    this.isPreset = false,
  }) : super(id);

  /// Palette name label.
  final String name;

  /// Swatches list.
  final List<ColorSwatch> swatches;

  /// True if built-in system preset.
  final bool isPreset;

  @override
  List<Object?> get props => [id, name, swatches, isPreset];
}
