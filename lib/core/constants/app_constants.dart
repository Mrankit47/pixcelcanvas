/// Global application constants, limits, and defaults for PixelCanvas.
///
/// Derived directly from Blueprint §29 and §32.
abstract final class AppConstants {
  /// Application name.
  static const String appName = 'PixelCanvas';

  /// Default canvas width and height in pixels.
  static const int defaultGridSize = 32;

  /// Minimum allowed canvas dimension (8x8).
  static const int minGridSize = 8;

  /// Maximum allowed canvas dimension for MVP (128x128).
  static const int maxGridSize = 128;

  /// Extended maximum canvas dimension for V2 (256x256).
  static const int maxGridSizeV2 = 256;

  /// Maximum allowed layers per project (MVP).
  static const int maxLayers = 8;

  /// Maximum depth of the undo history stack.
  static const int maxUndoSteps = 50;

  /// Reduced undo depth for low-memory devices.
  static const int maxUndoStepsLowMemory = 25;

  /// Auto-save inactivity debounce duration in seconds.
  static const int autoSaveDebounceSeconds = 3;

  /// Unconditional auto-save safety timer in seconds.
  static const int autoSaveUnconditionalSeconds = 30;

  /// Thumbnail width/height in pixels for project list preview.
  static const int thumbnailSize = 128;
}
