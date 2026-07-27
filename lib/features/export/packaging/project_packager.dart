import 'dart:convert';
import 'package:pixelcanvas/features/editor/engine/canvas_engine.dart';

/// Service creating distribution packages (.pixelcanvas manifest).
class ProjectPackager {
  /// Generates distribution package JSON manifest map for [engine].
  static Map<String, dynamic> generateManifest({
    required String projectName,
    required CanvasEngine engine,
  }) {
    final now = DateTime.now();

    return {
      'packageFormat': 'PixelCanvas.DistributionPackage',
      'version': '2.0.0',
      'createdDate': now.toIso8601String(),
      'project': {
        'name': projectName,
        'width': engine.width,
        'height': engine.height,
        'layerCount': engine.grid.layers.length,
        'clipCount': engine.animationEngine.timeline.clips.length,
      },
      'layersManifest': engine.grid.layers.map((l) {
        return {
          'id': l.id,
          'name': l.name,
          'opacity': l.opacity,
          'isVisible': l.isVisible,
        };
      }).toList(),
      'checksum': 'sha256_placeholder_${now.millisecondsSinceEpoch}',
    };
  }

  /// Exports manifest to JSON string.
  static String exportManifestJson({
    required String projectName,
    required CanvasEngine engine,
  }) {
    final map = generateManifest(projectName: projectName, engine: engine);
    return const JsonEncoder.withIndent('  ').convert(map);
  }
}
