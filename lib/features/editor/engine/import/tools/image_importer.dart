import 'dart:typed_data';

import 'package:pixelcanvas/features/editor/engine/import/models/import_preview.dart';
import 'package:pixelcanvas/features/editor/engine/import/models/import_settings.dart';
import 'package:pixelcanvas/features/editor/engine/import/tools/image_decoder.dart';
import 'package:pixelcanvas/features/editor/engine/import/tools/import_tool.dart';
import 'package:pixelcanvas/features/editor/engine/import/tools/palette_reducer.dart';
import 'package:pixelcanvas/features/editor/engine/import/tools/pixel_converter.dart';

/// High-level pipeline orchestrator executing Decode → Scale → Quantize → Convert.
///
/// **Architecture Rules**: Pure Dart pipeline — zero dependencies on Riverpod or Widgets.
class ImageImporter {
  /// Processes raw image [bytes] with [settings] and active [canvasWidth] × [canvasHeight].
  ///
  /// Returns an [ImportPreview] snapshot containing converted pixels or error diagnostics.
  static ImportPreview processImport({
    required Uint8List bytes,
    required ImportSettings settings,
    required int canvasWidth,
    required int canvasHeight,
  }) {
    // 1. Decode image bytes
    final decodedResult = ImageDecoder.decodePng(bytes);
    if (!decodedResult.isValid || decodedResult.image == null) {
      return ImportPreview(
        sourceWidth: 0,
        sourceHeight: 0,
        targetWidth: 0,
        targetHeight: 0,
        canvasWidth: canvasWidth,
        canvasHeight: canvasHeight,
        settings: settings,
        pixels: const [],
        estimatedMemoryBytes: 0,
        isCorrupted: true,
        errorMessage: decodedResult.errorMessage ?? 'Invalid image data',
      );
    }

    final decoded = decodedResult.image!;

    // 2. Compute target scaled dimensions
    final targetDims = ImportTool.computeTargetDimensions(
      sourceWidth: decoded.width,
      sourceHeight: decoded.height,
      canvasWidth: canvasWidth,
      canvasHeight: canvasHeight,
      settings: settings,
    );

    // 3. Convert RGBA and apply nearest-neighbor scaling
    final rawPixels = PixelConverter.convertAndScale(
      decoded: decoded,
      targetWidth: targetDims.width,
      targetHeight: targetDims.height,
      preserveTransparency: settings.preserveTransparency,
    );

    // 4. Apply palette reduction & dithering if configured
    final finalPixels = PaletteReducer.reducePalette(
      pixels: rawPixels,
      width: targetDims.width,
      height: targetDims.height,
      paletteMode: settings.paletteMode,
      ditherMode: settings.ditherMode,
    );

    // 5. Estimate memory footprint
    final estimatedMemory = ImportTool.estimateMemoryBytes(
      targetDims.width,
      targetDims.height,
    );

    return ImportPreview(
      sourceWidth: decoded.width,
      sourceHeight: decoded.height,
      targetWidth: targetDims.width,
      targetHeight: targetDims.height,
      canvasWidth: canvasWidth,
      canvasHeight: canvasHeight,
      settings: settings,
      pixels: finalPixels,
      estimatedMemoryBytes: estimatedMemory,
      isCorrupted: false,
    );
  }
}
