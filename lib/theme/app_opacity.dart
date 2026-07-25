/// Centralized opacity tokens for PixelCanvas.
///
/// Derived directly from Blueprint §31.5.
abstract final class AppOpacity {
  /// Fully transparent — 0.0.
  static const double transparent = 0.0;

  /// Hover overlay on surfaces — 0.04 (4%).
  static const double hover = 0.04;

  /// Press/tap overlay — 0.08 (8%).
  static const double pressed = 0.08;

  /// Tool ghost preview — 0.30 (30%).
  static const double toolPreview = 0.30;

  /// Disabled text, icons, buttons — 0.38 (38%).
  static const double disabled = 0.38;

  /// Canvas grid lines — 0.50 (50%).
  static const double gridLine = 0.50;

  /// Modal backdrop overlay — 0.50 (50%).
  static const double overlay = 0.50;

  /// Fully opaque — 1.0 (100%).
  static const double opaque = 1.0;
}
