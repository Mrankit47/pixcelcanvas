import 'package:pixelcanvas/features/editor/engine/canvas_engine.dart';
import 'package:pixelcanvas/features/editor/engine/commands/history_command.dart';
import 'package:pixelcanvas/features/editor/engine/sprite_sheet/models/sprite_frame.dart';

/// Reversible history command for duplicating a sprite frame.
class DuplicateFrameCommand extends HistoryCommand {
  /// Creates a [DuplicateFrameCommand].
  DuplicateFrameCommand({
    required this.duplicatedFrame,
    required this.insertedIndex,
  });

  /// The duplicated sprite frame instance.
  final SpriteFrame duplicatedFrame;

  /// Index where duplicate was inserted.
  final int insertedIndex;

  @override
  String get name => 'Duplicate Frame';

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
      sheet.frames.insert(targetIndex, duplicatedFrame);
      sheet.activeFrameIndex = targetIndex;
    }
    engine.compositeVisibleLayers();
  }
}
