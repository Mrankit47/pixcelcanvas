import 'package:pixelcanvas/core/domain/failure.dart';
import 'package:pixelcanvas/core/domain/result.dart';
import 'package:pixelcanvas/features/settings/data/datasources/settings_local_data_source.dart';
import 'package:pixelcanvas/features/settings/data/mappers/settings_mapper.dart';
import 'package:pixelcanvas/features/settings/domain/entities/settings.dart';
import 'package:pixelcanvas/features/settings/domain/repositories/settings_repository.dart';

/// Implementation of [SettingsRepository] domain contract per Blueprint §6.2.
class SettingsRepositoryImpl implements SettingsRepository {
  /// Creates a [SettingsRepositoryImpl].
  SettingsRepositoryImpl(this._localDataSource);

  final SettingsLocalDataSource _localDataSource;

  @override
  Future<Result<Settings>> getSettings() async {
    try {
      final model = await _localDataSource.getSettings();
      return Success(SettingsMapper.toDomain(model));
    } catch (e) {
      return FailureResult(StorageFailure('Failed to load settings', e));
    }
  }

  @override
  Future<Result<Settings>> saveSettings(Settings settings) async {
    try {
      final model = SettingsMapper.fromDomain(settings);
      await _localDataSource.saveSettings(model);
      return Success(settings);
    } catch (e) {
      return FailureResult(StorageFailure('Failed to save settings', e));
    }
  }
}
