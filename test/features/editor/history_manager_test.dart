import 'package:flutter_test/flutter_test.dart';
import 'package:pixelcanvas/features/editor/engine/canvas_engine.dart';

void main() {
  group('HistoryManager Tests', () {
    test('Undo and Redo stack management', () {
      final engine = CanvasEngine(width: 16, height: 16);

      expect(engine.canUndo, isFalse);
      expect(engine.canRedo, isFalse);

      engine.createLayer();
      expect(engine.canUndo, isTrue);
      expect(engine.grid.layers.length, equals(2));

      engine.undo();
      expect(engine.canRedo, isTrue);
      expect(engine.grid.layers.length, equals(1));

      engine.redo();
      expect(engine.grid.layers.length, equals(2));
    });

    test('History stack limits capacity to maxLimit', () {
      final engine = CanvasEngine(width: 8, height: 8);
      for (var i = 0; i < 60; i++) {
        engine.createLayer();
      }

      expect(engine.historyManager.undoCount, lessThanOrEqualTo(50));
    });
  });
}
