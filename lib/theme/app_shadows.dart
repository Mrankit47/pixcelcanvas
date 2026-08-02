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
  static List<BoxShadow> get none => [];

  /// Extra small shadow (chips, tags) — 0 1px 2px black 5%.
  static List<BoxShadow> get xs => [
        BoxShadow(
          offset: const Offset(0, 1),
          blurRadius: 2,
          spreadRadius: 0,
          color: const Color(0x0D000000),
        ),
      ];

  /// Small shadow (cards, list items) — 0 1px 3px black 8%.
  static List<BoxShadow> get sm => [
        BoxShadow(
          offset: const Offset(0, 1),
          blurRadius: 3,
          spreadRadius: 0,
          color: const Color(0x14000000),
        ),
      ];

  /// Medium shadow (floating elements, dropdowns) — 0 4px 12px black 10%.
  static List<BoxShadow> get md => [
        BoxShadow(
          offset: const Offset(0, 4),
          blurRadius: 12,
          spreadRadius: 0,
          color: const Color(0x1A000000),
        ),
      ];

  /// Large shadow (dialogs, bottom sheets) — 0 8px 24px black 12%.
  static List<BoxShadow> get lg => [
        BoxShadow(
          offset: const Offset(0, 8),
          blurRadius: 24,
          spreadRadius: 0,
          color: const Color(0x1F000000),
        ),
      ];

  /// Extra large shadow (modals, overlays) — 0 16px 48px black 16%.
  static List<BoxShadow> get xl => [
        BoxShadow(
          offset: const Offset(0, 16),
          blurRadius: 48,
          spreadRadius: 0,
          color: const Color(0x29000000),
        ),
      ];

  // ── Brand Specific Pixel Glow Shadows ──

  /// Deep Cosmic Purple & Electric Violet Brand Glow.
  static List<BoxShadow> get pixelGlow => [
        BoxShadow(
          offset: const Offset(0, 4),
          blurRadius: 16,
          spreadRadius: -2,
          color: AppColors.primary500.withOpacity(0.35),
        ),
      ];

  /// Neon Pixel Cyan Accent Glow.
  static List<BoxShadow> get pixelCyanGlow => [
        BoxShadow(
          offset: const Offset(0, 4),
          blurRadius: 12,
          spreadRadius: -1,
          color: AppColors.accentCyan.withOpacity(0.4),
        ),
      ];

  /// Soft Card Elevation with Pixel Edge Glow.
  static List<BoxShadow> get pixelCardShadow => [
        BoxShadow(
          offset: const Offset(0, 4),
          blurRadius: 20,
          spreadRadius: 0,
          color: const Color(0x0C5B21B6),
        ),
      ];
}
