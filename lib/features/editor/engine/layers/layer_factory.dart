import 'package:pixelcanvas/features/editor/engine/layer_buffer.dart';

/// Factory producing [LayerBuffer] instances per Blueprint §8.1.
///
/// **Purpose**: Centralised layer creation with auto-incrementing IDs and names.
/// **Future Extensions**: Layer from template, layer from clipboard, layer from imported image.
class LayerFactory {
  int _counter = 1;

  /// Creates a new [LayerBuffer] with auto-assigned id and name.
  LayerBuffer create({
    required int width,
    required int height,
    String? id,
    String? name,
    int index = 0,
  }) {
    final layerId = id ?? 'layer_${_counter}';
    final layerName = name ?? 'Layer ${_counter}';
    _counter++;

    return LayerBuffer(
      id: layerId,
      name: layerName,
      width: width,
      height: height,
      index: index,
    );
  }

  /// Duplicates an existing [LayerBuffer] pixel data into a new layer.
  LayerBuffer duplicate({
    required LayerBuffer source,
    required int width,
    required int height,
  }) {
    final copy = create(
      width: width,
      height: height,
      name: '${source.name} Copy',
      index: source.index + 1,
    );

    // Copy pixel data
    for (var y = 0; y < height; y++) {
      for (var x = 0; x < width; x++) {
        final pixel = source.getPixel(x, y);
        if (!pixel.isEmpty) {
          copy.setPixel(x, y, pixel);
        }
      }
    }

    copy.isVisible = source.isVisible;
    copy.opacity = source.opacity;

    return copy;
  }
}
