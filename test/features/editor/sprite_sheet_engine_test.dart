import 'package:flutter_test/flutter_test.dart';
import 'package:pixelcanvas/features/editor/engine/canvas_engine.dart';
import 'package:pixelcanvas/features/editor/engine/selection/models/selection_bounds.dart';
import 'package:pixelcanvas/features/editor/engine/sprite_sheet/models/sprite_sheet_settings.dart';

void main() {
  group('SpriteSheetEngine Tests', () {
    test('Slice grid auto-generates frames list', () {
      final engine = CanvasEngine(width: 64, height: 64);
      engine.sliceSpriteSheet(const SpriteSheetSettings(cellWidth: 32, cellHeight: 32));

      expect(engine.hasSpriteSheet, isTrue);
      expect(engine.spriteSheetEngine.frameCount, equals(4));
    });

    test('Create frame manually from selection bounds', () {
      final engine = CanvasEngine(width: 64, height: 64);
      engine.createFrame(const SelectionBounds(left: 0, top: 0, right: 16, bottom: 16));

      expect(engine.hasSpriteSheet, isTrue);
      expect(engine.spriteSheetEngine.frameCount, equals(1));
    });

    test('Duplicate and Delete frames', () {
      final engine = CanvasEngine(width: 64, height: 64);
      engine.createFrame(const SelectionBounds(left: 0, top: 0, right: 16, bottom: 16));
      expect(engine.spriteSheetEngine.frameCount, equals(1));

      engine.duplicateFrame(0);
      expect(engine.spriteSheetEngine.frameCount, equals(2));

      engine.deleteFrame(0);
      expect(engine.spriteSheetEngine.frameCount, equals(1));
    });
  });
}
