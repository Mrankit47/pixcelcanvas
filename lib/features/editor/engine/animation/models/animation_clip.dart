import 'package:pixelcanvas/features/editor/engine/animation/models/animation_frame.dart';
import 'package:pixelcanvas/features/editor/engine/animation/models/loop_mode.dart';

/// Container model representing an Animation Clip sequence (e.g. Idle, Walk, Run, Jump, Attack).
///
/// **Purpose**: Groups ordered timeline frames with loop modes, speed multipliers, and FPS configs.
/// **Architecture**: Pure Dart class — no framework dependencies.
class AnimationClip {
  /// Creates an [AnimationClip].
  AnimationClip({
    required this.id,
    required this.name,
    this.frames = const [],
    this.loopMode = LoopMode.loop,
    this.playbackSpeed = 1.0,
    this.fps = 12,
  });

  /// Unique clip identifier.
  final String id;

  /// Display name (e.g. `Idle`, `Walk`, `Attack`).
  String name;

  /// Ordered list of animation timeline frames.
  final List<AnimationFrame> frames;

  /// Looping behavior for playback.
  LoopMode loopMode;

  /// Playback speed multiplier (0.1x to 5.0x).
  double playbackSpeed;

  /// Target frames-per-second rate (1 to 60 FPS).
  int fps;

  /// Total frame count.
  int get frameCount => frames.length;

  /// Total clip duration in milliseconds.
  int get totalDurationMs {
    var total = 0;
    for (final f in frames) {
      total += f.durationMs;
    }
    return total;
  }

  /// Clones this clip.
  AnimationClip clone({String? newId, String? newName}) {
    return AnimationClip(
      id: newId ?? '${id}_copy',
      name: newName ?? '${name}_Copy',
      frames: List<AnimationFrame>.from(frames),
      loopMode: loopMode,
      playbackSpeed: playbackSpeed,
      fps: fps,
    );
  }
}
