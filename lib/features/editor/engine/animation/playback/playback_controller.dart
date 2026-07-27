import 'package:pixelcanvas/features/editor/engine/animation/models/animation_clip.dart';
import 'package:pixelcanvas/features/editor/engine/animation/models/loop_mode.dart';

/// Pure Dart tick-driven animation playback controller.
///
/// **Purpose**: Controls real-time frame advancement, delta time accumulation, and loop modes.
/// **Architecture Rules**: Zero framework timer dependencies — uses explicit tick updates.
class PlaybackController {
  /// Playback playing state flag.
  bool isPlaying = false;

  /// Current playback frame index.
  int currentFrameIndex = 0;

  /// Accumulated delta time in milliseconds for the active frame.
  int elapsedTimeMs = 0;

  /// Direction flag for `pingPong` loop mode (true if moving backward).
  bool _isReversing = false;

  /// Starts playback.
  void play() {
    isPlaying = true;
  }

  /// Pauses playback at current frame.
  void pause() {
    isPlaying = false;
  }

  /// Stops playback and resets playhead to frame 0.
  void stop() {
    isPlaying = false;
    currentFrameIndex = 0;
    elapsedTimeMs = 0;
    _isReversing = false;
  }

  /// Restarts playback from frame 0.
  void restart() {
    currentFrameIndex = 0;
    elapsedTimeMs = 0;
    _isReversing = false;
    isPlaying = true;
  }

  /// Advances to next frame manually.
  void nextFrame(int maxFrames) {
    if (maxFrames <= 0) return;
    currentFrameIndex = (currentFrameIndex + 1) % maxFrames;
    elapsedTimeMs = 0;
  }

  /// Steps backward to previous frame manually.
  void previousFrame(int maxFrames) {
    if (maxFrames <= 0) return;
    currentFrameIndex = (currentFrameIndex - 1 + maxFrames) % maxFrames;
    elapsedTimeMs = 0;
  }

  /// Seeks playhead directly to [frameIndex].
  void seek(int frameIndex, int maxFrames) {
    if (maxFrames <= 0) {
      currentFrameIndex = 0;
    } else {
      currentFrameIndex = frameIndex.clamp(0, maxFrames - 1);
    }
    elapsedTimeMs = 0;
  }

  /// Advances playback by [deltaMs] milliseconds according to [clip] settings.
  void tick(int deltaMs, AnimationClip? clip) {
    if (!isPlaying || clip == null || clip.frames.isEmpty) return;

    final totalFrames = clip.frameCount;
    if (totalFrames <= 1) return;

    final speedMultiplier = clip.playbackSpeed > 0 ? clip.playbackSpeed : 1.0;
    final effectiveDelta = (deltaMs * speedMultiplier).round();

    elapsedTimeMs += effectiveDelta;

    final curFrame = clip.frames[currentFrameIndex.clamp(0, totalFrames - 1)];
    final targetDuration = curFrame.fpsOverride != null
        ? (1000 / curFrame.fpsOverride!).round()
        : (curFrame.durationMs > 0
            ? curFrame.durationMs
            : (1000 / (clip.fps > 0 ? clip.fps : 12)).round());

    if (elapsedTimeMs >= targetDuration) {
      elapsedTimeMs = 0;
      _advanceFrame(clip.loopMode, totalFrames);
    }
  }

  void _advanceFrame(LoopMode loopMode, int totalFrames) {
    switch (loopMode) {
      case LoopMode.loop:
        currentFrameIndex = (currentFrameIndex + 1) % totalFrames;
        break;

      case LoopMode.playOnce:
        if (currentFrameIndex < totalFrames - 1) {
          currentFrameIndex++;
        } else {
          isPlaying = false; // Stop on final frame
        }
        break;

      case LoopMode.pingPong:
        if (_isReversing) {
          if (currentFrameIndex > 0) {
            currentFrameIndex--;
          } else {
            _isReversing = false;
            currentFrameIndex = 1.clamp(0, totalFrames - 1);
          }
        } else {
          if (currentFrameIndex < totalFrames - 1) {
            currentFrameIndex++;
          } else {
            _isReversing = true;
            currentFrameIndex = (totalFrames - 2).clamp(0, totalFrames - 1);
          }
        }
        break;
    }
  }
}
