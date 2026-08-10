import 'package:equatable/equatable.dart';

/// Performance and RAM cache settings.
class PerformanceSettings extends Equatable {
  /// Creates a [PerformanceSettings].
  const PerformanceSettings({
    this.thumbnailCacheLimitMb = 64,
    this.memoryCacheLimitMb = 256,
    this.maxAnimationFps = 60,
    this.enableHardwareAcceleration = true,
  });

  final int thumbnailCacheLimitMb;
  final int memoryCacheLimitMb;
  final int maxAnimationFps;
  final bool enableHardwareAcceleration;

  PerformanceSettings copyWith({
    int? thumbnailCacheLimitMb,
    int? memoryCacheLimitMb,
    int? maxAnimationFps,
    bool? enableHardwareAcceleration,
  }) =>
      PerformanceSettings(
        thumbnailCacheLimitMb: thumbnailCacheLimitMb ?? this.thumbnailCacheLimitMb,
        memoryCacheLimitMb: memoryCacheLimitMb ?? this.memoryCacheLimitMb,
        maxAnimationFps: maxAnimationFps ?? this.maxAnimationFps,
        enableHardwareAcceleration: enableHardwareAcceleration ?? this.enableHardwareAcceleration,
      );

  Map<String, dynamic> toJson() => {
        'thumbnailCacheLimitMb': thumbnailCacheLimitMb,
        'memoryCacheLimitMb': memoryCacheLimitMb,
        'maxAnimationFps': maxAnimationFps,
        'enableHardwareAcceleration': enableHardwareAcceleration,
      };

  factory PerformanceSettings.fromJson(Map<String, dynamic> json) => PerformanceSettings(
        thumbnailCacheLimitMb: (json['thumbnailCacheLimitMb'] as int?) ?? 64,
        memoryCacheLimitMb: (json['memoryCacheLimitMb'] as int?) ?? 256,
        maxAnimationFps: (json['maxAnimationFps'] as int?) ?? 60,
        enableHardwareAcceleration: (json['enableHardwareAcceleration'] as bool?) ?? true,
      );

  @override
  List<Object?> get props => [
        thumbnailCacheLimitMb,
        memoryCacheLimitMb,
        maxAnimationFps,
        enableHardwareAcceleration,
      ];
}
