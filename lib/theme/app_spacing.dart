import 'package:flutter/material.dart';

/// Centralized spacing scale for PixelCanvas.
///
/// Derived directly from Blueprint §9.3 and §31.2.
abstract final class AppSpacing {
  /// Hairline gaps, icon inner padding — 2dp.
  static const double xxs = 2;

  /// Minimum spacing, tag gap — 4dp.
  static const double xs = 4;

  /// Between related elements, chip padding, icon gap — 8dp.
  static const double sm = 8;

  /// Input inner padding, small card padding — 12dp.
  static const double md = 12;

  /// Standard padding (screen edges, card content, list item) — 16dp.
  static const double base = 16;

  /// Between sections, group spacing — 20dp.
  static const double lg = 20;

  /// Major section spacing — 24dp.
  static const double xl = 24;

  /// Screen-level section breaks — 32dp.
  static const double xxl = 32;

  /// Top/bottom screen padding, hero spacing — 48dp.
  static const double xxxl = 48;

  /// Hero spacing — 64dp.
  static const double xxxxl = 64;

  // ── EdgeInsets Shortcuts ──
  /// Zero padding.
  static const EdgeInsets zero = EdgeInsets.zero;

  /// All sides xs (4dp).
  static const EdgeInsets insetXs = EdgeInsets.all(xs);

  /// All sides sm (8dp).
  static const EdgeInsets insetSm = EdgeInsets.all(sm);

  /// All sides md (12dp).
  static const EdgeInsets insetMd = EdgeInsets.all(md);

  /// All sides base (16dp).
  static const EdgeInsets insetBase = EdgeInsets.all(base);

  /// All sides lg (20dp).
  static const EdgeInsets insetLg = EdgeInsets.all(lg);

  /// All sides xl (24dp).
  static const EdgeInsets insetXl = EdgeInsets.all(xl);

  /// Horizontal base (16dp).
  static const EdgeInsets horizontalBase =
      EdgeInsets.symmetric(horizontal: base);

  /// Vertical base (16dp).
  static const EdgeInsets verticalBase = EdgeInsets.symmetric(vertical: base);

  /// Horizontal sm (8dp).
  static const EdgeInsets horizontalSm = EdgeInsets.symmetric(horizontal: sm);

  /// Vertical sm (8dp).
  static const EdgeInsets verticalSm = EdgeInsets.symmetric(vertical: sm);
}
