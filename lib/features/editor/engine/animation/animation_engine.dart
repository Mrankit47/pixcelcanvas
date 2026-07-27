import 'dart:typed_data';

import 'package:pixelcanvas/features/editor/engine/animation/models/animation_clip.dart';
import 'package:pixelcanvas/features/editor/engine/animation/models/animation_frame.dart';
import 'package:pixelcanvas/features/editor/engine/animation/models/animation_settings.dart';
import 'package:pixelcanvas/features/editor/engine/animation/models/loop_mode.dart';
import 'package:pixelcanvas/features/editor/engine/animation/playback/playback_controller.dart';
import 'package:pixelcanvas/features/editor/engine/animation/timeline/animation_timeline.dart';
import 'package:pixelcanvas/features/editor/engine/animation/tools/animation_exporter.dart';

/// Central stateful orchestrator for the Animation Engine.
///
/// **Purpose**: Links animation timeline, playback controller, onion skinning, and clip CRUD.
/// **Architecture**: Pure Dart — no Riverpod, Widgets, or framework dependencies.
class AnimationEngine {
  /// Creates an [AnimationEngine].
  AnimationEngine() {
    // Initialize default preset clip (Idle)
    createAnimation('Idle');
  }

  /// Active timeline state container.
  final AnimationTimeline timeline = AnimationTimeline();

  /// Playback ticker controller.
  final PlaybackController playbackController = PlaybackController();

  /// Global animation & onion skin settings.
  AnimationSettings settings = const AnimationSettings();

  /// Currently active animation clip, or null.
  AnimationClip? get activeClip => timeline.activeClip;

  /// True if animation playback is running.
  bool get isPlaying => playbackController.isPlaying;

  /// Current playhead frame index.
  int get currentFrameIndex => playbackController.currentFrameIndex;

  /// Creates a new animation clip [name].
  AnimationClip createAnimation(String name, [List<AnimationFrame>? frames]) {
    final index = timeline.clips.length;
    final clip = AnimationClip(
      id: 'clip_$index',
      name: name,
      frames: frames != null ? List<AnimationFrame>.from(frames) : [],
      fps: settings.fps,
      loopMode: settings.loopMode,
    );

    timeline.clips.add(clip);
    timeline.activeClipIndex = timeline.clips.length - 1;
    playbackController.stop();
    return clip;
  }

  /// Deletes animation clip by [clipId].
  AnimationClip? deleteAnimation(String clipId) {
    final idx = timeline.clips.indexWhere((c) => c.id == clipId);
    if (idx < 0) return null;

    final removed = timeline.clips.removeAt(idx);
    if (timeline.activeClipIndex >= timeline.clips.length) {
      timeline.activeClipIndex = (timeline.clips.length - 1).clamp(0, 4096);
    }
    playbackController.stop();
    return removed;
  }

  /// Duplicates animation clip by [clipId].
  AnimationClip? duplicateAnimation(String clipId) {
    final target = timeline.clips.firstWhere(
      (c) => c.id == clipId,
      orElse: () => timeline.clips.first,
    );

    final idx = timeline.clips.indexOf(target);
    final duplicate = target.clone();

    timeline.clips.insert(idx + 1, duplicate);
    timeline.activeClipIndex = idx + 1;
    playbackController.stop();
    return duplicate;
  }

  /// Renames clip by [clipId] to [newName].
  void renameAnimation(String clipId, String newName) {
    final clip = timeline.clips.firstWhere(
      (c) => c.id == clipId,
      orElse: () => timeline.clips.first,
    );
    clip.name = newName;
  }

  /// Starts animation playback.
  void play() {
    playbackController.play();
  }

  /// Pauses animation playback.
  void pause() {
    playbackController.pause();
  }

  /// Stops playback and resets playhead.
  void stop() {
    playbackController.stop();
  }

  /// Seeks playhead to [frameIndex].
  void seekFrame(int frameIndex) {
    playbackController.seek(frameIndex, activeClip?.frameCount ?? 0);
  }

  /// Steps to next frame.
  void nextFrame() {
    playbackController.nextFrame(activeClip?.frameCount ?? 0);
  }

  /// Steps to previous frame.
  void previousFrame() {
    playbackController.previousFrame(activeClip?.frameCount ?? 0);
  }

  /// Sets global playback FPS rate.
  void setFPS(int fps) {
    settings = settings.copyWith(fps: fps);
    if (activeClip != null) {
      activeClip!.fps = fps;
    }
  }

  /// Sets global playback loop mode.
  void setLoopMode(LoopMode loopMode) {
    settings = settings.copyWith(loopMode: loopMode);
    if (activeClip != null) {
      activeClip!.loopMode = loopMode;
    }
  }

  /// Toggles onion skin translucent frame overlay.
  void toggleOnionSkin([bool? enabled]) {
    final target = enabled ?? !settings.onionSkinEnabled;
    settings = settings.copyWith(onionSkinEnabled: target);
  }

  /// Ticks playback time by [deltaMs] milliseconds.
  void tick(int deltaMs) {
    playbackController.tick(deltaMs, activeClip);
    timeline.cursor = timeline.cursor.copyWith(
      frameIndex: playbackController.currentFrameIndex,
      subFrameTimeMs: playbackController.elapsedTimeMs,
    );
  }

  /// Exports active clip as packed PNG sprite sheet byte array.
  Uint8List? exportAnimatedSpriteSheetPng(int frameW, int frameH) {
    final clip = activeClip;
    if (clip == null) return null;
    return AnimationExporter.exportAnimatedSpriteSheetPng(
      clip: clip,
      frameWidth: frameW,
      frameHeight: frameH,
    );
  }

  /// Exports active clip metadata as JSON string.
  String? exportJsonMetadata() {
    final clip = activeClip;
    if (clip == null) return null;
    return AnimationExporter.exportJsonMetadata(clip);
  }
}
