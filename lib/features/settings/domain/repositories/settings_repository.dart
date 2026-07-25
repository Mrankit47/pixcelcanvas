import 'package:pixelcanvas/core/domain/result.dart';
import 'package:pixelcanvas/features/settings/domain/entities/settings.dart';

/// Contract interface for Settings persistence per Blueprint §6.1 & §17.4.
abstract interface class SettingsRepository {
  /// Gets saved settings entity.
  Future<Result<Settings>> getSettings();

  /// Saves updated settings entity.
  Future<Result<Settings>> saveSettings(Settings settings);
}
