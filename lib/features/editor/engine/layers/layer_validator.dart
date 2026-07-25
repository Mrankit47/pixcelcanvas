import 'package:pixelcanvas/features/editor/engine/layer_buffer.dart';

/// Layer state validation engine per Blueprint §8.1.
///
/// **Purpose**: Guards layer operations against invalid state transitions.
class LayerValidator {
  /// Validates that at least one layer remains after deletion.
  static bool canDelete(List<LayerBuffer> layers) {
    return layers.length > 1;
  }

  /// Validates that layer index is within bounds for selection.
  static bool isValidIndex(List<LayerBuffer> layers, int index) {
    return index >= 0 && index < layers.length;
  }

  /// Validates that a merge-down target exists below the source layer.
  static bool canMergeDown(List<LayerBuffer> layers, int sourceIndex) {
    return sourceIndex > 0 && sourceIndex < layers.length;
  }

  /// Validates that a layer can be moved up in the stack.
  static bool canMoveUp(List<LayerBuffer> layers, int index) {
    return index >= 0 && index < layers.length - 1;
  }

  /// Validates that a layer can be moved down in the stack.
  static bool canMoveDown(List<LayerBuffer> layers, int index) {
    return index > 0 && index < layers.length;
  }

  /// Validates that the layer count has not exceeded the maximum (100).
  static bool canCreateLayer(List<LayerBuffer> layers, {int maxLayers = 100}) {
    return layers.length < maxLayers;
  }
}
