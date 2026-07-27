import 'package:pixelcanvas/features/editor/engine/canvas_engine.dart';
import 'package:pixelcanvas/features/editor/engine/commands/history_command.dart';

/// Reversible history command for timeline cursor or track layout changes.
class TimelineCommand extends HistoryCommand {
  /// Creates a [TimelineCommand].
  TimelineCommand({
    required this.description,
    required this.previousFrameIndex,
    required this.newFrameIndex,
  });

  /// Action description label.
  final String description;

  /// Original playhead frame index.
  final int previousFrameIndex;

  /// Target playhead frame index.
  final int newFrameIndex;

  @override
  String get name => description;

  @override
  void execute(CanvasEngine engine) {
    // Applied on commit; handles undo/redo.
  }

  @override
  void undo(CanvasEngine engine) {
    engine.animationEngine.seekFrame(previousFrameIndex);
    engine.compositeVisibleLayers();
  }

  @override
  void redo(CanvasEngine engine) {
    engine.animationEngine.seekFrame(newFrameIndex);
    engine.compositeVisibleLayers();
  }
}
