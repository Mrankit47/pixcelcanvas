import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:pixelcanvas/features/editor/engine/animation/models/animation_clip.dart';
import 'package:pixelcanvas/features/editor/engine/animation/models/animation_frame.dart';
import 'package:pixelcanvas/features/editor/engine/animation/models/loop_mode.dart';
import 'package:pixelcanvas/features/editor/engine/canvas_engine.dart';
import 'package:pixelcanvas/features/editor/engine/layer_buffer.dart';
import 'package:pixelcanvas/features/editor/engine/models/brush_settings.dart';
import 'package:pixelcanvas/features/editor/engine/models/eraser_settings.dart';
import 'package:pixelcanvas/features/editor/engine/models/fill_settings.dart';
import 'package:pixelcanvas/features/editor/engine/pixel.dart';
import 'package:pixelcanvas/features/editor/engine/selection/models/selection_bounds.dart';
import 'package:pixelcanvas/features/editor/engine/sprite_sheet/models/frame_metadata.dart';
import 'package:pixelcanvas/features/editor/engine/sprite_sheet/models/sprite_frame.dart';
import 'package:pixelcanvas/features/editor/engine/sprite_sheet/models/sprite_sheet.dart';

/// Deserializes JSON project data (.pixelcanvas) into CanvasEngine.
class ProjectDeserializer {
  /// Deserializes [jsonString] and loads state into [engine].
  static bool deserialize(String jsonString, CanvasEngine engine) {
    try {
      final decoded = json.decode(jsonString);
      if (decoded is! Map<String, dynamic>) return false;

      final width = decoded['width'] as int? ?? 32;
      final height = decoded['height'] as int? ?? 32;

      engine.resizeCanvas(width, height);
      engine.grid.layers.clear();

      // 1. Restore Layers
      if (decoded.containsKey('layers') && decoded['layers'] is List) {
        final layersList = decoded['layers'] as List;
        for (var i = 0; i < layersList.length; i++) {
          final lMap = layersList[i] as Map<String, dynamic>;
          final layer = LayerBuffer(
            id: lMap['id'] ?? 'layer_$i',
            name: lMap['name'] ?? 'Layer $i',
            width: width,
            height: height,
            isVisible: lMap['isVisible'] ?? true,
            isLocked: lMap['isLocked'] ?? false,
            opacity: (lMap['opacity'] as num?)?.toDouble() ?? 1.0,
          );

          if (lMap.containsKey('pixels') && lMap['pixels'] is List) {
            final pixelsList = lMap['pixels'] as List;
            for (var pIdx = 0; pIdx < pixelsList.length && pIdx < width * height; pIdx++) {
              final argb = pixelsList[pIdx] as int;
              if (argb != 0) {
                final x = pIdx % width;
                final y = pIdx ~/ width;
                layer.setPixel(x, y, Pixel(color: Color(argb)));
              }
            }
          }

          engine.grid.layers.add(layer);
        }
      }

      if (engine.grid.layers.isEmpty) {
        engine.createLayer();
      }

      final activeLayerIdx = (decoded['activeLayerIndex'] as int? ?? 0)
          .clamp(0, engine.grid.layers.length - 1);
      engine.session.activeLayerIndex = activeLayerIdx;

      // 2. Restore Tool Settings
      if (decoded.containsKey('brushSettings')) {
        final bMap = decoded['brushSettings'] as Map<String, dynamic>;
        engine.brushSettings = BrushSettings(
          size: bMap['size'] ?? 1,
          opacity: (bMap['opacity'] as num?)?.toDouble() ?? 1.0,
        );
      }

      if (decoded.containsKey('eraserSettings')) {
        final eMap = decoded['eraserSettings'] as Map<String, dynamic>;
        engine.eraserSettings = EraserSettings(
          size: eMap['size'] ?? 1,
          opacity: (eMap['opacity'] as num?)?.toDouble() ?? 1.0,
        );
      }

      if (decoded.containsKey('fillSettings')) {
        final fMap = decoded['fillSettings'] as Map<String, dynamic>;
        engine.fillSettings = FillSettings(
          tolerance: fMap['tolerance'] ?? 0,
          contiguous: fMap['contiguous'] ?? true,
        );
      }

      // 3. Restore Sprite Sheet
      if (decoded.containsKey('spriteSheet') && decoded['spriteSheet'] != null) {
        final sMap = decoded['spriteSheet'] as Map<String, dynamic>;
        final sheet = SpriteSheet(
          id: sMap['id'] ?? 'sheet_0',
          name: sMap['name'] ?? 'SpriteSheet',
          width: sMap['width'] ?? width,
          height: sMap['height'] ?? height,
          activeFrameIndex: sMap['activeFrameIndex'] ?? 0,
        );

        if (sMap.containsKey('frames') && sMap['frames'] is List) {
          final fList = sMap['frames'] as List;
          for (final fMap in fList) {
            if (fMap is Map<String, dynamic>) {
              final fW = fMap['width'] ?? 32;
              final fH = fMap['height'] ?? 32;
              final bMap = fMap['bounds'] as Map<String, dynamic>? ?? {};

              final bounds = SelectionBounds(
                left: bMap['left'] ?? 0,
                top: bMap['top'] ?? 0,
                right: bMap['right'] ?? fW,
                bottom: bMap['bottom'] ?? fH,
              );

              final fPixels = List<Pixel>.filled(fW * fH, Pixel.empty);
              if (fMap.containsKey('pixels') && fMap['pixels'] is List) {
                final pxList = fMap['pixels'] as List;
                for (var pIdx = 0; pIdx < pxList.length && pIdx < fW * fH; pIdx++) {
                  final argb = pxList[pIdx] as int;
                  if (argb != 0) {
                    fPixels[pIdx] = Pixel(color: Color(argb));
                  }
                }
              }

              final sFrame = SpriteFrame(
                metadata: FrameMetadata(
                  id: fMap['id'] ?? 'frame_0',
                  name: fMap['name'] ?? 'Frame_0',
                  width: fW,
                  height: fH,
                ),
                bounds: bounds,
                pixels: fPixels,
              );

              sheet.frames.add(sFrame);
            }
          }
        }

        engine.spriteSheetEngine.importSpriteSheet(
          bytes: Uint8List(0), // Raw bytes unneeded when frames are parsed
          id: sheet.id,
          name: sheet.name,
        );
        engine.spriteSheetEngine.sheet?.frames.clear();
        engine.spriteSheetEngine.sheet?.frames.addAll(sheet.frames);
        engine.spriteSheetEngine.sheet?.activeFrameIndex = sheet.activeFrameIndex;
      }

      // 4. Restore Animation Clips
      if (decoded.containsKey('animationClips') && decoded['animationClips'] is List) {
        final cList = decoded['animationClips'] as List;
        engine.animationEngine.timeline.clips.clear();

        for (final cMap in cList) {
          if (cMap is Map<String, dynamic>) {
            final cId = cMap['id'] ?? 'clip_0';
            final cName = cMap['name'] ?? 'Clip';
            final cFps = cMap['fps'] ?? 12;
            final cSpeed = (cMap['playbackSpeed'] as num?)?.toDouble() ?? 1.0;
            final loopStr = cMap['loopMode'] ?? 'loop';

            final loopMode = LoopMode.values.firstWhere(
              (m) => m.name == loopStr,
              orElse: () => LoopMode.loop,
            );

            final aFrames = <AnimationFrame>[];
            if (cMap.containsKey('frames') && cMap['frames'] is List) {
              final aList = cMap['frames'] as List;
              for (final fMap in aList) {
                if (fMap is Map<String, dynamic>) {
                  aFrames.add(AnimationFrame(
                    id: fMap['id'] ?? 'a_frame_0',
                    spriteFrameId: fMap['spriteFrameId'],
                    durationMs: fMap['durationMs'] ?? 100,
                    fpsOverride: fMap['fpsOverride'],
                  ));
                }
              }
            }

            engine.animationEngine.timeline.clips.add(AnimationClip(
              id: cId,
              name: cName,
              fps: cFps,
              loopMode: loopMode,
              playbackSpeed: cSpeed,
              frames: aFrames,
            ));
          }
        }

        if (engine.animationEngine.timeline.clips.isEmpty) {
          engine.animationEngine.createAnimation('Idle');
        } else {
          engine.animationEngine.timeline.activeClipIndex = 0;
        }
      }

      engine.historyManager.clearHistory();
      engine.compositeVisibleLayers();
      return true;
    } catch (_) {
      return false;
    }
  }
}
