import 'package:pixelcanvas/features/editor/engine/canvas_engine.dart';
import 'package:pixelcanvas/features/editor/engine/commands/history_command.dart';
import 'package:pixelcanvas/features/editor/engine/sprite_sheet/models/sprite_frame.dart';

/// Reversible history command for creating a sprite frame.
class CreateFrameCommand extends HistoryCommand {
  /// Creates a [CreateFrameCommand].
  CreateFrameCommand({
    required this.createdFrame,
    required this.insertedIndex,
  });

  /// The created sprite frame.
  final SpriteFrame createdFrame;

  /// Index where frame was inserted.
  final int insertedIndex;

  @override
  String get name => 'Create Frame';

  @override
  void execute(CanvasEngine engine) {
    // Already applied on commit; handles undo/redo.
  }

  @override
  void undo(CanvasEngine engine) {
    engine.spriteSheetEngine.deleteFrame(insertedIndex);
    engine.compositeVisibleLayers();
  }

  @override
  void redo(CanvasEngine engine) {
    final sheet = engine.spriteSheetEngine.sheet;
    if (sheet != null) {
      final targetIndex = insertedIndex.clamp(0, sheet.frames.length);
      sheet.frames.insert(targetIndex, createdFrame);
      sheet.activeFrameIndex = targetIndex;
    }
    engine.compositeVisibleLayers();
  }
}
