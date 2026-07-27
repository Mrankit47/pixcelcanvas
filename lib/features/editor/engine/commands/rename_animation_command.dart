import 'package:pixelcanvas/features/editor/engine/canvas_engine.dart';
import 'package:pixelcanvas/features/editor/engine/commands/history_command.dart';

/// Reversible history command for renaming an animation clip.
class RenameAnimationCommand extends HistoryCommand {
  /// Creates a [RenameAnimationCommand].
  RenameAnimationCommand({
    required this.clipId,
    required this.oldName,
    required this.newName,
  });

  /// ID of target clip.
  final String clipId;

  /// Original clip name.
  final String oldName;

  /// Target new clip name.
  final String newName;

  @override
  String get name => 'Rename Animation Clip';

  @override
  void execute(CanvasEngine engine) {
    // Applied on commit; handles undo/redo.
  }

  @override
  void undo(CanvasEngine engine) {
    engine.animationEngine.renameAnimation(clipId, oldName);
    engine.compositeVisibleLayers();
  }

  @override
  void redo(CanvasEngine engine) {
    engine.animationEngine.renameAnimation(clipId, newName);
    engine.compositeVisibleLayers();
  }
}
