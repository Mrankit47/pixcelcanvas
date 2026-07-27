import 'package:isar/isar.dart';
import 'package:pixelcanvas/core/database/database_service.dart';
import 'package:pixelcanvas/features/palette/data/models/palette_model.dart';

/// Contract for local color palette database operations per Blueprint §6.2.
abstract interface class PaletteLocalDataSource {
  /// Gets all saved color palettes.
  Future<List<PaletteModel>> getPalettes();

  /// Saves palette model.
  Future<void> savePalette(PaletteModel palette);
}

/// Isar Implementation of [PaletteLocalDataSource].
class PaletteLocalDataSourceImpl implements PaletteLocalDataSource {
  /// Creates a [PaletteLocalDataSourceImpl].
  PaletteLocalDataSourceImpl(this._dbService);

  final DatabaseService _dbService;
  final List<PaletteModel> _inMemoryPalettes = [];

  @override
  Future<List<PaletteModel>> getPalettes() async {
    final isar = _dbService.isar;
    if (isar != null) {
      return isar.collection<PaletteModel>().where().findAll();
    }
    return _inMemoryPalettes;
  }

  @override
  Future<void> savePalette(PaletteModel palette) async {
    final isar = _dbService.isar;
    if (isar != null) {
      await isar.writeTxn(() async {
        await isar.collection<PaletteModel>().put(palette);
      });
    } else {
      _inMemoryPalettes.add(palette);
    }
  }
}
