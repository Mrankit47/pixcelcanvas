import 'package:pixelcanvas/features/editor/engine/layer_buffer.dart';
import 'package:pixelcanvas/features/editor/engine/models/eraser_settings.dart';
import 'package:pixelcanvas/features/editor/engine/pixel.dart';

/// Eraser Renderer Engine executing pixel clearing on layer buffers per Blueprint §8.1.
///
/// **Purpose**: Restores [Pixel.empty] transparency on active [LayerBuffer].
/// **Layer Interaction**: Erases only on unlocked, visible target layer without modifying background or other layers.
/// **Future Extensions**: Soft alpha erasure blending in Phase 4.
class EraserRenderer {
  /// Erases a stamp centered at `(centerX, centerY)` with given [settings].
  static void eraseBrush({
    required LayerBuffer layer,
    required int centerX,
    required int centerY,
    required EraserSettings settings,
  }) {
    if (layer.isLocked || !layer.isVisible) return;

    final radius = settings.size ~/ 2;

    if (settings.size == 1) {
      layer.setPixel(centerX, centerY, Pixel.empty);
      return;
    }

    final startX = centerX - radius;
    final startY = centerY - radius;
    final endX = startX + settings.size;
    final endY = startY + settings.size;

    for (var y = startY; y < endY; y++) {
      for (var x = startX; x < endX; x++) {
        layer.setPixel(x, y, Pixel.empty);
      }
    }
  }

  /// Erases a single pixel at `(x, y)`.
  static void erasePixel({
    required LayerBuffer layer,
    required int x,
    required int y,
  }) {
    if (layer.isLocked || !layer.isVisible) return;
    layer.setPixel(x, y, Pixel.empty);
  }
}
