import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/editor/presentation/state/editor_state.dart';

/// Active drawing stroke session tracking container per Blueprint §8.1.
class DrawingSession {
  /// Creates a [DrawingSession].
  DrawingSession({
    this.activeColor = const Color(0xFF6C5CE7),
    this.activeTool = PixelTool.pencil,
    this.activeLayerIndex = 0,
  });

  /// Active drawing color.
  Color activeColor;

  /// Active drawing tool.
  PixelTool activeTool;

  /// Active target layer index.
  int activeLayerIndex;
}
