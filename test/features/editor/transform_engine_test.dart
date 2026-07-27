import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:pixelcanvas/features/editor/engine/floating_selection/floating_selection.dart';
import 'package:pixelcanvas/features/editor/engine/pixel.dart';
import 'package:pixelcanvas/features/editor/engine/selection/models/selection_bounds.dart';
import 'package:pixelcanvas/features/editor/engine/transform/transform_engine.dart';

void main() {
  group('TransformEngine Tests', () {
    test('Rotate clockwise, counter-clockwise, and 180 degrees', () {
      final floating = FloatingSelection(
        pixels: List.generate(16, (i) => const Pixel(color: Color(0xFFFF0000))),
        width: 4,
        height: 4,
        originalBounds: const SelectionBounds(left: 0, top: 0, right: 4, bottom: 4),
        sourceLayerIndex: 0,
      );

      final engine = TransformEngine();
      engine.beginTransform(floating);

      engine.rotateClockwise();
      expect(engine.hasActiveTransform, isTrue);

      engine.rotateCounterClockwise();
      expect(engine.hasActiveTransform, isTrue);

      engine.rotate180();
      expect(engine.hasActiveTransform, isTrue);
    });

    test('Flip horizontal and vertical', () {
      final floating = FloatingSelection(
        pixels: List.generate(16, (i) => const Pixel(color: Color(0xFFFF0000))),
        width: 4,
        height: 4,
        originalBounds: const SelectionBounds(left: 0, top: 0, right: 4, bottom: 4),
        sourceLayerIndex: 0,
      );

      final engine = TransformEngine();
      engine.beginTransform(floating);

      engine.flipHorizontal();
      expect(engine.hasActiveTransform, isTrue);

      engine.flipVertical();
      expect(engine.hasActiveTransform, isTrue);
    });

    test('Mirror horizontal and vertical', () {
      final floating = FloatingSelection(
        pixels: List.generate(16, (i) => const Pixel(color: Color(0xFFFF0000))),
        width: 4,
        height: 4,
        originalBounds: const SelectionBounds(left: 0, top: 0, right: 4, bottom: 4),
        sourceLayerIndex: 0,
      );

      final engine = TransformEngine();
      engine.beginTransform(floating);

      engine.mirrorHorizontal();
      expect(engine.hasActiveTransform, isTrue);

      engine.mirrorVertical();
      expect(engine.hasActiveTransform, isTrue);
    });
  });
}
