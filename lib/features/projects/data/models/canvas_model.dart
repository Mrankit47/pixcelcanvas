import 'package:isar/isar.dart';
import 'package:pixelcanvas/features/projects/data/models/layer_model.dart';


/// Isar Embedded Object for Canvas Entity per Blueprint §6.2 & §11.2.
///
/// **Purpose**: Embedded object within [ProjectModel] holding canvas dimensions and layer stack.
/// **Mapped Entity**: [Canvas]
@embedded
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
