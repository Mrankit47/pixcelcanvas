import 'package:flutter_test/flutter_test.dart';
import 'package:pixelcanvas/features/editor/engine/selection/models/selection_bounds.dart';
import 'package:pixelcanvas/features/editor/engine/selection/selection_engine.dart';

void main() {
  group('SelectionEngine Tests', () {
    test('Rubber-band drag selection bounds calculation', () {
      final engine = SelectionEngine();
      engine.beginSelection(10, 10);
      engine.updateSelection(20, 30);
      engine.endSelection();

      expect(engine.hasSelection, isTrue);
      expect(engine.selectionBounds, equals(const SelectionBounds(left: 10, top: 10, right: 21, bottom: 31)));
    });

    test('Hit test handle returns correct hit handle target', () {
      final engine = SelectionEngine();
      engine.beginSelection(0, 0);
      engine.updateSelection(10, 10);
      engine.endSelection();

      final hitZone = engine.hitTestSelection(10, 10);
      expect(hitZone, isNot(equals(SelectionHitZone.none)));
    });

    test('Clear selection resets selection region and bounds', () {
      final engine = SelectionEngine();
      engine.beginSelection(5, 5);
      engine.updateSelection(15, 15);
      engine.endSelection();
      expect(engine.hasSelection, isTrue);

      engine.clearSelection();
      expect(engine.hasSelection, isFalse);
    });
  });
}
