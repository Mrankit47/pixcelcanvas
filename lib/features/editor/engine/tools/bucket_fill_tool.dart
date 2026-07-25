import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/editor/engine/fill/flood_fill_engine.dart';
import 'package:pixelcanvas/features/editor/engine/layer_buffer.dart';

/// Bucket Fill (Flood Fill) Tool per Blueprint §8.1.
class BucketFillTool {
  /// Executes flood fill on target [layer] starting at `(startX, startY)` with [fillColor].
  static void execute({
    required LayerBuffer layer,
    required int startX,
    required int startY,
    required Color fillColor,
  }) {
    FloodFillEngine.fill(
      layer: layer,
      startX: startX,
      startY: startY,
      fillColor: fillColor,
    );
  }
}
