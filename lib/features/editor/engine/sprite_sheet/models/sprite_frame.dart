import 'dart:typed_data';

import 'package:pixelcanvas/features/editor/engine/pixel.dart';
import 'package:pixelcanvas/features/editor/engine/selection/models/selection_bounds.dart';
import 'package:pixelcanvas/features/editor/engine/sprite_sheet/models/frame_metadata.dart';

/// Representation of an individual extracted or defined sprite frame.
///
/// **Purpose**: Pairs frame metadata with actual pixel buffer data and thumbnail cache.
/// **Architecture**: Pure Dart container — no framework dependencies.
class SpriteFrame {
  /// Creates a [SpriteFrame].
  SpriteFrame({
    required this.metadata,
    required this.bounds,
    required this.pixels,
    this.thumbnailBytes,
  });

  /// Frame metadata descriptor.
  FrameMetadata metadata;

  /// Bounding location within the sprite sheet or canvas.
  SelectionBounds bounds;

  /// 1D row-major pixel buffer (size = metadata.width × metadata.height).
  List<Pixel> pixels;

  /// Cached PNG thumbnail bytes for fast UI preview rendering.
  Uint8List? thumbnailBytes;

  /// Returns the pixel at local coordinates `(x, y)` within the frame buffer.
  Pixel getPixel(int x, int y) {
    if (x < 0 || x >= metadata.width || y < 0 || y >= metadata.height) {
      return Pixel.empty;
    }
    return pixels[(y * metadata.width) + x];
  }

  /// Sets the pixel at local coordinates `(x, y)`.
  void setPixel(int x, int y, Pixel pixel) {
    if (x >= 0 && x < metadata.width && y >= 0 && y < metadata.height) {
      pixels[(y * metadata.width) + x] = pixel;
      thumbnailBytes = null; // Invalidate cached thumbnail
    }
  }

  /// Clones this frame into a deep copy.
  SpriteFrame clone({String? newId, String? newName}) {
    return SpriteFrame(
      metadata: metadata.copyWith(
        id: newId ?? '${metadata.id}_copy',
        name: newName ?? '${metadata.name}_Copy',
      ),
      bounds: bounds,
      pixels: List<Pixel>.from(pixels),
      thumbnailBytes: thumbnailBytes,
    );
  }
}
