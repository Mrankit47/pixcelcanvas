import 'package:pixelcanvas/features/palette/data/models/palette_model.dart';

/// Contract for local color palette database operations.
abstract interface class PaletteLocalDataSource {
  /// Gets all saved color palettes.
  Future<List<PaletteModel>> getPalettes();

  /// Saves palette model.
  Future<void> savePalette(PaletteModel palette);
}

/// Pure in-memory implementation of [PaletteLocalDataSource].
class PaletteLocalDataSourceImpl implements PaletteLocalDataSource {
  /// Creates a [PaletteLocalDataSourceImpl].
  PaletteLocalDataSourceImpl(dynamic dbService);

  final List<PaletteModel> _palettes = [];

  @override
  Future<List<PaletteModel>> getPalettes() async {
    return List<PaletteModel>.from(_palettes);
  }

  @override
  Future<void> savePalette(PaletteModel palette) async {
    _palettes.removeWhere((p) => p.uuid == palette.uuid);
    _palettes.add(palette);
  }
}
