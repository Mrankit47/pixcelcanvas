import 'dart:convert';

import 'package:pixelcanvas/features/editor/engine/canvas_engine.dart';

/// Serializes CanvasEngine state to JSON project representation (.pixelcanvas).
///
/// **Architecture Rules**: Excludes history stack to guarantee compact file payload sizes.
class ProjectSerializer {
  /// Serializes active state of [engine] into a formatted JSON string.
  static String serialize(CanvasEngine engine) {
    final layersData = engine.grid.layers.map((layer) {
      final pixelsHex = layer.pixels.map((p) => p.color.value).toList();
      return {
        'id': layer.id,
        'name': layer.name,
        'isVisible': layer.isVisible,
        'isLocked': layer.isLocked,
        'opacity': layer.opacity,
        'pixels': pixelsHex,
      };
    }).toList();

    final spriteSheet = engine.spriteSheetEngine.sheet;
    final spriteSheetData = spriteSheet == null
        ? null
        : {
            'id': spriteSheet.id,
            'name': spriteSheet.name,
            'width': spriteSheet.width,
            'height': spriteSheet.height,
            'activeFrameIndex': spriteSheet.activeFrameIndex,
            'frames': spriteSheet.frames.map((f) {
              return {
                'id': f.metadata.id,
                'name': f.metadata.name,
                'width': f.metadata.width,
                'height': f.metadata.height,
                'bounds': {
                  'left': f.bounds.left,
                  'top': f.bounds.top,
                  'right': f.bounds.right,
                  'bottom': f.bounds.bottom,
                },
                'pixels': f.pixels.map((p) => p.color.value).toList(),
              };
            }).toList(),
          };

    final animationClipsData = engine.animationEngine.timeline.clips.map((clip) {
      return {
        'id': clip.id,
        'name': clip.name,
        'fps': clip.fps,
        'loopMode': clip.loopMode.name,
        'playbackSpeed': clip.playbackSpeed,
        'frames': clip.frames.map((f) => f.toJson()).toList(),
      };
    }).toList();

    final jsonMap = {
      'version': '2.0.0',
      'app': 'PixelCanvas',
      'timestamp': DateTime.now().toIso8601String(),
      'width': engine.width,
      'height': engine.height,
      'activeLayerIndex': engine.session.activeLayerIndex,
      'layers': layersData,
      'brushSettings': {
        'size': engine.brushSettings.size,
        'opacity': engine.brushSettings.opacity,
        'colorHex': engine.session.activeColor.value.toRadixString(16),
      },
      'eraserSettings': {
        'size': engine.eraserSettings.size,
        'opacity': engine.eraserSettings.opacity,
      },
      'fillSettings': {
        'tolerance': engine.fillSettings.tolerance,
        'contiguous': engine.fillSettings.contiguous,
      },
      'spriteSheet': spriteSheetData,
      'animationClips': animationClipsData,
    };

    return const JsonEncoder.withIndent('  ').convert(jsonMap);
  }
}
