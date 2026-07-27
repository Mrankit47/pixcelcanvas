import 'package:equatable/equatable.dart';
import 'package:pixelcanvas/features/editor/engine/animation/models/loop_mode.dart';

/// Global configuration settings for Animation Timeline playback and Onion Skinning.
///
/// **Purpose**: Maintains default FPS rates, onion skin opacity, frame counts, and colors.
/// **Architecture**: Pure Dart value object with `copyWith` and `Equatable`.
class AnimationSettings extends Equatable {
  /// Creates an [AnimationSettings].
  const AnimationSettings({
    this.fps = 12,
    this.loopMode = LoopMode.loop,
    this.onionSkinEnabled = false,
    this.onionSkinPreviousFrames = 1,
    this.onionSkinNextFrames = 1,
    this.onionSkinOpacity = 0.4,
    this.onionSkinPreviousColorHex = '#FF0000', // Red tint for previous frames
    this.onionSkinNextColorHex = '#00FF00', // Green tint for next frames
  });

  /// Default playback FPS rate (1 to 60 FPS).
  final int fps;

  /// Default playback loop mode.
  final LoopMode loopMode;

  /// Whether onion skin translucent frame overlay is enabled.
  final bool onionSkinEnabled;

  /// Number of previous frames to overlay in onion skin mode (1 to 5).
  final int onionSkinPreviousFrames;

  /// Number of next frames to overlay in onion skin mode (1 to 5).
  final int onionSkinNextFrames;

  /// Onion skin overlay opacity multiplier (0.0 to 1.0).
  final double onionSkinOpacity;

  /// Color hex tint string for previous frame overlays.
  final String onionSkinPreviousColorHex;

  /// Color hex tint string for next frame overlays.
  final String onionSkinNextColorHex;

  /// Creates a copy of [AnimationSettings] with updated fields.
  AnimationSettings copyWith({
    int? fps,
    LoopMode? loopMode,
    bool? onionSkinEnabled,
    int? onionSkinPreviousFrames,
    int? onionSkinNextFrames,
    double? onionSkinOpacity,
    String? onionSkinPreviousColorHex,
    String? onionSkinNextColorHex,
  }) =>
      AnimationSettings(
        fps: (fps ?? this.fps).clamp(1, 60),
        loopMode: loopMode ?? this.loopMode,
        onionSkinEnabled: onionSkinEnabled ?? this.onionSkinEnabled,
        onionSkinPreviousFrames:
            (onionSkinPreviousFrames ?? this.onionSkinPreviousFrames)
                .clamp(0, 5),
        onionSkinNextFrames:
            (onionSkinNextFrames ?? this.onionSkinNextFrames).clamp(0, 5),
        onionSkinOpacity:
            (onionSkinOpacity ?? this.onionSkinOpacity).clamp(0.0, 1.0),
        onionSkinPreviousColorHex:
            onionSkinPreviousColorHex ?? this.onionSkinPreviousColorHex,
        onionSkinNextColorHex:
            onionSkinNextColorHex ?? this.onionSkinNextColorHex,
      );

  @override
  List<Object?> get props => [
        fps,
        loopMode,
        onionSkinEnabled,
        onionSkinPreviousFrames,
        onionSkinNextFrames,
        onionSkinOpacity,
        onionSkinPreviousColorHex,
        onionSkinNextColorHex,
      ];
}
