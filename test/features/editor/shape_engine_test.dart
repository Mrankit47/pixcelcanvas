import 'package:flutter_test/flutter_test.dart';
import 'package:pixelcanvas/features/editor/engine/shapes/models/shape_settings.dart';
import 'package:pixelcanvas/features/editor/engine/shapes/shape_engine.dart';

void main() {
  group('ShapeEngine Tests', () {
    test('Draw line using Bresenham algorithm', () {
      final engine = ShapeEngine();
      engine.settings = engine.settings.copyWith(type: ShapeType.line);
      engine.beginShape(5, 5);
      engine.updateShape(15, 5);

      expect(engine.isDrawing, isTrue);
      expect(engine.preview, isNotNull);
    });

    test('Draw filled rectangle shape', () {
      final engine = ShapeEngine();
      engine.settings = engine.settings.copyWith(
        type: ShapeType.rectangle,
        fillMode: ShapeFillMode.filled,
      );
      engine.beginShape(2, 2);
      engine.updateShape(8, 8);

      expect(engine.isDrawing, isTrue);
      expect(engine.preview, isNotNull);
    });

    test('Draw circle shape using Midpoint algorithm', () {
      final engine = ShapeEngine();
      engine.settings = engine.settings.copyWith(type: ShapeType.circle);
      engine.beginShape(16, 16);
      engine.updateShape(24, 24);

      expect(engine.isDrawing, isTrue);
      expect(engine.preview, isNotNull);
    });
  });
}
