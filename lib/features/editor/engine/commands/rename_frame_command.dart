import 'package:pixelcanvas/features/editor/engine/canvas_engine.dart';
import 'package:pixelcanvas/features/editor/engine/commands/history_command.dart';

/// Reversible history command for renaming a sprite frame.
class RenameFrameCommand extends HistoryCommand {
  /// Creates a [RenameFrameCommand].
  RenameFrameCommand({
    required this.frameIndex,
    required this.oldName,
    required this.newName,
  });

  /// Index of the renamed frame.
  final int frameIndex;

  /// Original name before renaming.
  final String oldName;

  /// Target new name.
  final String newName;

  @override
  String get name => 'Rename Frame';

  @override
  void execute(CanvasEngine engine) {
    // Already applied on commit; handles undo/redo.
  }

  @override
  void undo(CanvasEngine engine) {
    engine.spriteSheetEngine.renameFrame(frameIndex, oldName);
    engine.compositeVisibleLayers();
  }

  @override
  void redo(CanvasEngine engine) {
    engine.spriteSheetEngine.renameFrame(frameIndex, newName);
    engine.compositeVisibleLayers();
  }
}
