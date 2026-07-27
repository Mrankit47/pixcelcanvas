import 'package:pixelcanvas/features/editor/engine/floating_selection/floating_selection.dart';
import 'package:pixelcanvas/features/editor/engine/transform/models/transform_bounds.dart';
import 'package:pixelcanvas/features/editor/engine/transform/models/transform_handle.dart';
import 'package:pixelcanvas/features/editor/engine/transform/models/transform_settings.dart';

/// Active preview container for an in-progress transformation session.
///
/// **Purpose**: Tracks live transform parameters without modifying canvas layers.
/// **Architecture**: Pure Dart container — no framework dependencies.
class TransformPreview {
  /// Creates a [TransformPreview].
  TransformPreview({
    required this.floatingSelection,
    required this.bounds,
    this.settings = const TransformSettings(),
    this.activeHandle = TransformHandleType.none,
    this.isVisible = true,
  });

  /// The active floating selection buffer being transformed.
  FloatingSelection floatingSelection;

  /// Current transform bounding geometry.
  TransformBounds bounds;

  /// Active transform configuration settings.
  TransformSettings settings;

  /// Currently active drag handle, or none.
  TransformHandleType activeHandle;

  /// Visibility flag for render preview.
  bool isVisible;

  /// Updates the bounds of the transform preview.
  void updateBounds(TransformBounds newBounds) {
    bounds = newBounds;
    floatingSelection.offsetX = newBounds.left - floatingSelection.originalBounds.left;
    floatingSelection.offsetY = newBounds.top - floatingSelection.originalBounds.top;
  }
}
