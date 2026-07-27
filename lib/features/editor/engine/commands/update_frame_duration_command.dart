import 'package:pixelcanvas/features/editor/engine/canvas_engine.dart';
import 'package:pixelcanvas/features/editor/engine/commands/history_command.dart';

/// Reversible history command for updating an animation frame's duration.
class UpdateFrameDurationCommand extends HistoryCommand {
  /// Creates an [UpdateFrameDurationCommand].
  UpdateFrameDurationCommand({
    required this.frameIndex,
    required this.oldDurationMs,
    required this.newDurationMs,
  });

  /// Index of target frame.
  final int frameIndex;

  /// Original duration in milliseconds.
  final int oldDurationMs;

  /// Target duration in milliseconds.
  final int newDurationMs;

  @override
  String get name => 'Update Frame Duration';

  @override
  void execute(CanvasEngine engine) {
    // Applied on commit; handles undo/redo.
  }

  @override
  void undo(CanvasEngine engine) {
    final clip = engine.animationEngine.activeClip;
    if (clip != null && frameIndex >= 0 && frameIndex < clip.frames.length) {
      clip.frames[frameIndex] =
          clip.frames[frameIndex].copyWith(durationMs: oldDurationMs);
    }
    engine.compositeVisibleLayers();
  }

  @override
  void redo(CanvasEngine engine) {
    final clip = engine.animationEngine.activeClip;
    if (clip != null && frameIndex >= 0 && frameIndex < clip.frames.length) {
      clip.frames[frameIndex] =
          clip.frames[frameIndex].copyWith(durationMs: newDurationMs);
    }
    engine.compositeVisibleLayers();
  }
}
