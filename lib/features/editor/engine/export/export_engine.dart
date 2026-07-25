import 'dart:typed_data';
import 'package:pixelcanvas/features/editor/engine/export/canvas_renderer.dart';
import 'package:pixelcanvas/features/editor/engine/export/models/export_job.dart';
import 'package:pixelcanvas/features/editor/engine/export/models/export_settings.dart';
import 'package:pixelcanvas/features/editor/engine/export/png_encoder_service.dart';
import 'package:pixelcanvas/features/editor/engine/pixel_buffer.dart';

/// Central Export Engine orchestrating the flattening-to-encoding pipeline per Blueprint §8.1.
///
/// **Purpose**: Coordinates canvas rendering, format encoding, and export job lifecycle.
/// **Pipeline**: CompositeBuffer → CanvasRenderer (RGBA) → PngEncoderService (PNG bytes).
/// **Future Formats**: Sprite sheet, GIF animation, APNG, native .pxc project files.
class ExportEngine {
  /// Exports the composited canvas buffer as PNG binary data.
  ///
  /// Returns PNG [Uint8List] on success, or `null` on encoding failure.
  static Future<Uint8List?> exportAsPng({
    required PixelBuffer compositeBuffer,
    ExportSettings settings = const ExportSettings(),
  }) async {
    final job = ExportJob(
      settings: settings,
      canvasWidth: compositeBuffer.width,
      canvasHeight: compositeBuffer.height,
    );
    job.markInProgress();

    // Step 1: Render composited buffer to raw RGBA bytes.
    final rgbaBytes = CanvasRenderer.renderToRgba(
      buffer: compositeBuffer,
      settings: settings,
    );

    // Step 2: Encode RGBA bytes to PNG.
    final pngBytes = await PngEncoderService.encode(
      pixelData: rgbaBytes,
      width: job.outputWidth,
      height: job.outputHeight,
    );

    if (pngBytes != null) {
      job.markCompleted();
    } else {
      job.markFailed();
    }

    return pngBytes;
  }

  /// Renders the composited buffer to raw RGBA bytes without encoding.
  ///
  /// Useful for preview thumbnails or further processing.
  static Uint8List renderFlattenedCanvas({
    required PixelBuffer compositeBuffer,
    ExportSettings settings = const ExportSettings(),
  }) {
    return CanvasRenderer.renderToRgba(
      buffer: compositeBuffer,
      settings: settings,
    );
  }
}
