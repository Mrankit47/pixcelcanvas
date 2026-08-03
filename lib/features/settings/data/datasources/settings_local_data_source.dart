import 'package:pixelcanvas/features/settings/data/models/settings_model.dart';

/// Contract for local settings database operations.
abstract interface class SettingsLocalDataSource {
  /// Gets saved settings model or default.
  Future<SettingsModel> getSettings();

  /// Saves settings model.
  Future<void> saveSettings(SettingsModel settings);
}

/// Pure in-memory implementation of [SettingsLocalDataSource].
class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  /// Creates a [SettingsLocalDataSourceImpl].
  SettingsLocalDataSourceImpl(dynamic dbService);

  SettingsModel? _settings;

  @override
  Future<SettingsModel> getSettings() async {
    return _settings ?? SettingsModel();
  }

  @override
  Future<void> saveSettings(SettingsModel settings) async {
    settings.id = 1;
    _settings = settings;
  }
}
