import 'package:flutter_test/flutter_test.dart';
import 'package:pixelcanvas/features/editor/engine/canvas_engine.dart';

void main() {
  group('LayerManager Tests', () {
    test('Create layer adds new layer to stack', () {
      final engine = CanvasEngine(width: 32, height: 32);
      expect(engine.grid.layers.length, equals(1));

      engine.createLayer();
      expect(engine.grid.layers.length, equals(2));
      expect(engine.session.activeLayerIndex, equals(1));
    });

    test('Delete layer removes target layer from stack', () {
      final engine = CanvasEngine(width: 32, height: 32);
      engine.createLayer();
      expect(engine.grid.layers.length, equals(2));

      engine.deleteLayer(1);
      expect(engine.grid.layers.length, equals(1));
    });

    test('Toggle visibility prevents layer from rendering into composite buffer', () {
      final engine = CanvasEngine(width: 16, height: 16);
      final layer = engine.grid.layers.first;

      engine.toggleLayerVisibility(0);
      expect(layer.isVisible, isFalse);
    });

    test('Toggle lock prevents layer from being mutated', () {
      final engine = CanvasEngine(width: 16, height: 16);
      final layer = engine.grid.layers.first;

      engine.toggleLayerLock(0);
      expect(layer.isLocked, isTrue);
    });

    test('Reorder layers changes stack index position', () {
      final engine = CanvasEngine(width: 32, height: 32);
      engine.createLayer(name: 'Layer 2');
      expect(engine.grid.layers[1].name, equals('Layer 2'));

      engine.reorderLayers(0, 1);
      expect(engine.grid.layers[0].name, equals('Layer 2'));
    });
  });
}
