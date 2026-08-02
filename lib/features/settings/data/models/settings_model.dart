/// Local Data Model for Settings Entity.
class SettingsModel {
  /// Creates a [SettingsModel].
  SettingsModel({
    this.id = 1,
    this.isLightMode = true,
    this.languageCode = 'en',
    this.showGridLines = true,
    this.autoSaveEnabled = true,
    this.animationsEnabled = true,
  });

  /// Settings ID.
  int id;

  /// Light mode flag.
  bool isLightMode;

  /// Language code.
  String languageCode;

  /// Show grid lines flag.
  bool showGridLines;

  /// Auto save flag.
  bool autoSaveEnabled;

  /// Micro-animations flag.
  bool animationsEnabled;
}
