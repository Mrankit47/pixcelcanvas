import 'package:flutter/material.dart';

/// Centralized border radius scale for PixelCanvas.
///
/// Derived directly from Blueprint §9.4 and §31.3.
abstract final class AppRadius {
  /// Sharp corners (canvas, pixel grid) — 0.
  static const double none = 0;

  /// Small chips, tags, inline badges — 4dp.
  static const double xs = 4;

  /// Text inputs, small cards, list items — 8dp.
  static const double sm = 8;

  /// Standard cards, dialogs — 12dp.
  static const double md = 12;

  /// Bottom sheets, large cards, modals — 16dp.
  static const double lg = 16;

  /// Onboarding cards, feature cards — 20dp.
  static const double xl = 20;

  /// Prominent containers — 24dp.
  static const double xxl = 24;

  /// FAB, circular buttons, avatars, pills — 999dp.
  static const double full = 999;

  // ── Radius Object Shortcuts ──
  /// Zero radius.
  static const Radius radiusNone = Radius.zero;

  /// Radius 4.
  static const Radius radiusXs = Radius.circular(xs);

  /// Radius 8.
  static const Radius radiusSm = Radius.circular(sm);

  /// Radius 12.
  static const Radius radiusMd = Radius.circular(md);

  /// Radius 16.
  static const Radius radiusLg = Radius.circular(lg);

  /// Radius 20.
  static const Radius radiusXl = Radius.circular(xl);

  /// Radius 24.
  static const Radius radiusXxl = Radius.circular(xxl);

  /// Radius 999 (pill/full).
  static const Radius radiusFull = Radius.circular(full);

  // ── BorderRadius Shortcuts ──
  /// Zero border radius.
  static const BorderRadius borderNone = BorderRadius.zero;

  /// All corners 4dp.
  static const BorderRadius borderXs = BorderRadius.all(radiusXs);

  /// All corners 8dp.
  static const BorderRadius borderSm = BorderRadius.all(radiusSm);

  /// All corners 12dp.
  static const BorderRadius borderMd = BorderRadius.all(radiusMd);

  /// All corners 16dp.
  static const BorderRadius borderLg = BorderRadius.all(radiusLg);

  /// All corners 20dp.
  static const BorderRadius borderXl = BorderRadius.all(radiusXl);

  /// All corners 24dp.
  static const BorderRadius borderXxl = BorderRadius.all(radiusXxl);

  /// All corners full/pill (999dp).
  static const BorderRadius borderFull = BorderRadius.all(radiusFull);

  /// Top corners only 16dp (for bottom sheets).
  static const BorderRadius topLg = BorderRadius.vertical(
    top: radiusLg,
  );
}
