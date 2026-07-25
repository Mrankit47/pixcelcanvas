import 'package:equatable/equatable.dart';

/// App Settings Domain Entity per Blueprint §6.1 & §17.4.
class Settings extends Equatable {
  /// Creates a [Settings] domain entity.
  const Settings({
    this.isLightMode = true,
    this.languageCode = 'en',
    this.showGridLines = true,
    this.autoSaveEnabled = true,
    this.animationsEnabled = true,
  });

  /// Light theme flag.
  final bool isLightMode;

  /// Active language locale code.
  final String languageCode;

  /// Grid lines visibility flag.
  final bool showGridLines;

  /// Auto-save enabled flag.
  final bool autoSaveEnabled;

  /// UI Animations enabled flag.
  final bool animationsEnabled;

  @override
  List<Object?> get props => [
        isLightMode,
        languageCode,
        showGridLines,
        autoSaveEnabled,
        animationsEnabled,
      ];
}
