import 'package:pixelcanvas/features/editor/engine/pixel.dart';

/// Single pixel change delta record for undo/redo command history per Blueprint §8.1.
///
/// **Memory Strategy**: Stores only modified pixel coordinates and before/after [Pixel] states.
/// **Performance Characteristics**: Extremely low memory footprint compared to full-canvas snapshot buffers.
class PixelDelta {
  /// Creates a [PixelDelta].
  const PixelDelta({
    required this.x,
    required this.y,
    required this.oldPixel,
    required this.newPixel,
    required this.layerIndex,
  });

  /// X coordinate.
  final int x;

  /// Y coordinate.
  final int y;

  /// Pixel state before command execution.
  final Pixel oldPixel;

  /// Pixel state after command execution.
  final Pixel newPixel;

  /// Layer stack index.
  final int layerIndex;
}
