import 'package:pixelcanvas/features/editor/engine/floating_selection/floating_selection.dart';
import 'package:pixelcanvas/features/editor/engine/pixel.dart';
import 'package:pixelcanvas/features/editor/engine/selection/models/selection_bounds.dart';
import 'package:pixelcanvas/features/editor/engine/transform/models/transform_bounds.dart';
import 'package:pixelcanvas/features/editor/engine/transform/models/transform_preview.dart';
import 'package:pixelcanvas/features/editor/engine/transform/models/transform_settings.dart';
import 'package:pixelcanvas/features/editor/engine/transform/tools/transform_tool.dart';

/// Stateful manager coordinating live, non-destructive transformations.
///
/// **Purpose**: Orchestrates move, rotate, flip, mirror, and scale operations
/// on an active [FloatingSelection] buffer.
///
/// **Architecture**: Pure Dart — no Riverpod, Widgets, or framework dependencies.
class TransformEngine {
  /// Configuration settings.
  TransformSettings settings = const TransformSettings();

  /// Active transform preview state container, or null if idle.
  TransformPreview? _preview;

  /// Active transform preview state getter.
  TransformPreview? get preview => _preview;

  /// True if a transformation session is active.
  bool get hasActiveTransform => _preview != null && _preview!.isVisible;

  /// Begins a transformation session for [floating].
  void beginTransform(FloatingSelection floating) {
    final orig = floating.currentBounds;
    _preview = TransformPreview(
      floatingSelection: floating,
      bounds: TransformBounds(
        left: orig.left,
        top: orig.top,
        right: orig.right,
        bottom: orig.bottom,
      ),
      settings: settings,
    );
  }

  /// Rotates the floating selection 90 degrees Clockwise.
  void rotateClockwise() {
    final floating = _preview?.floatingSelection;
    if (floating == null) return;

    final result = TransformTool.rotate90CW(
      floating.pixels,
      floating.width,
      floating.height,
    );

    _updateFloatingBuffer(floating, result);
    _preview!.bounds = _preview!.bounds.copyWith(
      rotationDegrees: (_preview!.bounds.rotationDegrees + 90) % 360,
    );
  }

  /// Rotates the floating selection 90 degrees Counter-Clockwise.
  void rotateCounterClockwise() {
    final floating = _preview?.floatingSelection;
    if (floating == null) return;

    final result = TransformTool.rotate90CCW(
      floating.pixels,
      floating.width,
      floating.height,
    );

    _updateFloatingBuffer(floating, result);
    _preview!.bounds = _preview!.bounds.copyWith(
      rotationDegrees: (_preview!.bounds.rotationDegrees + 270) % 360,
    );
  }

  /// Rotates the floating selection 180 degrees.
  void rotate180() {
    final floating = _preview?.floatingSelection;
    if (floating == null) return;

    final result = TransformTool.rotate180(
      floating.pixels,
      floating.width,
      floating.height,
    );

    _updateFloatingBuffer(floating, result);
    _preview!.bounds = _preview!.bounds.copyWith(
      rotationDegrees: (_preview!.bounds.rotationDegrees + 180) % 360,
    );
  }

  /// Flips the floating selection horizontally.
  void flipHorizontal() {
    final floating = _preview?.floatingSelection;
    if (floating == null) return;

    final result = TransformTool.flipHorizontal(
      floating.pixels,
      floating.width,
      floating.height,
    );

    _updateFloatingBuffer(floating, result);
    _preview!.bounds = _preview!.bounds.copyWith(
      isFlippedHorizontal: !_preview!.bounds.isFlippedHorizontal,
    );
  }

  /// Flips the floating selection vertically.
  void flipVertical() {
    final floating = _preview?.floatingSelection;
    if (floating == null) return;

    final result = TransformTool.flipVertical(
      floating.pixels,
      floating.width,
      floating.height,
    );

    _updateFloatingBuffer(floating, result);
    _preview!.bounds = _preview!.bounds.copyWith(
      isFlippedVertical: !_preview!.bounds.isFlippedVertical,
    );
  }

  /// Mirrors horizontal left half to right half.
  void mirrorHorizontal() {
    final floating = _preview?.floatingSelection;
    if (floating == null) return;

    final result = TransformTool.mirrorHorizontal(
      floating.pixels,
      floating.width,
      floating.height,
    );

    _updateFloatingBuffer(floating, result);
  }

  /// Mirrors vertical top half to bottom half.
  void mirrorVertical() {
    final floating = _preview?.floatingSelection;
    if (floating == null) return;

    final result = TransformTool.mirrorVertical(
      floating.pixels,
      floating.width,
      floating.height,
    );

    _updateFloatingBuffer(floating, result);
  }

  /// Scales the floating selection to [newWidth] × [newHeight] using Nearest-Neighbor sampling.
  void scaleSelection(int newWidth, int newHeight) {
    final floating = _preview?.floatingSelection;
    if (floating == null) return;

    final result = TransformTool.scaleNearestNeighbor(
      floating.pixels,
      floating.width,
      floating.height,
      newWidth,
      newHeight,
    );

    _updateFloatingBuffer(floating, result);
  }

  /// Commits the active transformation and clears preview state.
  TransformPreview? commitTransform() {
    final active = _preview;
    _preview = null;
    return active;
  }

  /// Cancels the active transformation session.
  void cancelTransform() {
    _preview = null;
  }

  void _updateFloatingBuffer(FloatingSelection floating, TransformResult result) {
    floating.pixels.clear();
    floating.pixels.addAll(result.pixels);

    // Reconstruct floating selection properties with updated dimensions
    final newFloating = FloatingSelection(
      pixels: result.pixels,
      width: result.width,
      height: result.height,
      originalBounds: SelectionBounds(
        left: floating.originalBounds.left,
        top: floating.originalBounds.top,
        right: floating.originalBounds.left + result.width,
        bottom: floating.originalBounds.top + result.height,
      ),
      sourceLayerIndex: floating.sourceLayerIndex,
      offsetX: floating.offsetX,
      offsetY: floating.offsetY,
      isVisible: floating.isVisible,
    );

    _preview!.floatingSelection = newFloating;
    _preview!.bounds = _preview!.bounds.copyWith(
      right: _preview!.bounds.left + result.width,
      bottom: _preview!.bounds.top + result.height,
    );
  }
}
