import 'package:pixelcanvas/features/editor/engine/animation/models/animation_clip.dart';

/// Represents a timeline track containing animation clips.
class AnimationTrack {
  /// Creates an [AnimationTrack].
  AnimationTrack({
    required this.id,
    required this.name,
    List<AnimationClip>? clips,
    this.isVisible = true,
    this.isMuted = false,
  }) : clips = clips != null ? List<AnimationClip>.from(clips) : <AnimationClip>[];

  /// Unique track identifier.
  final String id;

  /// Display name (e.g. `Main Animation Track`).
  String name;

  /// Animation clips on this track.
  final List<AnimationClip> clips;

  /// Track visibility toggle.
  bool isVisible;

  /// Track mute toggle.
  bool isMuted;
}
