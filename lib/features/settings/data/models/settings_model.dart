import 'package:isar/isar.dart';


/// Isar Local NoSQL Collection for Settings Entity per Blueprint §6.2.
@collection
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

  /// Isar single singleton settings record ID.
  Id id;

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
