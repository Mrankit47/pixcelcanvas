import 'package:pixelcanvas/core/repositories/offline_repository.dart';

/// Palette repository interface contract per Blueprint §6.2.
///
/// Purpose: Manages built-in and user custom color palettes.
/// Responsibilities: Custom palette CRUD, color swatch persistence, and palette import/export.
/// Future Implementation Notes: Concrete implementation `PaletteRepositoryImpl` in `features/palette/data/`.
abstract class PaletteRepository implements OfflineRepository<Map<String, dynamic>, String> {
  /// Fetches default built-in palettes (PICO-8, Game Boy, NES, Cyberpunk, Pastel, etc.).
  Future<List<Map<String, dynamic>>> getBuiltInPalettes();

  /// Saves custom color palette locally.
  Future<Map<String, dynamic>> saveCustomPalette(Map<String, dynamic> palette);
}
