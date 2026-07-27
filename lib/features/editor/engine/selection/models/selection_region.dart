import 'package:equatable/equatable.dart';
import 'package:pixelcanvas/features/editor/engine/selection/models/selection_bounds.dart';

/// Types of selection geometry.
///
/// Only [rectangle] is implemented in Phase 5 Step 1.
/// Other values are future-ready placeholders.
enum SelectionType {
  /// Axis-aligned rectangular selection.
  rectangle,

  /// Freehand (lasso) selection — future.
  freehand,

  /// Magic wand (flood-based) selection — future.
  magicWand,

  /// Color-based selection — future.
  colorSelect,

  /// Polygon (vertex-based) selection — future.
  polygon,
}

/// Represents a complete selection region with type and bounding geometry.
///
/// **Purpose**: Combines a [SelectionBounds] with a [SelectionType] to fully
/// describe the active selection.
/// **Phase 5 Step 1**: Only [SelectionType.rectangle] is functionally active.
/// Non-rectangle types will be implemented in future phases.
class SelectionRegion extends Equatable {
  /// Creates a [SelectionRegion].
  const SelectionRegion({
    required this.bounds,
    this.type = SelectionType.rectangle,
  });

  /// The bounding geometry of the selection.
  final SelectionBounds bounds;

  /// The type of selection (rectangle, freehand, etc.).
  final SelectionType type;

  /// True if the selection has valid, non-empty geometry.
  bool get isValid => bounds.isValid;

  /// Returns true if canvas pixel coordinate `(x, y)` is inside this selection.
  ///
  /// For [SelectionType.rectangle], this is a simple bounds check.
  /// Future selection types will override with more complex containment logic.
  bool containsPoint(int x, int y) {
    switch (type) {
      case SelectionType.rectangle:
        return bounds.contains(x, y);
      // Future selection types — placeholder implementations
      case SelectionType.freehand:
      case SelectionType.magicWand:
      case SelectionType.colorSelect:
      case SelectionType.polygon:
        // Fall back to bounds check until implemented
        return bounds.contains(x, y);
    }
  }

  /// Creates a copy of [SelectionRegion] with updated fields.
  SelectionRegion copyWith({
    SelectionBounds? bounds,
    SelectionType? type,
  }) =>
      SelectionRegion(
        bounds: bounds ?? this.bounds,
        type: type ?? this.type,
      );

  @override
  List<Object?> get props => [bounds, type];

  @override
  String toString() => 'SelectionRegion(type: $type, bounds: $bounds)';
}
