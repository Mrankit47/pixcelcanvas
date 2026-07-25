import 'package:pixelcanvas/core/domain/result.dart';
import 'package:pixelcanvas/core/domain/use_case.dart';
import 'package:pixelcanvas/features/settings/domain/entities/settings.dart';
import 'package:pixelcanvas/features/settings/domain/repositories/settings_repository.dart';

/// Concrete Use Case saving application settings per Blueprint §6.1.
class SaveSettings implements UseCase<Settings, Settings> {
  /// Creates a [SaveSettings] usecase.
  const SaveSettings(this._settingsRepository);

  final SettingsRepository _settingsRepository;

  @override
  Future<Result<Settings>> call(Settings params) => _settingsRepository.saveSettings(params);
}
