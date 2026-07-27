import 'dart:convert';
import 'dart:typed_data';
import 'package:image/image.dart' as img;

import 'package:pixelcanvas/features/editor/engine/animation/models/animation_clip.dart';

/// Exporter for Animation Clips into packed sprite sheets, frame sequences, and JSON metadata.
class AnimationExporter {
  /// Exports all frames in [clip] as a packed PNG sprite sheet byte array.
  static Uint8List exportAnimatedSpriteSheetPng({
    required AnimationClip clip,
    required int frameWidth,
    required int frameHeight,
  }) {
    if (clip.frames.isEmpty) {
      final emptyImg = img.Image(width: 32, height: 32);
      return Uint8List.fromList(img.encodePng(emptyImg));
    }

    final totalFrames = clip.frameCount;
    final columns = totalFrames; // Horizontal strip packing
    final sheetW = columns * frameWidth;
    final sheetH = frameHeight;

    final sheetImg = img.Image(width: sheetW, height: sheetH);

    for (var i = 0; i < totalFrames; i++) {
      final frame = clip.frames[i];
      final originX = i * frameWidth;

      for (var y = 0; y < frameHeight; y++) {
        for (var x = 0; x < frameWidth; x++) {
          final idx = (y * frameWidth) + x;
          if (idx < frame.pixels.length) {
            final px = frame.pixels[idx];
            if (!px.isEmpty) {
              final r = (px.color.r * 255).round();
              final g = (px.color.g * 255).round();
              final b = (px.color.b * 255).round();
              final a = (px.color.a * 255 * px.opacity).round();
              sheetImg.setPixelRgba(originX + x, y, r, g, b, a);
            }
          }
        }
      }
    }

    return Uint8List.fromList(img.encodePng(sheetImg));
  }

  /// Exports each frame in [clip] as an individual PNG byte array in a Map.
  static Map<String, Uint8List> exportFrameSequencePngs({
    required AnimationClip clip,
    required int frameWidth,
    required int frameHeight,
  }) {
    final result = <String, Uint8List>{};

    for (var i = 0; i < clip.frameCount; i++) {
      final frame = clip.frames[i];
      final frameImg = img.Image(width: frameWidth, height: frameHeight);

      for (var y = 0; y < frameHeight; y++) {
        for (var x = 0; x < frameWidth; x++) {
          final idx = (y * frameWidth) + x;
          if (idx < frame.pixels.length) {
            final px = frame.pixels[idx];
            if (!px.isEmpty) {
              final r = (px.color.r * 255).round();
              final g = (px.color.g * 255).round();
              final b = (px.color.b * 255).round();
              final a = (px.color.a * 255 * px.opacity).round();
              frameImg.setPixelRgba(x, y, r, g, b, a);
            }
          }
        }
      }

      final fileName = '${clip.name}_${i.toString().padLeft(3, '0')}.png';
      result[fileName] = Uint8List.fromList(img.encodePng(frameImg));
    }

    return result;
  }

  /// Generates JSON animation metadata for [clip].
  static String exportJsonMetadata(AnimationClip clip) {
    final framesData = clip.frames.map((f) => f.toJson()).toList();
    final jsonMap = {
      'clipId': clip.id,
      'name': clip.name,
      'fps': clip.fps,
      'loopMode': clip.loopMode.name,
      'playbackSpeed': clip.playbackSpeed,
      'frameCount': clip.frameCount,
      'totalDurationMs': clip.totalDurationMs,
      'frames': framesData,
    };
    return const JsonEncoder.withIndent('  ').convert(jsonMap);
  }

  /// Placeholder for GIF export (future extension).
  static Uint8List? exportGifPlaceholder(AnimationClip clip) => null;

  /// Placeholder for APNG export (future extension).
  static Uint8List? exportApngPlaceholder(AnimationClip clip) => null;

  /// Placeholder for Video export (future extension).
  static Uint8List? exportVideoPlaceholder(AnimationClip clip) => null;
}
