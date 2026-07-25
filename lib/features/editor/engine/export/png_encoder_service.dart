import 'dart:typed_data';
import 'dart:ui' as ui;

/// PNG encoding service per Blueprint §8.1.
///
/// **Purpose**: Encodes raw RGBA byte buffer into valid PNG binary data using Flutter's `dart:ui`.
/// **Encoding Flow**: RGBA `Uint8List` → `ui.ImmutableBuffer` → `ui.ImageDescriptor` → `ui.Image` → PNG bytes.
/// **Pixel Preservation**: No smoothing, no interpolation — nearest-neighbour pixel integrity preserved.
/// **Memory Usage**: Temporary `ui.Image` allocated during encoding, released immediately after.
class PngEncoderService {
  /// Encodes raw RGBA [pixelData] of [width]×[height] into PNG binary bytes.
  ///
  /// Returns `null` if encoding fails.
  static Future<Uint8List?> encode({
    required Uint8List pixelData,
    required int width,
    required int height,
  }) async {
    try {
      final buffer = await ui.ImmutableBuffer.fromUint8List(pixelData);
      final descriptor = ui.ImageDescriptor.raw(
        buffer,
        width: width,
        height: height,
        pixelFormat: ui.PixelFormat.rgba8888,
      );

      final codec = await descriptor.instantiateCodec();
      final frame = await codec.getNextFrame();
      final image = frame.image;

      final byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );

      image.dispose();
      codec.dispose();
      descriptor.dispose();
      buffer.dispose();

      return byteData?.buffer.asUint8List();
    } catch (_) {
      return null;
    }
  }
}
