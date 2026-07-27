import 'package:equatable/equatable.dart';

/// Autosave and session recovery configurations.
class AutosaveSettings extends Equatable {
  /// Creates an [AutosaveSettings].
  const AutosaveSettings({
    this.enableAutosave = true,
    this.intervalMinutes = 5,
    this.maxBackupFiles = 10,
    this.restoreLastSession = true,
  });

  final bool enableAutosave;
  final int intervalMinutes;
  final int maxBackupFiles;
  final bool restoreLastSession;

  AutosaveSettings copyWith({
    bool? enableAutosave,
    int? intervalMinutes,
    int? maxBackupFiles,
    bool? restoreLastSession,
  }) =>
      AutosaveSettings(
        enableAutosave: enableAutosave ?? this.enableAutosave,
        intervalMinutes: intervalMinutes ?? this.intervalMinutes,
        maxBackupFiles: maxBackupFiles ?? this.maxBackupFiles,
        restoreLastSession: restoreLastSession ?? this.restoreLastSession,
      );

  Map<String, dynamic> toJson() => {
        'enableAutosave': enableAutosave,
        'intervalMinutes': intervalMinutes,
        'maxBackupFiles': maxBackupFiles,
        'restoreLastSession': restoreLastSession,
      };

  factory AutosaveSettings.fromJson(Map<String, dynamic> json) => AutosaveSettings(
        enableAutosave: json['enableAutosave'] ?? true,
        intervalMinutes: json['intervalMinutes'] ?? 5,
        maxBackupFiles: json['maxBackupFiles'] ?? 10,
        restoreLastSession: json['restoreLastSession'] ?? true,
      );

  @override
  List<Object?> get props => [
        enableAutosave,
        intervalMinutes,
        maxBackupFiles,
        restoreLastSession,
      ];
}
