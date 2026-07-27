import 'package:pixelcanvas/features/editor/engine/animation/models/animation_clip.dart';
import 'package:pixelcanvas/features/editor/engine/canvas_engine.dart';
import 'package:pixelcanvas/features/editor/engine/commands/history_command.dart';

/// Reversible history command for deleting an animation clip.
class DeleteAnimationCommand extends HistoryCommand {
  /// Creates a [DeleteAnimationCommand].
  DeleteAnimationCommand({
    required this.deletedClip,
    required this.deletedIndex,
  });

  /// Deleted clip snapshot.
  final AnimationClip deletedClip;

  /// Index where clip was removed from.
  final int deletedIndex;

  @override
  String get name => 'Delete Animation Clip';

  @override
  void execute(CanvasEngine engine) {
    // Applied on commit; handles undo/redo.
  }

  @override
  void undo(CanvasEngine engine) {
    final timeline = engine.animationEngine.timeline;
    final idx = deletedIndex.clamp(0, timeline.clips.length);
    timeline.clips.insert(idx, deletedClip);
    timeline.activeClipIndex = idx;
    engine.compositeVisibleLayers();
  }

  @override
  void redo(CanvasEngine engine) {
    engine.animationEngine.deleteAnimation(deletedClip.id);
    engine.compositeVisibleLayers();
  }
}
