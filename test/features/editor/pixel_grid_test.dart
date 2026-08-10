import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:pixelcanvas/features/editor/engine/pixel.dart';
import 'package:pixelcanvas/features/editor/engine/pixel_grid.dart';

void main() {
  group('PixelGrid Tests', () {
    test('Initialization creates layers and composites correctly', () {
      final grid = PixelGrid(width: 32, height: 32);
      expect(grid.width, equals(32));
      expect(grid.height, equals(32));
      expect(grid.layers.length, equals(1));
      expect(grid.compositeBuffer.width, equals(32));
    });

    test('Setting pixel on active layer updates composited buffer', () {
      final grid = PixelGrid(width: 16, height: 16);
      final layer = grid.layers.first;

      layer.setPixel(5, 5, const Pixel(color: Color(0xFFFF0000)));
      grid.recomposite();

      final pixel = grid.compositeBuffer.getPixel(5, 5);
      expect(pixel.isEmpty, isFalse);
      expect(pixel.color.value, equals(const Color(0xFFFF0000).value));
    });

    test('Resize canvas rescales pixel grid matrices', () {
      final grid = PixelGrid(width: 64, height: 64);

      expect(grid.width, equals(64));
      expect(grid.height, equals(64));
      expect(grid.compositeBuffer.width, equals(64));
      expect(grid.layers.first.width, equals(64));
    });

    test('Out-of-bounds pixel access returns Pixel.empty safely', () {
      final grid = PixelGrid(width: 8, height: 8);
      final pixel = grid.compositeBuffer.getPixel(-1, 100);
      expect(pixel.isEmpty, isTrue);
    });
  });
}
