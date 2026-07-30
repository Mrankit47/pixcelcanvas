import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/editor/engine/coordinate_transformer.dart';
import 'package:pixelcanvas/features/editor/engine/layer_buffer.dart';
import 'package:pixelcanvas/features/editor/engine/pixel.dart';

/// Iterative Flood Fill Algorithm Engine per Blueprint §8.1.
///
/// **Algorithm**: Queue-based 4-way contiguous BFS flood fill.
/// **Time Complexity**: `O(N)` where N is number of connected region pixels.
/// **Space Complexity**: `O(N)` queue size avoids call-stack overflow compared to recursive DFS.
class FloodFillEngine {
  /// Executes iterative queue-based flood fill starting at `(startX, startY)`.
  static void fill({
    required LayerBuffer layer,
    required int startX,
    required int startY,
    required Color fillColor,
  }) {
    if (layer.isLocked || !layer.isVisible) return;
    if (startX < 0 || startX >= layer.buffer.width || startY < 0 || startY >= layer.buffer.height) return;

    final targetPixel = layer.getPixel(startX, startY);
    final replacementPixel = Pixel(color: fillColor);

    // Skip if replacement color is identical to target color
    if (targetPixel.color.value == fillColor.value) return;

    final queue = Queue<Point<int>>();
    queue.add(Point(startX, startY));

    final visited = <int>{};
    final width = layer.buffer.width;

    while (queue.isNotEmpty) {
      final p = queue.removeFirst();
      final x = p.x;
      final y = p.y;

      final key = (y * width) + x;
      if (visited.contains(key)) continue;
      visited.add(key);

      final current = layer.getPixel(x, y);
      if (current.color.value != targetPixel.color.value) continue;

      layer.setPixel(x, y, replacementPixel);

      // 4-Way Neighbors
      if (x + 1 < layer.buffer.width) queue.add(Point(x + 1, y));
      if (x - 1 >= 0) queue.add(Point(x - 1, y));
      if (y + 1 < layer.buffer.height) queue.add(Point(x, y + 1));
      if (y - 1 >= 0) queue.add(Point(x, y - 1));
    }
  }
}
