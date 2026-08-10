import 'package:equatable/equatable.dart';

/// Appearance and UI layout preferences.
class AppearanceSettings extends Equatable {
  /// Creates an [AppearanceSettings].
  const AppearanceSettings({
    this.uiScale = 1.0,
    this.compactMode = false,
    this.sidebarWidth = 280.0,
    this.showStatusBar = true,
    this.enableAnimations = true,
  });

  final double uiScale;
  final bool compactMode;
  final double sidebarWidth;
  final bool showStatusBar;
  final bool enableAnimations;

  AppearanceSettings copyWith({
    double? uiScale,
    bool? compactMode,
    double? sidebarWidth,
    bool? showStatusBar,
    bool? enableAnimations,
  }) =>
      AppearanceSettings(
        uiScale: uiScale ?? this.uiScale,
        compactMode: compactMode ?? this.compactMode,
        sidebarWidth: sidebarWidth ?? this.sidebarWidth,
        showStatusBar: showStatusBar ?? this.showStatusBar,
        enableAnimations: enableAnimations ?? this.enableAnimations,
      );

  Map<String, dynamic> toJson() => {
        'uiScale': uiScale,
        'compactMode': compactMode,
        'sidebarWidth': sidebarWidth,
        'showStatusBar': showStatusBar,
        'enableAnimations': enableAnimations,
      };

  factory AppearanceSettings.fromJson(Map<String, dynamic> json) => AppearanceSettings(
        uiScale: (json['uiScale'] as num?)?.toDouble() ?? 1.0,
        compactMode: (json['compactMode'] as bool?) ?? false,
        sidebarWidth: (json['sidebarWidth'] as num?)?.toDouble() ?? 280.0,
        showStatusBar: (json['showStatusBar'] as bool?) ?? true,
        enableAnimations: (json['enableAnimations'] as bool?) ?? true,
      );

  @override
  List<Object?> get props => [
        uiScale,
        compactMode,
        sidebarWidth,
        showStatusBar,
        enableAnimations,
      ];
}
