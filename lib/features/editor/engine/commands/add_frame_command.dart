import 'package:pixelcanvas/features/editor/engine/animation/models/animation_frame.dart';
import 'package:pixelcanvas/features/editor/engine/canvas_engine.dart';
import 'package:pixelcanvas/features/editor/engine/commands/history_command.dart';

/// Reversible history command for adding a frame to an animation clip.
class AddFrameCommand extends HistoryCommand {
  /// Creates an [AddFrameCommand].
  AddFrameCommand({
    required this.clipId,
    required this.addedFrame,
    required this.insertedIndex,
  });

  /// Target clip ID.
  final String clipId;

  /// Added animation frame instance.
  final AnimationFrame addedFrame;

  /// Index where frame was inserted.
  final int insertedIndex;

  @override
  String get name => 'Add Animation Frame';

  @override
  void execute(CanvasEngine engine) {
    // Applied on commit; handles undo/redo.
  }

  @override
  void undo(CanvasEngine engine) {
    final clip = engine.animationEngine.activeClip;
    if (clip != null && insertedIndex >= 0 && insertedIndex < clip.frames.length) {
      clip.frames.removeAt(insertedIndex);
    }
    engine.compositeVisibleLayers();
  }

  @override
  void redo(CanvasEngine engine) {
    final clip = engine.animationEngine.activeClip;
    if (clip != null) {
      final idx = insertedIndex.clamp(0, clip.frames.length);
      clip.frames.insert(idx, addedFrame);
    }
    engine.compositeVisibleLayers();
  }
}
