import 'package:pixelcanvas/features/editor/engine/canvas_engine.dart';
import 'package:pixelcanvas/features/editor/engine/commands/history_command.dart';

/// Reversible history command for reordering a sprite frame.
class ReorderFrameCommand extends HistoryCommand {
  /// Creates a [ReorderFrameCommand].
  ReorderFrameCommand({
    required this.oldIndex,
    required this.newIndex,
  });

  /// Original index of the moved frame.
  final int oldIndex;

  /// Target index of the moved frame.
  final int newIndex;

  @override
  String get name => 'Reorder Frame';

  @override
  void execute(CanvasEngine engine) {
    // Already applied on commit; handles undo/redo.
  }

  @override
  void undo(CanvasEngine engine) {
    engine.spriteSheetEngine.reorderFrame(newIndex, oldIndex);
    engine.compositeVisibleLayers();
  }

  @override
  void redo(CanvasEngine engine) {
    engine.spriteSheetEngine.reorderFrame(oldIndex, newIndex);
    engine.compositeVisibleLayers();
  }
}
