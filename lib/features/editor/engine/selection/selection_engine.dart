import 'dart:math' as math;

import 'package:pixelcanvas/features/editor/engine/selection/models/selection_bounds.dart';
import 'package:pixelcanvas/features/editor/engine/selection/models/selection_region.dart';

/// Hit zone identifiers for selection interaction.
///
/// Used by [SelectionEngine.hitTestSelection] to determine which part of the
/// selection the user is interacting with.
enum SelectionHitZone {
  /// Point is outside the selection.
  none,

  /// Point is inside the selection body.
  inside,

  /// Point is on the top-left resize handle.
  topLeft,

  /// Point is on the top-right resize handle.
  topRight,

  /// Point is on the bottom-left resize handle.
  bottomLeft,

  /// Point is on the bottom-right resize handle.
  bottomRight,

  /// Point is on the top edge resize handle.
  top,

  /// Point is on the right edge resize handle.
  right,

  /// Point is on the bottom edge resize handle.
  bottom,

  /// Point is on the left edge resize handle.
  left,
}

/// Central selection state manager for the pixel canvas.
///
/// **Purpose**: Manages the full lifecycle of a selection — create, resize,
/// replace, clear — storing geometry only (no pixel data).
///
/// **Lifecycle**:
/// 1. [beginSelection] — starts rubber-band drag at origin point
/// 2. [updateSelection] — updates pending bounds as user drags
/// 3. [endSelection] — commits pending bounds as the active [SelectionRegion]
/// 4. [clearSelection] — removes the active selection
///
/// **Architecture**: Pure Dart — no Riverpod, Widgets, or framework dependencies.
/// Designed for canvases up to 4096×4096 with O(1) rectangle containment.
class SelectionEngine {
  /// The committed active selection region.
  SelectionRegion? _activeRegion;

  /// Rubber-band bounds being dragged (uncommitted).
  SelectionBounds? _pendingBounds;

  /// Whether a selection drag is currently in progress.
  bool _isSelecting = false;

  /// Drag origin X coordinate.
  int _startX = 0;

  /// Drag origin Y coordinate.
  int _startY = 0;

  /// Whether the selection overlay is visible.
  bool _selectionVisible = true;

  /// Handle size in canvas pixel units for hit testing.
  int _handleSize = 1;

  // ---------------------------------------------------------------------------
  // Selection Lifecycle
  // ---------------------------------------------------------------------------

  /// Begins a new selection drag at canvas pixel `(x, y)`.
  ///
  /// Clears any existing selection and starts the rubber-band.
  void beginSelection(int x, int y) {
    _startX = x;
    _startY = y;
    _isSelecting = true;
    _activeRegion = null;
    _pendingBounds = SelectionBounds(
      left: x,
      top: y,
      right: x + 1,
      bottom: y + 1,
    );
  }

  /// Updates the rubber-band selection to include canvas pixel `(x, y)`.
  ///
  /// Normalises coordinates so the bounds are always valid regardless of
  /// drag direction (top-left to bottom-right, or any other direction).
  void updateSelection(int x, int y) {
    if (!_isSelecting) return;

    _pendingBounds = SelectionBounds(
      left: math.min(_startX, x),
      top: math.min(_startY, y),
      right: math.max(_startX, x) + 1,
      bottom: math.max(_startY, y) + 1,
    );
  }

  /// Ends the current selection drag and commits the pending bounds.
  ///
  /// If the resulting bounds are degenerate (zero area), the selection is cleared.
  void endSelection() {
    if (!_isSelecting) return;
    _isSelecting = false;

    if (_pendingBounds != null && _pendingBounds!.isValid) {
      _activeRegion = SelectionRegion(bounds: _pendingBounds!);
    } else {
      _activeRegion = null;
    }
    _pendingBounds = null;
  }

  /// Commits the pending bounds with canvas boundary validation.
  ///
  /// Clamps the selection to `[0, canvasWidth) × [0, canvasHeight)` and
  /// clears if the result is degenerate.
  void endSelectionWithValidation(int canvasWidth, int canvasHeight) {
    if (!_isSelecting) return;
    _isSelecting = false;

    if (_pendingBounds != null && _pendingBounds!.isValid) {
      final clamped = _pendingBounds!.clampTo(canvasWidth, canvasHeight);
      if (clamped.isValid) {
        _activeRegion = SelectionRegion(bounds: clamped);
      } else {
        _activeRegion = null;
      }
    } else {
      _activeRegion = null;
    }
    _pendingBounds = null;
  }

  /// Clears the active selection and any pending drag.
  void clearSelection() {
    _activeRegion = null;
    _pendingBounds = null;
    _isSelecting = false;
  }

  // ---------------------------------------------------------------------------
  // Selection Queries
  // ---------------------------------------------------------------------------

  /// Returns the active committed [SelectionRegion], or null if no selection.
  SelectionRegion? getSelection() => _activeRegion;

  /// Returns the current bounds — pending (during drag) or committed.
  SelectionBounds? get selectionBounds =>
      _isSelecting ? _pendingBounds : _activeRegion?.bounds;

  /// True if there is an active committed selection.
  bool get hasSelection => _activeRegion != null && _activeRegion!.isValid;

  /// True if a selection drag is currently in progress.
  bool get isSelecting => _isSelecting;

  /// Whether the selection overlay is visible.
  bool get isSelectionVisible => _selectionVisible;

  /// Sets the visibility of the selection overlay.
  void setSelectionVisible(bool visible) {
    _selectionVisible = visible;
  }

  /// Sets the handle size in canvas pixel units for hit testing.
  void setHandleSize(int size) {
    _handleSize = size.clamp(1, 4);
  }

  // ---------------------------------------------------------------------------
  // Selection Manipulation
  // ---------------------------------------------------------------------------

  /// Programmatically replaces the active selection with [region].
  void replaceSelection(SelectionRegion region) {
    _activeRegion = region;
    _pendingBounds = null;
    _isSelecting = false;
  }

  /// Validates and clamps the active selection to canvas dimensions.
  ///
  /// Clears the selection if the clamped result is degenerate.
  void validateSelection(int canvasWidth, int canvasHeight) {
    if (_activeRegion == null) return;

    final clamped = _activeRegion!.bounds.clampTo(canvasWidth, canvasHeight);
    if (clamped.isValid) {
      _activeRegion = _activeRegion!.copyWith(bounds: clamped);
    } else {
      _activeRegion = null;
    }
  }

  // ---------------------------------------------------------------------------
  // Hit Testing
  // ---------------------------------------------------------------------------

  /// Determines which zone of the selection the canvas pixel `(x, y)` falls in.
  ///
  /// Returns [SelectionHitZone.none] if outside the selection.
  /// Checks resize handles (corners, then edges) before the interior.
  ///
  /// Handle zones extend [_handleSize] pixels from the selection edges.
  SelectionHitZone hitTestSelection(int x, int y) {
    final bounds = _activeRegion?.bounds;
    if (bounds == null || !bounds.isValid) return SelectionHitZone.none;

    final hs = _handleSize;

    // Corner handles (highest priority)
    if (_inRange(x, bounds.left, hs) && _inRange(y, bounds.top, hs)) {
      return SelectionHitZone.topLeft;
    }
    if (_inRange(x, bounds.right - 1, hs) && _inRange(y, bounds.top, hs)) {
      return SelectionHitZone.topRight;
    }
    if (_inRange(x, bounds.left, hs) && _inRange(y, bounds.bottom - 1, hs)) {
      return SelectionHitZone.bottomLeft;
    }
    if (_inRange(x, bounds.right - 1, hs) &&
        _inRange(y, bounds.bottom - 1, hs)) {
      return SelectionHitZone.bottomRight;
    }

    // Edge handles
    if (_inRange(y, bounds.top, hs) &&
        x >= bounds.left &&
        x < bounds.right) {
      return SelectionHitZone.top;
    }
    if (_inRange(y, bounds.bottom - 1, hs) &&
        x >= bounds.left &&
        x < bounds.right) {
      return SelectionHitZone.bottom;
    }
    if (_inRange(x, bounds.left, hs) &&
        y >= bounds.top &&
        y < bounds.bottom) {
      return SelectionHitZone.left;
    }
    if (_inRange(x, bounds.right - 1, hs) &&
        y >= bounds.top &&
        y < bounds.bottom) {
      return SelectionHitZone.right;
    }

    // Interior
    if (bounds.contains(x, y)) {
      return SelectionHitZone.inside;
    }

    return SelectionHitZone.none;
  }

  /// Resizes the active selection by moving the specified [zone] handle to `(x, y)`.
  ///
  /// Does nothing if there is no active selection.
  void resizeSelection(SelectionHitZone zone, int x, int y) {
    if (_activeRegion == null) return;
    final b = _activeRegion!.bounds;

    SelectionBounds newBounds;
    switch (zone) {
      case SelectionHitZone.topLeft:
        newBounds = b.copyWith(left: x, top: y);
      case SelectionHitZone.topRight:
        newBounds = b.copyWith(right: x + 1, top: y);
      case SelectionHitZone.bottomLeft:
        newBounds = b.copyWith(left: x, bottom: y + 1);
      case SelectionHitZone.bottomRight:
        newBounds = b.copyWith(right: x + 1, bottom: y + 1);
      case SelectionHitZone.top:
        newBounds = b.copyWith(top: y);
      case SelectionHitZone.bottom:
        newBounds = b.copyWith(bottom: y + 1);
      case SelectionHitZone.left:
        newBounds = b.copyWith(left: x);
      case SelectionHitZone.right:
        newBounds = b.copyWith(right: x + 1);
      case SelectionHitZone.inside:
      case SelectionHitZone.none:
        return;
    }

    if (newBounds.isValid) {
      _activeRegion = _activeRegion!.copyWith(bounds: newBounds);
    }
  }

  // ---------------------------------------------------------------------------
  // Private Helpers
  // ---------------------------------------------------------------------------

  /// Returns true if [value] is within [tolerance] of [target].
  bool _inRange(int value, int target, int tolerance) {
    return (value - target).abs() <= tolerance;
  }
}
