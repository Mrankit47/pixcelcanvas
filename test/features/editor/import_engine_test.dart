import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:pixelcanvas/features/editor/engine/import/models/import_settings.dart';
import 'package:pixelcanvas/features/editor/engine/import/tools/image_decoder.dart';

void main() {
  group('ImportEngine Tests', () {
    test('ImageDecoder validates invalid header bytes gracefully', () {
      final invalidBytes = Uint8List.fromList([0, 1, 2, 3, 4]);
      final result = ImageDecoder.decodePng(invalidBytes);

      expect(result.isValid, isFalse);
      expect(result.errorMessage, contains('Invalid PNG file signature'));
    });

    test('ImportSettings default configuration values', () {
      const settings = ImportSettings();
      expect(settings.format, equals(ImageFormat.png));
      expect(settings.scaleMode, equals(ImportScaleMode.original));
      expect(settings.paletteMode, equals(ImportPaletteMode.unlimited));
      expect(settings.destination, equals(ImportDestination.newLayer));
    });
  });
}
