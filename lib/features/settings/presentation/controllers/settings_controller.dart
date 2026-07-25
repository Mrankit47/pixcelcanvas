import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixelcanvas/core/di/use_case_providers.dart';
import 'package:pixelcanvas/core/domain/use_case.dart';
import 'package:pixelcanvas/features/settings/application/use_cases/get_settings.dart';
import 'package:pixelcanvas/features/settings/application/use_cases/save_settings.dart';
import 'package:pixelcanvas/features/settings/domain/entities/settings.dart';
import 'package:pixelcanvas/features/settings/presentation/state/settings_state.dart';

/// Riverpod Controller managing Settings presentation state per Blueprint §6.3.
class SettingsController extends StateNotifier<SettingsState> {
  /// Creates a [SettingsController].
  SettingsController({
    required GetSettings getSettings,
    required SaveSettings saveSettings,
  })  : _getSettings = getSettings,
        _saveSettings = saveSettings,
        super(const SettingsState());

  final GetSettings _getSettings;
  final SaveSettings _saveSettings;

  /// Loads saved settings.
  Future<void> loadSettings() async {
    state = state.copyWith(isLoading: true, errorMessage: () => null);
    final result = await _getSettings(const NoParams());
    result.fold(
      (settings) => state = state.copyWith(settings: settings, isLoading: false),
      (failure) => state = state.copyWith(isLoading: false, errorMessage: () => failure.message),
    );
  }

  /// Saves updated settings.
  Future<void> saveSettings(Settings settings) async {
    state = state.copyWith(isLoading: true, errorMessage: () => null);
    final result = await _saveSettings(settings);
    result.fold(
      (updated) => state = state.copyWith(settings: updated, isLoading: false),
      (failure) => state = state.copyWith(isLoading: false, errorMessage: () => failure.message),
    );
  }
}

/// Riverpod provider for [SettingsController].
final settingsControllerProvider = StateNotifierProvider<SettingsController, SettingsState>((ref) {
  return SettingsController(
    getSettings: ref.watch(getSettingsProvider),
    saveSettings: ref.watch(saveSettingsProvider),
  );
});
