import 'package:pixelcanvas/features/export/models/export_format.dart';
import 'package:pixelcanvas/features/export/models/export_preset.dart';

/// Catalog of built-in export presets per Blueprint §7.6.
class BuiltInExportPresets {
  static const List<ExportPreset> defaults = [
    ExportPreset(
      id: 'preset_pixel_perfect',
      name: 'Pixel Perfect (1x PNG)',
      format: ExportFormat.png,
      scaleFactor: 1,
    ),
    ExportPreset(
      id: 'preset_web_2x',
      name: 'Web Optimized (2x WebP)',
      format: ExportFormat.webp,
      scaleFactor: 2,
      quality: 90,
    ),
    ExportPreset(
      id: 'preset_high_res_4x',
      name: 'High-Res Print (4x PNG)',
      format: ExportFormat.png,
      scaleFactor: 4,
    ),
    ExportPreset(
      id: 'preset_sprite_sheet',
      name: 'Game Asset Sprite Sheet',
      format: ExportFormat.spriteSheet,
      scaleFactor: 1,
    ),
    ExportPreset(
      id: 'preset_anim_gif',
      name: 'Animated GIF',
      format: ExportFormat.gif,
      scaleFactor: 2,
      isAnimated: true,
    ),
    ExportPreset(
      id: 'preset_zip_pkg',
      name: 'ZIP Distribution Package',
      format: ExportFormat.zipPackage,
      scaleFactor: 1,
    ),
  ];
}
