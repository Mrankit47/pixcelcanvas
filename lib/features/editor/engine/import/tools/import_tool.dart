import 'dart:math' as math;

import 'package:pixelcanvas/features/editor/engine/import/models/import_settings.dart';

/// Target dimensions result structure.
class ImportTargetDimensions {
  /// Creates an [ImportTargetDimensions].
  const ImportTargetDimensions(this.width, this.height);

  /// Target width in pixels.
  final int width;

  /// Target height in pixels.
  final int height;
}

/// Static helper utilities for image import calculations.
class ImportTool {
  /// Computes target `(width, height)` based on scaling mode and canvas dimensions.
  static ImportTargetDimensions computeTargetDimensions({
    required int sourceWidth,
    required int sourceHeight,
    required int canvasWidth,
    required int canvasHeight,
    required ImportSettings settings,
  }) {
    if (sourceWidth <= 0 || sourceHeight <= 0) {
      return ImportTargetDimensions(canvasWidth, canvasHeight);
    }

    switch (settings.scaleMode) {
      case ImportScaleMode.original:
        return ImportTargetDimensions(sourceWidth, sourceHeight);

      case ImportScaleMode.stretch:
        return ImportTargetDimensions(canvasWidth, canvasHeight);

      case ImportScaleMode.custom:
        final w = settings.customWidth ?? sourceWidth;
        final h = settings.customHeight ?? sourceHeight;
        return ImportTargetDimensions(
          w.clamp(1, 4096),
          h.clamp(1, 4096),
        );

      case ImportScaleMode.fitCanvas:
        final scaleX = canvasWidth / sourceWidth;
        final scaleY = canvasHeight / sourceHeight;
        final scale = math.min(scaleX, scaleY);
        final w = math.max(1, (sourceWidth * scale).round());
        final h = math.max(1, (sourceHeight * scale).round());
        return ImportTargetDimensions(w, h);

      case ImportScaleMode.fillCanvas:
        final scaleX = canvasWidth / sourceWidth;
        final scaleY = canvasHeight / sourceHeight;
        final scale = math.max(scaleX, scaleY);
        final w = math.max(1, (sourceWidth * scale).round());
        final h = math.max(1, (sourceHeight * scale).round());
        return ImportTargetDimensions(w, h);
    }
  }

  /// Calculates estimated memory footprint in bytes for a `width × height` RGBA buffer.
  static int estimateMemoryBytes(int width, int height) {
    // 4 bytes per pixel (RGBA) + object wrapper overhead
    return (width * height * 4) + 1024;
  }
}
