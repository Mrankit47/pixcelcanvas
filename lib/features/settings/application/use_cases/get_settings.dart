import 'package:pixelcanvas/core/domain/result.dart';
import 'package:pixelcanvas/core/domain/use_case.dart';
import 'package:pixelcanvas/features/settings/domain/entities/settings.dart';
import 'package:pixelcanvas/features/settings/domain/repositories/settings_repository.dart';

/// Concrete Use Case retrieving application settings per Blueprint §6.1.
class GetSettings implements UseCase<NoParams, Settings> {
  /// Creates a [GetSettings] usecase.
  const GetSettings(this._settingsRepository);

  final SettingsRepository _settingsRepository;

  @override
  Future<Result<Settings>> call(NoParams params) => _settingsRepository.getSettings();
}
