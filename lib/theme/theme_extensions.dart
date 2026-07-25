import 'package:flutter/material.dart';
import 'package:pixelcanvas/theme/app_colors.dart';

/// Theme extension for canvas-specific color tokens.
///
/// Provides type-safe access to canvas grid, checkerboard, selection,
/// and tool preview colors via `Theme.of(context).extension<CanvasColorsExtension>()`.
@immutable
class CanvasColorsExtension extends ThemeExtension<CanvasColorsExtension> {
  /// Creates a [CanvasColorsExtension] with explicit or default values.
  const CanvasColorsExtension({
    this.canvasBackground = AppColors.canvasBackground,
    this.gridLine = AppColors.gridLine,
    this.gridLineMajor = AppColors.gridLineMajor,
    this.transparentCheckerLight = AppColors.transparentCheckerLight,
    this.transparentCheckerDark = AppColors.transparentCheckerDark,
    this.selectionBorder = AppColors.selectionBorder,
    this.toolPreview = AppColors.toolPreview,
  });

  /// Default light theme instance.
  static const CanvasColorsExtension light = CanvasColorsExtension();

  /// Default canvas fill background.
  final Color canvasBackground;

  /// Standard grid line color.
  final Color gridLine;

  /// Major grid line color (every 8 cells).
  final Color gridLineMajor;

  /// Transparency checkerboard - light square.
  final Color transparentCheckerLight;

  /// Transparency checkerboard - dark square.
  final Color transparentCheckerDark;

  /// Selection rectangle border (marching ants).
  final Color selectionBorder;

  /// Tool ghost preview background.
  final Color toolPreview;

  @override
  CanvasColorsExtension copyWith({
    Color? canvasBackground,
    Color? gridLine,
    Color? gridLineMajor,
    Color? transparentCheckerLight,
    Color? transparentCheckerDark,
    Color? selectionBorder,
    Color? toolPreview,
  }) =>
      CanvasColorsExtension(
        canvasBackground: canvasBackground ?? this.canvasBackground,
        gridLine: gridLine ?? this.gridLine,
        gridLineMajor: gridLineMajor ?? this.gridLineMajor,
        transparentCheckerLight:
            transparentCheckerLight ?? this.transparentCheckerLight,
        transparentCheckerDark:
            transparentCheckerDark ?? this.transparentCheckerDark,
        selectionBorder: selectionBorder ?? this.selectionBorder,
        toolPreview: toolPreview ?? this.toolPreview,
      );

  @override
  CanvasColorsExtension lerp(
    covariant ThemeExtension<CanvasColorsExtension>? other,
    double t,
  ) {
    if (other is! CanvasColorsExtension) return this;
    return CanvasColorsExtension(
      canvasBackground:
          Color.lerp(canvasBackground, other.canvasBackground, t)!,
      gridLine: Color.lerp(gridLine, other.gridLine, t)!,
      gridLineMajor: Color.lerp(gridLineMajor, other.gridLineMajor, t)!,
      transparentCheckerLight: Color.lerp(
        transparentCheckerLight,
        other.transparentCheckerLight,
        t,
      )!,
      transparentCheckerDark: Color.lerp(
        transparentCheckerDark,
        other.transparentCheckerDark,
        t,
      )!,
      selectionBorder: Color.lerp(selectionBorder, other.selectionBorder, t)!,
      toolPreview: Color.lerp(toolPreview, other.toolPreview, t)!,
    );
  }
}
