import 'dart:typed_data';
import 'package:image/image.dart' as img;

/// Result record returned by [ImageDecoder.decodePng].
class DecodedImageResult {
  /// Creates a [DecodedImageResult].
  const DecodedImageResult({
    required this.image,
    required this.width,
    required this.height,
    this.isValid = true,
    this.errorMessage,
  });

  /// Creates a corrupted/failed [DecodedImageResult].
  factory DecodedImageResult.failure(String message) {
    return DecodedImageResult(
      image: null,
      width: 0,
      height: 0,
      isValid: false,
      errorMessage: message,
    );
  }

  /// Decoded `image` package image object, or null on failure.
  final img.Image? image;

  /// Decoded image width in pixels.
  final int width;

  /// Decoded image height in pixels.
  final int height;

  /// True if decoding succeeded.
  final bool isValid;

  /// Diagnostic error message on failure.
  final String? errorMessage;
}

/// PNG Image decoder using byte header validation and `package:image`.
///
/// **Architecture Rules**: Pure Dart decoder — no framework or widget dependencies.
class ImageDecoder {
  /// Standard 8-byte PNG header magic sequence.
  static const List<int> _pngMagicHeader = [
    0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A
  ];

  /// Decodes [bytes] into a [DecodedImageResult].
  ///
  /// Validates magic header, detects corrupted binary streams, and extracts RGBA pixels.
  static DecodedImageResult decodePng(Uint8List bytes) {
    if (bytes.length < 8) {
      return DecodedImageResult.failure('File is too small to be a valid PNG');
    }

    // Validate PNG magic header bytes
    for (var i = 0; i < 8; i++) {
      if (bytes[i] != _pngMagicHeader[i]) {
        return DecodedImageResult.failure(
          'Invalid file format: Missing PNG header magic signature',
        );
      }
    }

    try {
      final decoded = img.decodePng(bytes);
      if (decoded == null) {
        return DecodedImageResult.failure('Failed to decode PNG image data');
      }

      return DecodedImageResult(
        image: decoded,
        width: decoded.width,
        height: decoded.height,
      );
    } catch (e) {
      return DecodedImageResult.failure('Corrupted PNG file: ${e.toString()}');
    }
  }
}
