import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/editor/engine/layer_buffer.dart';
import 'package:pixelcanvas/features/editor/engine/pixel.dart';
import 'package:pixelcanvas/features/editor/engine/pixel_buffer.dart';

/// Multi-layer composite pixel grid matrix per Blueprint §8.1.
///
/// **Purpose**: Maintains layer stack list and calculates composite pixel colors for rendering.
/// **Compositing Order**: Index 0 = bottom, highest index = top. Traverses bottom-to-top for correct alpha compositing.
/// **Performance Considerations**: Fast bottom-to-top layer compositing with opacity blending.
class PixelGrid {
  /// Creates a [PixelGrid].
  PixelGrid({
    required this.width,
    required this.height,
  }) : compositeBuffer = PixelBuffer(width: width, height: height) {
    // Add default background layer
    layers.add(LayerBuffer(
      id: 'layer_0',
      name: 'Layer 1',
      width: width,
      height: height,
      index: 0,
    ));
  }

  /// Canvas width.
  final int width;

  /// Canvas height.
  final int height;

  /// Active layers stack list.
  final List<LayerBuffer> layers = [];

  /// Cached composite pixel buffer.
  final PixelBuffer compositeBuffer;

  /// Re-composites all visible layers into [compositeBuffer].
  ///
  /// Traverses bottom-to-top (index 0 → highest) and composites with layer opacity.
  void recomposite() {
    compositeBuffer.clear();

    for (var y = 0; y < height; y++) {
      for (var x = 0; x < width; x++) {
        Color composited = Colors.transparent;

        // Bottom-to-top compositing
        for (var i = 0; i < layers.length; i++) {
          final layer = layers[i];
          if (!layer.isVisible) continue;

          final px = layer.getPixel(x, y);
          if (px.isEmpty) continue;

          final layerOpacity = layer.opacity;
          final clampedAlpha = (px.opacity * layerOpacity * (px.color.a / 255.0)).clamp(0.0, 1.0);
          final pixelColor = px.color.withOpacity(clampedAlpha);

          if (composited == Colors.transparent) {
            composited = pixelColor;
          } else {
            composited = Color.alphaBlend(pixelColor, composited);
          }
        }

        if (composited != Colors.transparent) {
          compositeBuffer.setPixel(x, y, Pixel(
            color: composited,
            opacity: 1.0,
            isVisible: true,
          ));
        }
      }
    }
  }
}
