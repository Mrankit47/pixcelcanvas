import 'dart:convert';

import 'package:pixelcanvas/features/editor/engine/animation/models/animation_clip.dart';
import 'package:pixelcanvas/features/editor/engine/animation/models/animation_frame.dart';
import 'package:pixelcanvas/features/editor/engine/animation/models/loop_mode.dart';

/// Importer for parsing animation clip structure from JSON metadata.
class AnimationImporter {
  /// Parses [jsonString] into an [AnimationClip], or returns null on failure.
  static AnimationClip? importFromJson(String jsonString) {
    try {
      final decoded = json.decode(jsonString);
      if (decoded is Map<String, dynamic>) {
        final id = decoded['clipId'] ?? 'clip_${DateTime.now().millisecondsSinceEpoch}';
        final name = decoded['name'] ?? 'ImportedClip';
        final fps = decoded['fps'] ?? 12;
        final speed = (decoded['playbackSpeed'] as num?)?.toDouble() ?? 1.0;
        final loopModeStr = decoded['loopMode'] ?? 'loop';

        final loopMode = LoopMode.values.firstWhere(
          (m) => m.name == loopModeStr,
          orElse: () => LoopMode.loop,
        );

        final frames = <AnimationFrame>[];
        if (decoded.containsKey('frames') && decoded['frames'] is List) {
          final framesList = decoded['frames'] as List;
          for (var i = 0; i < framesList.length; i++) {
            final item = framesList[i];
            if (item is Map<String, dynamic>) {
              frames.add(AnimationFrame(
                id: item['id'] ?? 'frame_$i',
                spriteFrameId: item['spriteFrameId'],
                durationMs: item['durationMs'] ?? 100,
                fpsOverride: item['fpsOverride'],
              ));
            }
          }
        }

        return AnimationClip(
          id: id,
          name: name,
          fps: fps,
          loopMode: loopMode,
          playbackSpeed: speed,
          frames: frames,
        );
      }
    } catch (_) {
      // Ignored: returns null on parse failure
    }
    return null;
  }
}
