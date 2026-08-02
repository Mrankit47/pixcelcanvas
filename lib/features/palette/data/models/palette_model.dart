import 'package:pixelcanvas/features/palette/data/models/color_swatch_model.dart';

/// Local Data Model for Palette Entity.
class PaletteModel {
  /// Creates a [PaletteModel].
  PaletteModel({
    this.uuid = '',
    this.name = '',
    this.swatches = const [],
    this.isPreset = false,
  });

  /// Unique UUID index.
  String uuid;

  /// Palette name.
  String name;

  /// Embedded swatches list.
  List<ColorSwatchModel> swatches;

  /// Preset flag.
  bool isPreset;
}
