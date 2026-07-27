import 'package:pixelcanvas/features/editor/engine/animation/models/animation_clip.dart';
import 'package:pixelcanvas/features/editor/engine/animation/models/animation_frame.dart';
import 'package:pixelcanvas/features/editor/engine/animation/timeline/animation_track.dart';
import 'package:pixelcanvas/features/editor/engine/animation/timeline/timeline_cursor.dart';
import 'package:pixelcanvas/features/editor/engine/animation/timeline/timeline_selection.dart';

/// Central state structure for the Animation Timeline.
///
/// **Purpose**: Manages active animation clips, track hierarchy, playhead cursor, and zoom level.
/// **Architecture**: Pure Dart container — no framework dependencies.
class AnimationTimeline {
  /// Creates an [AnimationTimeline].
  AnimationTimeline({
    this.clips = const [],
    this.activeClipIndex = 0,
    this.zoomLevel = 1.0,
    TimelineCursor? cursor,
    TimelineSelection? selection,
  })  : cursor = cursor ?? const TimelineCursor(),
        selection = selection ?? const TimelineSelection() {
    tracks = [
      AnimationTrack(
        id: 'track_main',
        name: 'Main Track',
        clips: clips,
      ),
    ];
  }

  /// List of animation tracks.
  late final List<AnimationTrack> tracks;

  /// List of animation clips.
  final List<AnimationClip> clips;

  /// Currently active selected clip index.
  int activeClipIndex;

  /// Playhead cursor position container.
  TimelineCursor cursor;

  /// Timeline selection state container.
  TimelineSelection selection;

  /// Timeline zoom scale level (0.2x to 5.0x).
  double zoomLevel;

  /// Currently active [AnimationClip], or null if empty.
  AnimationClip? get activeClip {
    if (clips.isEmpty || activeClipIndex < 0 || activeClipIndex >= clips.length) {
      return null;
    }
    return clips[activeClipIndex];
  }

  /// Active clip frame count.
  int get activeFrameCount => activeClip?.frameCount ?? 0;

  /// Active clip frame at cursor index, or null.
  AnimationFrame? get currentFrame {
    final clip = activeClip;
    if (clip == null || clip.frames.isEmpty) return null;
    final idx = cursor.frameIndex.clamp(0, clip.frames.length - 1);
    return clip.frames[idx];
  }
}
