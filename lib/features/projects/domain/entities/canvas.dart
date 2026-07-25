import 'package:pixelcanvas/core/domain/entity.dart';
import 'package:pixelcanvas/core/domain/value_objects/domain_values.dart';
import 'package:pixelcanvas/core/domain/value_objects/identifiers.dart';
import 'package:pixelcanvas/features/projects/domain/entities/layer.dart';

/// Canvas Domain Entity per Blueprint §6.1 & §8.2.
///
/// **Purpose**: Represents the 2D grid matrix container holding active layers.
/// **Responsibilities**: Encapsulates canvas dimensions and layer stack.
/// **Future Persistence Notes**: Mapped to Isar `CanvasModel`.
class Canvas extends Entity<CanvasId> {
  /// Creates a [Canvas] domain entity.
  const Canvas({
    required CanvasId id,
    required this.size,
    required this.layers,
  }) : super(id);

  /// Canvas dimensions (width × height).
  final CanvasSize size;

  /// Ordered layer stack.
  final List<Layer> layers;

  @override
  List<Object?> get props => [id, size, layers];
}
