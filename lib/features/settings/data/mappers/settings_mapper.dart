import 'package:pixelcanvas/features/settings/data/models/settings_model.dart';
import 'package:pixelcanvas/features/settings/domain/entities/settings.dart';

/// Bidirectional Mapper between [Settings] domain entity and [SettingsModel] Isar collection.
abstract final class SettingsMapper {
  /// Converts [SettingsModel] to [Settings] domain entity.
  static Settings toDomain(SettingsModel model) => Settings(
        isLightMode: model.isLightMode,
        languageCode: model.languageCode,
        showGridLines: model.showGridLines,
        autoSaveEnabled: model.autoSaveEnabled,
        animationsEnabled: model.animationsEnabled,
      );

  /// Converts [Settings] domain entity to [SettingsModel].
  static SettingsModel fromDomain(Settings entity) => SettingsModel(
        id: 1,
        isLightMode: entity.isLightMode,
        languageCode: entity.languageCode,
        showGridLines: entity.showGridLines,
        autoSaveEnabled: entity.autoSaveEnabled,
        animationsEnabled: entity.animationsEnabled,
      );
}
