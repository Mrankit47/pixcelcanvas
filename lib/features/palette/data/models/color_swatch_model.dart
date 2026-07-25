import 'package:isar/isar.dart';

part 'color_swatch_model.g.dart';

/// Isar Embedded Object for ColorSwatch Entity per Blueprint §6.2.
@embedded
class ColorSwatchModel {
  /// Creates a [ColorSwatchModel].
  ColorSwatchModel({
    this.name = '',
    this.hexColor = '#000000',
  });

  /// Swatch name label.
  String name;

  /// Hex color string.
  String hexColor;
}
