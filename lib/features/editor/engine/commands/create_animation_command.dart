import 'package:pixelcanvas/features/editor/engine/animation/models/animation_clip.dart';
import 'package:pixelcanvas/features/editor/engine/canvas_engine.dart';
import 'package:pixelcanvas/features/editor/engine/commands/history_command.dart';

/// Reversible history command for creating an animation clip.
class CreateAnimationCommand extends HistoryCommand {
  /// Creates a [CreateAnimationCommand].
  CreateAnimationCommand({
    required this.createdClip,
    required this.insertedIndex,
  });

  /// Created clip instance.
  final AnimationClip createdClip;

  /// Index where clip was inserted.
  final int insertedIndex;

  @override
  String get name => 'Create Animation Clip';

  @override
  void execute(CanvasEngine engine) {
    // Applied on commit; handles undo/redo.
  }

  @override
  void undo(CanvasEngine engine) {
    engine.animationEngine.deleteAnimation(createdClip.id);
    engine.compositeVisibleLayers();
  }

  @override
  void redo(CanvasEngine engine) {
    final timeline = engine.animationEngine.timeline;
    final idx = insertedIndex.clamp(0, timeline.clips.length);
    timeline.clips.insert(idx, createdClip);
    timeline.activeClipIndex = idx;
    engine.compositeVisibleLayers();
  }
}
