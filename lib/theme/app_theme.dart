import 'package:flutter/material.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_durations.dart';

import 'package:pixelcanvas/theme/app_radius.dart';
import 'package:pixelcanvas/theme/app_shadows.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';
import 'package:pixelcanvas/theme/app_typography.dart';
import 'package:pixelcanvas/theme/theme_extensions.dart';

/// Centralized application theme builder for PixelCanvas.
///
/// Configures [ThemeData] for Light Theme ONLY using Material 3
/// and design tokens from Blueprint §9 and §31.
abstract final class AppTheme {
  /// ColorScheme for Light Theme.
  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary500,
    onPrimary: AppColors.neutral0,
    primaryContainer: AppColors.primary100,
    onPrimaryContainer: AppColors.primary900,
    secondary: AppColors.secondary,
    onSecondary: AppColors.neutral0,
    secondaryContainer: AppColors.primary50,
    onSecondaryContainer: AppColors.primary800,
    error: AppColors.dangerMain,
    onError: AppColors.neutral0,
    errorContainer: AppColors.dangerLight,
    onErrorContainer: AppColors.dangerDark,
    surface: AppColors.surface,
    onSurface: AppColors.neutral500,
    onSurfaceVariant: AppColors.neutral400,
    outline: AppColors.outline,
    outlineVariant: AppColors.neutral100,
    shadow: AppColors.neutral900,
    scrim: AppColors.neutral900,
  );

  /// Complete Light [ThemeData] for PixelCanvas.
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: lightColorScheme,
        scaffoldBackgroundColor: AppColors.background,
        fontFamily: AppTypography.fontFamily,
        textTheme: AppTypography.textTheme,
        primaryTextTheme: AppTypography.textTheme,
        extensions: const <ThemeExtension<dynamic>>[
          CanvasColorsExtension.light,
        ],

        // ── Component Themes ──

        // Button Themes (§31.8)
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: AppShadows.elevationNone,
            backgroundColor: AppColors.primary500,
            foregroundColor: AppColors.neutral0,
            disabledBackgroundColor: AppColors.primary200,
            disabledForegroundColor: AppColors.neutral0,
            minimumSize: const Size(0, 52),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xl,
              vertical: AppSpacing.md,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: AppRadius.borderFull,
            ),
            textStyle: AppTypography.labelLarge,
            animationDuration: AppDurations.fast,
          ),
        ),

        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            elevation: AppShadows.elevationNone,
            foregroundColor: AppColors.primary500,
            disabledForegroundColor: AppColors.neutral300,
            minimumSize: const Size(0, 44),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.sm,
            ),
            side: const BorderSide(color: AppColors.primary500),
            shape: const RoundedRectangleBorder(
              borderRadius: AppRadius.borderFull,
            ),
            textStyle: AppTypography.labelLarge,
            animationDuration: AppDurations.fast,
          ),
        ),

        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary500,
            disabledForegroundColor: AppColors.neutral300,
            minimumSize: const Size(0, 36),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.base,
              vertical: AppSpacing.xs,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: AppRadius.borderFull,
            ),
            textStyle: AppTypography.labelLarge,
            animationDuration: AppDurations.fast,
          ),
        ),

        // FloatingActionButton Theme (§31.8)
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.primary500,
          foregroundColor: AppColors.neutral0,
          elevation: AppShadows.elevationMd,
          focusElevation: AppShadows.elevationLg,
          hoverElevation: AppShadows.elevationLg,
          highlightElevation: AppShadows.elevationXl,
          shape: CircleBorder(),
          iconSize: 24,
        ),

        // Card Theme (§31.8)
        cardTheme: const CardThemeData(
          color: AppColors.surface,
          elevation: AppShadows.elevationSm,
          shadowColor: Color(0x14000000),
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.borderMd,
            side: BorderSide(color: AppColors.neutral200, width: 0.5),
          ),
        ),

        // Input Decoration Theme (§31.8)
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.surface,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.base,
            vertical: AppSpacing.md,
          ),
          hintStyle: AppTypography.bodyMedium.copyWith(
            color: AppColors.neutral300,
          ),
          labelStyle: AppTypography.bodyMedium.copyWith(
            color: AppColors.neutral400,
          ),
          errorStyle: AppTypography.bodySmall.copyWith(
            color: AppColors.dangerMain,
          ),
          border: const OutlineInputBorder(
            borderRadius: AppRadius.borderSm,
            borderSide: BorderSide(color: AppColors.outline),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: AppRadius.borderSm,
            borderSide: BorderSide(color: AppColors.outline),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: AppRadius.borderSm,
            borderSide: BorderSide(color: AppColors.outlineFocused, width: 2),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: AppRadius.borderSm,
            borderSide: BorderSide(color: AppColors.dangerMain),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: AppRadius.borderSm,
            borderSide: BorderSide(color: AppColors.dangerMain, width: 2),
          ),
        ),

        // Dialog Theme (§31.8)
        dialogTheme: const DialogThemeData(
          backgroundColor: AppColors.surface,
          elevation: AppShadows.elevationLg,
          shadowColor: Color(0x1F000000),
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.borderLg,
          ),
          titleTextStyle: AppTypography.headlineMedium,
          contentTextStyle: AppTypography.bodyMedium,
        ),

        // Bottom Sheet Theme (§31.8)
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: AppColors.surface,
          elevation: AppShadows.elevationXl,
          shadowColor: Color(0x29000000),
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.topLg,
          ),
          clipBehavior: Clip.antiAlias,
          dragHandleColor: AppColors.neutral200,
          dragHandleSize: Size(40, 4),
          showDragHandle: true,
        ),

        // Navigation Bar Theme (§31.8)
        navigationBarTheme: NavigationBarThemeData(
          height: 64,
          backgroundColor: AppColors.surface,
          elevation: AppShadows.elevationSm,
          indicatorColor: AppColors.primary100,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppTypography.labelSm.copyWith(
                color: AppColors.primary500,
                fontWeight: FontWeight.w600,
              );
            }
            return AppTypography.labelSm.copyWith(
              color: AppColors.neutral300,
            );
          }),
          iconTheme: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const IconThemeData(
                color: AppColors.primary500,
                size: 24,
              );
            }
            return const IconThemeData(
              color: AppColors.neutral300,
              size: 24,
            );
          }),
        ),

        // App Bar Theme
        appBarTheme: const AppBarThemeData(
          height: 56,
          backgroundColor: AppColors.surface,
          surfaceTintColor: Colors.transparent,
          elevation: AppShadows.elevationNone,
          centerTitle: false,
          titleTextStyle: AppTypography.headlineMedium,
          iconTheme: IconThemeData(
            color: AppColors.neutral500,
            size: 24,
          ),
        ),

        // SnackBar Theme
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: AppColors.neutral500,
          contentTextStyle: TextStyle(
            fontFamily: AppTypography.fontFamily,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.neutral0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.borderSm,
          ),
          behavior: SnackBarBehavior.floating,
          elevation: AppShadows.elevationMd,
        ),

        // Chip Theme
        chipTheme: ChipThemeData(
          backgroundColor: AppColors.neutral50,
          disabledColor: AppColors.neutral100,
          selectedColor: AppColors.primary100,
          secondarySelectedColor: AppColors.primary100,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xs,
          ),
          labelStyle: AppTypography.labelMedium,
          secondaryLabelStyle: AppTypography.labelMedium.copyWith(
            color: AppColors.primary500,
          ),
          brightness: Brightness.light,
          shape: const RoundedRectangleBorder(
            borderRadius: AppRadius.borderXs,
            side: BorderSide(color: AppColors.neutral200),
          ),
        ),

        // Divider Theme
        dividerTheme: const DividerThemeData(
          color: AppColors.neutral200,
          thickness: 1,
          space: 1,
        ),

        // Checkbox Theme
        checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.primary500;
            }
            return Colors.transparent;
          }),
          shape: const RoundedRectangleBorder(
            borderRadius: AppRadius.borderXs,
          ),
          side: const BorderSide(color: AppColors.neutral300, width: 2),
        ),
      );
}
