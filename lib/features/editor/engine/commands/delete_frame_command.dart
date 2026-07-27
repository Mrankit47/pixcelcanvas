import 'package:pixelcanvas/features/editor/engine/canvas_engine.dart';
import 'package:pixelcanvas/features/editor/engine/commands/history_command.dart';
import 'package:pixelcanvas/features/editor/engine/sprite_sheet/models/sprite_frame.dart';

/// Reversible history command for deleting a sprite frame.
class DeleteFrameCommand extends HistoryCommand {
  /// Creates a [DeleteFrameCommand].
  DeleteFrameCommand({
    required this.deletedFrame,
    required this.deletedIndex,
  });

  /// The deleted sprite frame snapshot.
  final SpriteFrame deletedFrame;

  /// Index where frame was removed from.
  final int deletedIndex;

  @override
  String get name => 'Delete Frame';

  @override
  void execute(CanvasEngine engine) {
    // Already applied on commit; handles undo/redo.
  }

  @override
  void undo(CanvasEngine engine) {
    final sheet = engine.spriteSheetEngine.sheet;
    if (sheet != null) {
      final targetIndex = deletedIndex.clamp(0, sheet.frames.length);
      sheet.frames.insert(targetIndex, deletedFrame);
      sheet.activeFrameIndex = targetIndex;
    }
    engine.compositeVisibleLayers();
  }

  @override
  void redo(CanvasEngine engine) {
    engine.spriteSheetEngine.deleteFrame(deletedIndex);
    engine.compositeVisibleLayers();
  }
}
