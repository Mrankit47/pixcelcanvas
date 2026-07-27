import 'dart:typed_data';
import 'package:image/image.dart' as img;

import 'package:pixelcanvas/features/editor/engine/sprite_sheet/models/sprite_frame.dart';

/// Thumbnail generator and renderer for sprite frames.
///
/// **Purpose**: Generates and caches PNG thumbnail previews for UI preview strips.
/// **Architecture**: Pure static methods — no state, no framework dependencies.
class FrameRenderer {
  /// Returns cached thumbnail PNG bytes for [frame], generating it lazily if absent.
  static Uint8List getThumbnail(SpriteFrame frame) {
    if (frame.thumbnailBytes != null) {
      return frame.thumbnailBytes!;
    }

    final w = frame.metadata.width;
    final h = frame.metadata.height;
    final imgFrame = img.Image(width: w, height: h);

    for (var y = 0; y < h; y++) {
      for (var x = 0; x < w; x++) {
        final px = frame.getPixel(x, y);
        if (!px.isEmpty) {
          final r = (px.color.r * 255).round();
          final g = (px.color.g * 255).round();
          final b = (px.color.b * 255).round();
          final a = (px.color.a * 255 * px.opacity).round();
          imgFrame.setPixelRgba(x, y, r, g, b, a);
        }
      }
    }

    final bytes = Uint8List.fromList(img.encodePng(imgFrame));
    frame.thumbnailBytes = bytes;
    return bytes;
  }
}
