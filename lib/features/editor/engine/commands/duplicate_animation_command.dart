import 'package:pixelcanvas/features/editor/engine/animation/models/animation_clip.dart';
import 'package:pixelcanvas/features/editor/engine/canvas_engine.dart';
import 'package:pixelcanvas/features/editor/engine/commands/history_command.dart';

/// Reversible history command for duplicating an animation clip.
class DuplicateAnimationCommand extends HistoryCommand {
  /// Creates a [DuplicateAnimationCommand].
  DuplicateAnimationCommand({
    required this.duplicatedClip,
    required this.insertedIndex,
  });

  /// Duplicated clip instance.
  final AnimationClip duplicatedClip;

  /// Index where clip was inserted.
  final int insertedIndex;

  @override
  String get name => 'Duplicate Animation Clip';

  @override
  void execute(CanvasEngine engine) {
    // Applied on commit; handles undo/redo.
  }

  @override
  void undo(CanvasEngine engine) {
    engine.animationEngine.deleteAnimation(duplicatedClip.id);
    engine.compositeVisibleLayers();
  }

  @override
  void redo(CanvasEngine engine) {
    final timeline = engine.animationEngine.timeline;
    final idx = insertedIndex.clamp(0, timeline.clips.length);
    timeline.clips.insert(idx, duplicatedClip);
    timeline.activeClipIndex = idx;
    engine.compositeVisibleLayers();
  }
}
