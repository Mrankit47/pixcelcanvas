import 'dart:convert';
import 'dart:typed_data';
import 'package:image/image.dart' as img;

import 'package:pixelcanvas/features/editor/engine/sprite_sheet/models/sprite_sheet.dart';

/// Supported JSON export formats for sprite sheet metadata.
enum SpriteSheetJsonFormat {
  /// Standard PixelCanvas JSON schema.
  standard,

  /// Aseprite JSON hash/array format (future-ready placeholder).
  aseprite,

  /// TexturePacker JSON array format (future-ready placeholder).
  texturePacker,
}

/// Exporter for Sprite Sheet packed PNG images, individual frame PNGs, and JSON metadata.
class FrameExporter {
  /// Packs all frames of [sheet] into a single PNG sprite sheet byte array.
  static Uint8List exportSpriteSheetPng(SpriteSheet sheet) {
    final w = sheet.width > 0 ? sheet.width : 32;
    final h = sheet.height > 0 ? sheet.height : 32;

    final imgSheet = img.Image(width: w, height: h);

    for (final frame in sheet.frames) {
      final originX = frame.bounds.left;
      final originY = frame.bounds.top;

      for (var y = 0; y < frame.metadata.height; y++) {
        for (var x = 0; x < frame.metadata.width; x++) {
          final px = frame.getPixel(x, y);
          if (!px.isEmpty) {
            final canvasX = originX + x;
            final canvasY = originY + y;
            if (canvasX >= 0 && canvasX < w && canvasY >= 0 && canvasY < h) {
              final r = (px.color.r * 255).round();
              final g = (px.color.g * 255).round();
              final b = (px.color.b * 255).round();
              final a = (px.color.a * 255 * px.opacity).round();
              imgSheet.setPixelRgba(canvasX, canvasY, r, g, b, a);
            }
          }
        }
      }
    }

    return Uint8List.fromList(img.encodePng(imgSheet));
  }

  /// Exports each frame of [sheet] as an individual PNG binary data entry in a Map.
  static Map<String, Uint8List> exportIndividualFramePngs(SpriteSheet sheet) {
    final result = <String, Uint8List>{};

    for (final frame in sheet.frames) {
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

      result[frame.metadata.name] = Uint8List.fromList(img.encodePng(imgFrame));
    }

    return result;
  }

  /// Generates JSON metadata representation for [sheet].
  static String exportJsonMetadata(
    SpriteSheet sheet, {
    SpriteSheetJsonFormat format = SpriteSheetJsonFormat.standard,
  }) {
    final framesData = sheet.frames.map((f) {
      return {
        'filename': '${f.metadata.name}.png',
        'frame': {
          'x': f.bounds.left,
          'y': f.bounds.top,
          'w': f.metadata.width,
          'h': f.metadata.height,
        },
        'rotated': false,
        'trimmed': false,
        'spriteSourceSize': {
          'x': 0,
          'y': 0,
          'w': f.metadata.width,
          'h': f.metadata.height,
        },
        'sourceSize': {
          'w': f.metadata.width,
          'h': f.metadata.height,
        },
        'duration': f.metadata.durationMs,
        'tags': f.metadata.tags.map((t) => t.name).toList(),
      };
    }).toList();

    final meta = {
      'app': 'PixelCanvas',
      'version': '1.0.0',
      'image': '${sheet.name}.png',
      'format': 'RGBA8888',
      'size': {'w': sheet.width, 'h': sheet.height},
      'scale': '1',
      'frameTags': [],
    };

    final jsonMap = {
      'frames': framesData,
      'meta': meta,
    };

    return const JsonEncoder.withIndent('  ').convert(jsonMap);
  }
}
