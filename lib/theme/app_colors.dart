import 'package:flutter/material.dart';

/// Centralized color tokens for PixelCanvas.
///
/// Light Theme ONLY. Derived directly from Blueprint §9.1 and §31.1.
abstract final class AppColors {
  // ── Primary Palette ──
  /// Lightest primary tint - hover backgrounds, selected row.
  static const Color primary50 = Color(0xFFF3F1FE);

  /// Light primary backgrounds, chip backgrounds.
  static const Color primary100 = Color(0xFFE0DBFC);

  /// Disabled button backgrounds.
  static const Color primary200 = Color(0xFFC4B9F9);

  /// Secondary accents, progress bars.
  static const Color primary300 = Color(0xFFA29BFE);

  /// Hover states on primary elements.
  static const Color primary400 = Color(0xFF8B7DF7);

  /// Primary brand color — buttons, FAB, links, active states.
  static const Color primary500 = Color(0xFF6C5CE7);

  /// Pressed states.
  static const Color primary600 = Color(0xFF5A4BD4);

  /// Focus rings, emphasis.
  static const Color primary700 = Color(0xFF4A3CB5);

  /// Dark accent.
  static const Color primary800 = Color(0xFF3A2E96);

  /// Darkest primary tint.
  static const Color primary900 = Color(0xFF2A1F77);

  // ── Secondary Palette ──
  /// Secondary brand color - accent highlights, badges.
  static const Color secondary = Color(0xFF00CEC9);

  // ── Neutral Scale ──
  /// Pure white surface.
  static const Color neutral0 = Color(0xFFFFFFFF);

  /// Screen background, scaffold.
  static const Color neutral50 = Color(0xFFF8F9FA);

  /// Divider backgrounds, disabled fields.
  static const Color neutral100 = Color(0xFFF1F3F5);

  /// Borders, dividers, outlines.
  static const Color neutral200 = Color(0xFFDFE6E9);

  /// Placeholder text, disabled icons.
  static const Color neutral300 = Color(0xFFB2BEC3);

  /// Secondary text, captions, placeholders.
  static const Color neutral400 = Color(0xFF636E72);

  /// Primary text, headings.
  static const Color neutral500 = Color(0xFF2D3436);

  /// High-emphasis text.
  static const Color neutral600 = Color(0xFF1A1A2E);

  /// Pure black for shadows.
  static const Color neutral900 = Color(0xFF000000);

  // ── Semantic Colors ──
  /// Success container background.
  static const Color successLight = Color(0xFFE8F8F5);

  /// Success icons, text, borders.
  static const Color successMain = Color(0xFF00B894);

  /// Pressed success state.
  static const Color successDark = Color(0xFF008C6F);

  /// Warning container background.
  static const Color warningLight = Color(0xFFFFF8E1);

  /// Warning icons, text, borders.
  static const Color warningMain = Color(0xFFFDCB6E);

  /// Pressed warning state.
  static const Color warningDark = Color(0xE0A800FF);

  /// Danger/error container background.
  static const Color dangerLight = Color(0xFFFFF0F0);

  /// Danger/error icons, text, borders, destructive buttons.
  static const Color dangerMain = Color(0xFFFF6B6B);

  /// Pressed danger state.
  static const Color dangerDark = Color(0xFFE05555);

  /// Info container background.
  static const Color infoLight = Color(0xFFE8F4FD);

  /// Info icons, links.
  static const Color infoMain = Color(0xFF0984E3);

  /// Pressed info state.
  static const Color infoDark = Color(0xFF0767B2);

  // ── Surface & Background Aliases ──
  /// Main scaffold background.
  static const Color background = neutral50;

  /// Card, sheet, dialog surface background.
  static const Color surface = neutral0;

  /// Input border outline.
  static const Color outline = neutral200;

  /// Focused outline border.
  static const Color outlineFocused = primary500;

  // ── Canvas Engine Colors ──
  /// Default canvas fill background.
  static const Color canvasBackground = neutral0;

  /// Standard grid line color.
  static const Color gridLine = Color(0x80E0E0E0);

  /// Major grid line color (every 8 cells).
  static const Color gridLineMajor = Color(0x80BDBDBD);

  /// Transparency checkerboard - light square.
  static const Color transparentCheckerLight = Color(0xFFEEEEEE);

  /// Transparency checkerboard - dark square.
  static const Color transparentCheckerDark = Color(0xFFCCCCCC);

  /// Selection rectangle border (marching ants).
  static const Color selectionBorder = primary500;

  /// Tool ghost preview background.
  static const Color toolPreview = Color(0x4D6C5CE7);
}
