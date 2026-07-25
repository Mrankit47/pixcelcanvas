import 'package:isar/isar.dart';
import 'package:pixelcanvas/core/database/isar_id_generator.dart';
import 'package:pixelcanvas/features/palette/data/models/color_swatch_model.dart';

part 'palette_model.g.dart';

/// Isar Local NoSQL Collection for Palette Entity per Blueprint §6.2.
@collection
class PaletteModel {
  /// Creates a [PaletteModel].
  PaletteModel({
    this.uuid = '',
    this.name = '',
    this.swatches = const [],
    this.isPreset = false,
  });

  /// Isar primary key.
  Id get id => fastHash(uuid);

  /// Unique UUID index.
  @Index(unique: true, replace: true)
  String uuid;

  /// Palette name.
  String name;

  /// Embedded swatches list.
  List<ColorSwatchModel> swatches;

  /// Preset flag.
  bool isPreset;
}
