import 'package:flutter/material.dart';
import 'package:pixelcanvas/theme/app_colors.dart';

/// Centralized typography tokens for PixelCanvas.
///
/// Uses Inter font family scale per Blueprint §9.2 and §31.7.
abstract final class AppTypography {
  /// Font family constant.
  static const String fontFamily = 'Inter';

  /// Display Large — 32sp, Bold (700). Hero text, splash.
  static const TextStyle displayLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.25,
    letterSpacing: -0.5,
    color: AppColors.neutral500,
  );

  /// Display Medium — 28sp, Bold (700). Large headings.
  static const TextStyle displayMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.2857,
    letterSpacing: -0.25,
    color: AppColors.neutral500,
  );

  /// Headline Large — 24sp, SemiBold (600). Screen titles.
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.3333,
    letterSpacing: 0,
    color: AppColors.neutral500,
  );

  /// Headline Medium — 20sp, SemiBold (600). Section headers.
  static const TextStyle headlineMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.4,
    letterSpacing: 0,
    color: AppColors.neutral500,
  );

  /// Headline Small — 18sp, SemiBold (600). Sub-section headers.
  static const TextStyle headlineSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.3333,
    letterSpacing: 0,
    color: AppColors.neutral500,
  );

  /// Title Large — 18sp, Medium (500). Card titles.
  static const TextStyle titleLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w500,
    height: 1.3333,
    letterSpacing: 0,
    color: AppColors.neutral500,
  );

  /// Title Medium — 16sp, Medium (500). List item titles, toolbar labels.
  static const TextStyle titleMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.375,
    letterSpacing: 0.1,
    color: AppColors.neutral500,
  );

  /// Title Small — 14sp, Medium (500). Toolbar labels.
  static const TextStyle titleSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.4285,
    letterSpacing: 0.1,
    color: AppColors.neutral500,
  );

  /// Body Large — 16sp, Regular (400). Body text.
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0.15,
    color: AppColors.neutral500,
  );

  /// Body Medium — 14sp, Regular (400). Descriptions, secondary text.
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.4285,
    letterSpacing: 0.25,
    color: AppColors.neutral400,
  );

  /// Body Small — 12sp, Regular (400). Captions, timestamps.
  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.3333,
    letterSpacing: 0.4,
    color: AppColors.neutral400,
  );

  /// Label Large — 14sp, SemiBold (600). Button text.
  static const TextStyle labelLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.4285,
    letterSpacing: 0.1,
    color: AppColors.neutral500,
  );

  /// Label Medium — 12sp, Medium (500). Chip text, badges.
  static const TextStyle labelMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.3333,
    letterSpacing: 0.5,
    color: AppColors.neutral500,
  );

  /// Label Small — 10sp, Medium (500). Overlines, tiny metadata.
  static const TextStyle labelSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.5,
    color: AppColors.textSecondary,
  );

  // ── Pixel Accent Typography Scale (Used ONLY for Coordinates, FPS, Zoom, Tool Specs, Badges) ──

  /// Pixel Coordinates — Monospace/Pixel style for X, Y canvas specs.
  static const TextStyle pixelCoordinates = TextStyle(
    fontFamily: 'Courier',
    fontSize: 11,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.0,
    color: AppColors.accentCyan,
  );

  /// Pixel Metric — FPS, Zoom percentage, canvas dimensions.
  static const TextStyle pixelMetric = TextStyle(
    fontFamily: 'Courier',
    fontSize: 12,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.8,
    color: AppColors.primary500,
  );

  /// Pixel Badge — Tool labels, workspace status tags.
  static const TextStyle pixelBadge = TextStyle(
    fontFamily: 'Courier',
    fontSize: 10,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.5,
    color: AppColors.textPrimary,
  );

  /// Assembles the complete Material 3 [TextTheme].
  static const TextTheme textTheme = TextTheme(
    displayLarge: displayLarge,
    displayMedium: displayMedium,
    headlineLarge: headlineLarge,
    headlineMedium: headlineMedium,
    headlineSmall: headlineSmall,
    titleLarge: titleLarge,
    titleMedium: titleMedium,
    titleSmall: titleSmall,
    bodyLarge: bodyLarge,
    bodyMedium: bodyMedium,
    bodySmall: bodySmall,
    labelLarge: labelLarge,
    labelMedium: labelMedium,
    labelSmall: labelSmall,
  );
}
