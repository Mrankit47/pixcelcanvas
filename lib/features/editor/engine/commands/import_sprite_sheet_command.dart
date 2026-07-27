import 'package:pixelcanvas/features/editor/engine/canvas_engine.dart';
import 'package:pixelcanvas/features/editor/engine/commands/history_command.dart';
import 'package:pixelcanvas/features/editor/engine/sprite_sheet/models/sprite_sheet.dart';

/// Reversible history command for a sprite sheet import operation.
class ImportSpriteSheetCommand extends HistoryCommand {
  /// Creates an [ImportSpriteSheetCommand].
  ImportSpriteSheetCommand({
    required this.previousSheet,
    required this.newSheet,
  });

  /// Previous sprite sheet asset container snapshot, or null.
  final SpriteSheet? previousSheet;

  /// Imported new sprite sheet asset container.
  final SpriteSheet newSheet;

  @override
  String get name => 'Import Sprite Sheet';

  @override
  void execute(CanvasEngine engine) {
    // Already applied on commit; handles undo/redo.
  }

  @override
  void undo(CanvasEngine engine) {
    if (previousSheet == null) {
      engine.spriteSheetEngine.sheet?.frames.clear();
    } else {
      engine.spriteSheetEngine.sheet?.frames.clear();
      engine.spriteSheetEngine.sheet?.frames.addAll(previousSheet!.frames);
    }
    engine.compositeVisibleLayers();
  }

  @override
  void redo(CanvasEngine engine) {
    engine.spriteSheetEngine.sheet?.frames.clear();
    engine.spriteSheetEngine.sheet?.frames.addAll(newSheet.frames);
    engine.compositeVisibleLayers();
  }
}
