import 'package:flutter/material.dart';
import 'package:pixelcanvas/theme/app_colors.dart';

/// Centralized elevation and shadow tokens for PixelCanvas.
///
/// Derived directly from Blueprint §9.5 and §31.4.
abstract final class AppShadows {
  /// Elevation 0 — flat elements.
  static const double elevationNone = 0;

  /// Elevation 1 — subtle lift (chips, tags).
  static const double elevationXs = 1;

  /// Elevation 2 — cards, list items.
  static const double elevationSm = 2;

  /// Elevation 4 — floating elements, dropdowns.
  static const double elevationMd = 4;

  /// Elevation 8 — dialogs, bottom sheets.
  static const double elevationLg = 8;

  /// Elevation 16 — modals, full-screen overlays.
  static const double elevationXl = 16;

  // ── BoxShadow Collections ──
  /// No shadow.
  static const List<BoxShadow> none = [];

  /// Extra small shadow (chips, tags) — 0 1px 2px black 5%.
  static const List<BoxShadow> xs = [
    BoxShadow(
      offset: Offset(0, 1),
      blurRadius: 2,
      spreadRadius: 0,
      color: Color(0x0D000000),
    ),
  ];

  /// Small shadow (cards, list items) — 0 1px 3px black 8%.
  static const List<BoxShadow> sm = [
    BoxShadow(
      offset: Offset(0, 1),
      blurRadius: 3,
      spreadRadius: 0,
      color: Color(0x14000000),
    ),
  ];

  /// Medium shadow (floating elements, dropdowns) — 0 4px 12px black 10%.
  static const List<BoxShadow> md = [
    BoxShadow(
      offset: Offset(0, 4),
      blurRadius: 12,
      spreadRadius: 0,
      color: Color(0x1A000000),
    ),
  ];

  /// Large shadow (dialogs, bottom sheets) — 0 8px 24px black 12%.
  static const List<BoxShadow> lg = [
    BoxShadow(
      offset: Offset(0, 8),
      blurRadius: 24,
      spreadRadius: 0,
      color: Color(0x1F000000),
    ),
  ];

  /// Extra large shadow (modals, overlays) — 0 16px 48px black 16%.
  static const List<BoxShadow> xl = [
    BoxShadow(
      offset: Offset(0, 16),
      blurRadius: 48,
      spreadRadius: 0,
      color: Color(0x29000000),
    ),
  ];
}
