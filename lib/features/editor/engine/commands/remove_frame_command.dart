import 'package:pixelcanvas/features/editor/engine/animation/models/animation_frame.dart';
import 'package:pixelcanvas/features/editor/engine/canvas_engine.dart';
import 'package:pixelcanvas/features/editor/engine/commands/history_command.dart';

/// Reversible history command for removing a frame from an animation clip.
class RemoveFrameCommand extends HistoryCommand {
  /// Creates a [RemoveFrameCommand].
  RemoveFrameCommand({
    required this.clipId,
    required this.removedFrame,
    required this.removedIndex,
  });

  /// Target clip ID.
  final String clipId;

  /// Removed animation frame snapshot.
  final AnimationFrame removedFrame;

  /// Index where frame was removed from.
  final int removedIndex;

  @override
  String get name => 'Remove Animation Frame';

  @override
  void execute(CanvasEngine engine) {
    // Applied on commit; handles undo/redo.
  }

  @override
  void undo(CanvasEngine engine) {
    final clip = engine.animationEngine.activeClip;
    if (clip != null) {
      final idx = removedIndex.clamp(0, clip.frames.length);
      clip.frames.insert(idx, removedFrame);
    }
    engine.compositeVisibleLayers();
  }

  @override
  void redo(CanvasEngine engine) {
    final clip = engine.animationEngine.activeClip;
    if (clip != null && removedIndex >= 0 && removedIndex < clip.frames.length) {
      clip.frames.removeAt(removedIndex);
    }
    engine.compositeVisibleLayers();
  }
}
