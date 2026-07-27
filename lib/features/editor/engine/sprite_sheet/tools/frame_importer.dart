import 'dart:convert';
import 'dart:typed_data';

import 'package:pixelcanvas/features/editor/engine/import/tools/image_decoder.dart';
import 'package:pixelcanvas/features/editor/engine/import/tools/pixel_converter.dart';
import 'package:pixelcanvas/features/editor/engine/sprite_sheet/models/frame_metadata.dart';
import 'package:pixelcanvas/features/editor/engine/sprite_sheet/models/sprite_sheet.dart';
import 'package:pixelcanvas/features/editor/engine/sprite_sheet/models/sprite_sheet_settings.dart';
import 'package:pixelcanvas/features/editor/engine/sprite_sheet/tools/frame_grid_slicer.dart';

/// Importer for Sprite Sheet image binary data and JSON metadata files.
class FrameImporter {
  /// Decodes [imageBytes] into a [SpriteSheet], performing automatic grid slicing with [settings].
  static SpriteSheet? importFromPngBytes({
    required Uint8List imageBytes,
    required String id,
    required String name,
    SpriteSheetSettings settings = const SpriteSheetSettings(),
  }) {
    final decodedResult = ImageDecoder.decodePng(imageBytes);
    if (!decodedResult.isValid || decodedResult.image == null) {
      return null;
    }

    final decoded = decodedResult.image!;
    final sheetPixels = PixelConverter.convertAndScale(
      decoded: decoded,
      targetWidth: decoded.width,
      targetHeight: decoded.height,
    );

    final sheet = SpriteSheet(
      id: id,
      name: name,
      width: decoded.width,
      height: decoded.height,
      settings: settings,
    );

    final slicedFrames = FrameGridSlicer.sliceGrid(
      sheetPixels: sheetPixels,
      sheetWidth: decoded.width,
      sheetHeight: decoded.height,
      settings: settings,
    );

    sheet.frames.addAll(slicedFrames);
    return sheet;
  }

  /// Parses JSON metadata string into a list of [FrameMetadata] objects.
  static List<FrameMetadata> parseJsonMetadata(String jsonString) {
    final metadatas = <FrameMetadata>[];
    try {
      final decoded = json.decode(jsonString);
      if (decoded is Map<String, dynamic> && decoded.containsKey('frames')) {
        final framesList = decoded['frames'];
        if (framesList is List) {
          for (var i = 0; i < framesList.length; i++) {
            final item = framesList[i];
            if (item is Map<String, dynamic>) {
              metadatas.add(FrameMetadata(
                id: item['id'] ?? 'frame_$i',
                name: item['name'] ?? 'Frame_$i',
                width: item['width'] ?? 32,
                height: item['height'] ?? 32,
                originX: item['originX'] ?? 0,
                originY: item['originY'] ?? 0,
                durationMs: item['durationMs'] ?? 100,
              ));
            }
          }
        }
      }
    } catch (_) {
      // Ignored: returns empty metadatas on parse failure
    }
    return metadatas;
  }
}
