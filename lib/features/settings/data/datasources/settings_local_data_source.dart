import 'package:isar/isar.dart';
import 'package:pixelcanvas/core/database/database_service.dart';
import 'package:pixelcanvas/features/settings/data/models/settings_model.dart';

/// Contract for local settings database operations per Blueprint §6.2.
abstract interface class SettingsLocalDataSource {
  /// Gets saved settings model or default.
  Future<SettingsModel> getSettings();

  /// Saves settings model.
  Future<void> saveSettings(SettingsModel settings);
}

/// Isar Implementation of [SettingsLocalDataSource].
class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  /// Creates a [SettingsLocalDataSourceImpl].
  SettingsLocalDataSourceImpl(this._dbService);

  final DatabaseService _dbService;

  @override
  Future<SettingsModel> getSettings() async {
    final model = await _dbService.isar.settingsModels.get(1);
    return model ?? SettingsModel();
  }

  @override
  Future<void> saveSettings(SettingsModel settings) async {
    settings.id = 1;
    await _dbService.isar.writeTxn(() async {
      await _dbService.isar.settingsModels.put(settings);
    });
  }
}
