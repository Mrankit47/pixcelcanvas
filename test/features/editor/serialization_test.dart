import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:pixelcanvas/features/editor/engine/canvas_engine.dart';
import 'package:pixelcanvas/features/editor/engine/pixel.dart';

void main() {
  group('Project Serialization Tests', () {
    test('Round-trip save and restore project state', () {
      final sourceEngine = CanvasEngine(width: 32, height: 32);
      sourceEngine.layerManager.createLayer();
      sourceEngine.grid.layers.last.setPixel(10, 10, const Pixel(color: Color(0xFFFF0000)));

      // Serialize
      final jsonPayload = sourceEngine.saveProjectJson();
      expect(jsonPayload, isNotEmpty);

      // Restore into new engine instance
      final restoredEngine = CanvasEngine();
      final success = restoredEngine.loadProjectJson(jsonPayload);

      expect(success, isTrue);
      expect(restoredEngine.width, equals(32));
      expect(restoredEngine.height, equals(32));
      expect(restoredEngine.grid.layers.length, equals(2));
    });
  });
}
