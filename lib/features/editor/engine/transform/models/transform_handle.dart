/// Types of interaction handles on the transform bounding box.
enum TransformHandleType {
  /// Outside the transform bounding box.
  none,

  /// Inside the transform body (used for translation / move).
  inside,

  /// Top-left corner handle.
  topLeft,

  /// Top-right corner handle.
  topRight,

  /// Bottom-left corner handle.
  bottomLeft,

  /// Bottom-right corner handle.
  bottomRight,

  /// Top edge handle.
  top,

  /// Bottom edge handle.
  bottom,

  /// Left edge handle.
  left,

  /// Right edge handle.
  right,

  /// Rotation handle placeholder (positioned above top-center).
  rotation,
}

/// Helper utilities for transform handle hit testing and calculations.
class TransformHandle {
  /// Determines handle type based on hit coordinates `(x, y)` relative to `(left, top, right, bottom)`.
  ///
  /// [handleSize] defines hit tolerance in canvas pixels.
  static TransformHandleType hitTest({
    required int x,
    required int y,
    required int left,
    required int top,
    required int right,
    required int bottom,
    int handleSize = 1,
  }) {
    final hs = handleSize;

    // 1. Rotation handle (positioned 2 units above top-center)
    final centerX = (left + right) ~/ 2;
    final rotY = top - 2;
    if (_near(x, centerX, hs) && _near(y, rotY, hs)) {
      return TransformHandleType.rotation;
    }

    // 2. Corner handles (highest priority)
    if (_near(x, left, hs) && _near(y, top, hs)) {
      return TransformHandleType.topLeft;
    }
    if (_near(x, right - 1, hs) && _near(y, top, hs)) {
      return TransformHandleType.topRight;
    }
    if (_near(x, left, hs) && _near(y, bottom - 1, hs)) {
      return TransformHandleType.bottomLeft;
    }
    if (_near(x, right - 1, hs) && _near(y, bottom - 1, hs)) {
      return TransformHandleType.bottomRight;
    }

    // 3. Edge handles
    if (_near(y, top, hs) && x >= left && x < right) {
      return TransformHandleType.top;
    }
    if (_near(y, bottom - 1, hs) && x >= left && x < right) {
      return TransformHandleType.bottom;
    }
    if (_near(x, left, hs) && y >= top && y < bottom) {
      return TransformHandleType.left;
    }
    if (_near(x, right - 1, hs) && y >= top && y < bottom) {
      return TransformHandleType.right;
    }

    // 4. Interior body
    if (x >= left && x < right && y >= top && y < bottom) {
      return TransformHandleType.inside;
    }

    return TransformHandleType.none;
  }

  static bool _near(int val, int target, int tolerance) {
    return (val - target).abs() <= tolerance;
  }
}
