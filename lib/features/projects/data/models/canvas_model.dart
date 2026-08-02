import 'package:pixelcanvas/features/projects/data/models/layer_model.dart';

/// Local Data Model for Canvas Entity.
class CanvasModel {
  /// Creates a [CanvasModel].
  CanvasModel({
    this.uuid = '',
    this.width = 32,
    this.height = 32,
    this.layers = const [],
  });

  /// Canvas UUID.
  String uuid;

  /// Width in pixels.
  int width;

  /// Height in pixels.
  int height;

  /// Embedded layers stack list.
  List<LayerModel> layers;
}
