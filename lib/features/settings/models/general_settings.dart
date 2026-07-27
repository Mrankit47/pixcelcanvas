import 'package:equatable/equatable.dart';

/// App theme mode setting.
enum AppThemeMode { light, dark, system }

/// General application configuration settings per Blueprint §7.4.
class GeneralSettings extends Equatable {
  /// Creates a [GeneralSettings].
  const GeneralSettings({
    this.language = 'en',
    this.themeMode = AppThemeMode.dark,
    this.accentColorHex = '#6C5CE7',
    this.startupPage = 'dashboard',
    this.recentProjectsCount = 10,
    this.defaultProjectFolder = '/projects',
    this.confirmBeforeExit = true,
  });

  final String language;
  final AppThemeMode themeMode;
  final String accentColorHex;
  final String startupPage;
  final int recentProjectsCount;
  final String defaultProjectFolder;
  final bool confirmBeforeExit;

  GeneralSettings copyWith({
    String? language,
    AppThemeMode? themeMode,
    String? accentColorHex,
    String? startupPage,
    int? recentProjectsCount,
    String? defaultProjectFolder,
    bool? confirmBeforeExit,
  }) =>
      GeneralSettings(
        language: language ?? this.language,
        themeMode: themeMode ?? this.themeMode,
        accentColorHex: accentColorHex ?? this.accentColorHex,
        startupPage: startupPage ?? this.startupPage,
        recentProjectsCount: recentProjectsCount ?? this.recentProjectsCount,
        defaultProjectFolder: defaultProjectFolder ?? this.defaultProjectFolder,
        confirmBeforeExit: confirmBeforeExit ?? this.confirmBeforeExit,
      );

  Map<String, dynamic> toJson() => {
        'language': language,
        'themeMode': themeMode.name,
        'accentColorHex': accentColorHex,
        'startupPage': startupPage,
        'recentProjectsCount': recentProjectsCount,
        'defaultProjectFolder': defaultProjectFolder,
        'confirmBeforeExit': confirmBeforeExit,
      };

  factory GeneralSettings.fromJson(Map<String, dynamic> json) => GeneralSettings(
        language: json['language'] ?? 'en',
        themeMode: AppThemeMode.values.firstWhere(
          (m) => m.name == json['themeMode'],
          orElse: () => AppThemeMode.dark,
        ),
        accentColorHex: json['accentColorHex'] ?? '#6C5CE7',
        startupPage: json['startupPage'] ?? 'dashboard',
        recentProjectsCount: json['recentProjectsCount'] ?? 10,
        defaultProjectFolder: json['defaultProjectFolder'] ?? '/projects',
        confirmBeforeExit: json['confirmBeforeExit'] ?? true,
      );

  @override
  List<Object?> get props => [
        language,
        themeMode,
        accentColorHex,
        startupPage,
        recentProjectsCount,
        defaultProjectFolder,
        confirmBeforeExit,
      ];
}
