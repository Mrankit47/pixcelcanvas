import 'package:pixelcanvas/features/editor/engine/clipboard/clipboard_data.dart';
import 'package:pixelcanvas/features/editor/engine/layer_buffer.dart';
import 'package:pixelcanvas/features/editor/engine/pixel.dart';
import 'package:pixelcanvas/features/editor/engine/selection/models/selection_bounds.dart';

/// Engine-level clipboard state manager for copy/cut/paste operations.
///
/// **Purpose**: Extracts pixel data from a layer within selection bounds and
/// stores it for later paste operations. Holds at most one [ClipboardData]
/// at a time.
///
/// **Architecture**: Pure Dart — no Riverpod, Widgets, or framework dependencies.
/// Layer validation (locked/hidden) is performed by the caller (CanvasEngine).
class ClipboardManager {
  /// Current clipboard data, or null if empty.
  ClipboardData? _data;

  /// Returns the current clipboard data.
  ClipboardData? get data => _data;

  /// True if the clipboard contains data.
  bool get hasClipboardData => _data != null && _data!.isNotEmpty;

  /// Copies pixels from [layer] within [bounds] into the clipboard.
  ///
  /// Extracts only the pixels within the selection bounds. Does NOT modify
  /// the source layer.
  ///
  /// Returns the created [ClipboardData].
  ClipboardData copy({
    required LayerBuffer layer,
    required SelectionBounds bounds,
    required int layerIndex,
    required int canvasWidth,
    required int canvasHeight,
  }) {
    final regionWidth = bounds.right - bounds.left;
    final regionHeight = bounds.bottom - bounds.top;

    final pixels = <Pixel>[];
    for (var y = bounds.top; y < bounds.bottom; y++) {
      for (var x = bounds.left; x < bounds.right; x++) {
        pixels.add(layer.getPixel(x, y));
      }
    }

    _data = ClipboardData(
      pixels: pixels,
      width: regionWidth,
      height: regionHeight,
      sourceBounds: bounds,
      sourceLayerIndex: layerIndex,
      canvasWidth: canvasWidth,
      canvasHeight: canvasHeight,
      timestamp: DateTime.now(),
    );

    return _data!;
  }

  /// Copies pixels from [layer] within [bounds] for a cut operation.
  ///
  /// Same as [copy] — the actual clearing of source pixels is handled by
  /// [CutSelectionCommand] so it can be undone.
  ///
  /// Returns the created [ClipboardData].
  ClipboardData cut({
    required LayerBuffer layer,
    required SelectionBounds bounds,
    required int layerIndex,
    required int canvasWidth,
    required int canvasHeight,
  }) {
    return copy(
      layer: layer,
      bounds: bounds,
      layerIndex: layerIndex,
      canvasWidth: canvasWidth,
      canvasHeight: canvasHeight,
    );
  }

  /// Returns current clipboard data for paste, or null if empty.
  ClipboardData? paste() => _data;

  /// Clears the clipboard.
  void clear() {
    _data = null;
  }
}
