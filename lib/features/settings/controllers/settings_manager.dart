import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/settings/models/appearance_settings.dart';
import 'package:pixelcanvas/features/settings/models/autosave_settings.dart';
import 'package:pixelcanvas/features/settings/models/editor_settings.dart';
import 'package:pixelcanvas/features/settings/models/general_settings.dart';
import 'package:pixelcanvas/features/settings/models/performance_settings.dart';
import 'package:pixelcanvas/features/settings/models/settings_profile.dart';
import 'package:pixelcanvas/features/settings/storage/settings_storage.dart';

/// Central Settings Manager controlling active profile and parameters per Blueprint §7.4.
class SettingsManager extends ChangeNotifier {
  SettingsProfile _activeProfile = const SettingsProfile(
    id: 'default',
    name: 'Default Profile',
  );

  /// Active profile getter.
  SettingsProfile get activeProfile => _activeProfile;

  /// General settings getter.
  GeneralSettings get general => _activeProfile.general;

  /// Appearance settings getter.
  AppearanceSettings get appearance => _activeProfile.appearance;

  /// Editor settings getter.
  EditorSettings get editor => _activeProfile.editor;

  /// Performance settings getter.
  PerformanceSettings get performance => _activeProfile.performance;

  /// Autosave settings getter.
  AutosaveSettings get autosave => _activeProfile.autosave;

  /// Updates general settings.
  void updateGeneral(GeneralSettings newGeneral) {
    _activeProfile = _activeProfile.copyWith(general: newGeneral);
    _saveState();
  }

  /// Updates appearance settings.
  void updateAppearance(AppearanceSettings newAppearance) {
    _activeProfile = _activeProfile.copyWith(appearance: newAppearance);
    _saveState();
  }

  /// Updates editor settings.
  void updateEditor(EditorSettings newEditor) {
    _activeProfile = _activeProfile.copyWith(editor: newEditor);
    _saveState();
  }

  /// Updates performance settings.
  void updatePerformance(PerformanceSettings newPerformance) {
    _activeProfile = _activeProfile.copyWith(performance: newPerformance);
    _saveState();
  }

  /// Updates autosave settings.
  void updateAutosave(AutosaveSettings newAutosave) {
    _activeProfile = _activeProfile.copyWith(autosave: newAutosave);
    _saveState();
  }

  /// Sets entire active profile.
  void setProfile(SettingsProfile profile) {
    _activeProfile = profile;
    _saveState();
  }

  void _saveState() {
    SettingsStorage.saveProfile(_activeProfile);
    notifyListeners();
  }
}
