import 'package:pixelcanvas/core/domain/entity.dart';
import 'package:pixelcanvas/core/domain/value_objects/identifiers.dart';

/// Layer Domain Entity per Blueprint §6.1 & §8.2.
///
/// **Purpose**: Represents a single layer in the multi-layer canvas stack.
/// **Responsibilities**: Holds layer name, visibility, lock status, opacity, and index order.
/// **Future Persistence Notes**: Mapped to Isar `LayerModel` and raw pixel buffer byte arrays.
class Layer extends Entity<LayerId> {
  /// Creates a [Layer] domain entity.
  const Layer({
    required LayerId id,
    required this.name,
    this.isVisible = true,
    this.isLocked = false,
    this.opacity = 1.0,
    this.index = 0,
  }) : super(id);

  /// Layer name string.
  final String name;

  /// Visibility toggle.
  final bool isVisible;

  /// Lock toggle.
  final bool isLocked;

  /// Opacity multiplier (0.0 to 1.0).
  final double opacity;

  /// Layer stack index order (0 = background).
  final int index;

  @override
  List<Object?> get props => [id, name, isVisible, isLocked, opacity, index];
}
