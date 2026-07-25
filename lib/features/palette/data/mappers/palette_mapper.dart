import 'package:pixelcanvas/core/domain/value_objects/domain_values.dart';
import 'package:pixelcanvas/features/palette/data/models/color_swatch_model.dart';
import 'package:pixelcanvas/features/palette/data/models/palette_model.dart';
import 'package:pixelcanvas/features/palette/domain/entities/color_swatch.dart';
import 'package:pixelcanvas/features/palette/domain/entities/palette.dart';

/// Bidirectional Mapper between [Palette] domain entity and [PaletteModel] Isar collection.
abstract final class PaletteMapper {
  /// Converts [PaletteModel] to [Palette] domain entity.
  static Palette toDomain(PaletteModel model) => Palette(
        id: model.uuid,
        name: model.name,
        swatches: model.swatches.map((s) => ColorSwatch(name: s.name, color: HexColor(s.hexColor))).toList(),
        isPreset: model.isPreset,
      );

  /// Converts [Palette] domain entity to [PaletteModel].
  static PaletteModel fromDomain(Palette entity) => PaletteModel(
        uuid: entity.id,
        name: entity.name,
        swatches: entity.swatches.map((s) => ColorSwatchModel(name: s.name, hexColor: s.color.value)).toList(),
        isPreset: entity.isPreset,
      );
}
