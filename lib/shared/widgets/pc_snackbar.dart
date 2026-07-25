import 'package:flutter/material.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_radius.dart';
import 'package:pixelcanvas/theme/app_shadows.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';
import 'package:pixelcanvas/theme/app_typography.dart';

/// Variant for [PcSnackbar].
enum PcSnackbarVariant {
  /// Success toast notification (green).
  success,

  /// Error toast notification (red).
  error,

  /// Warning toast notification (amber).
  warning,

  /// Info toast notification (blue).
  info,
}

/// PixelCanvas branded floating toast notification utility per Blueprint §9.6 and §31.8.
///
/// **Purpose**: Floating feedback message snackbar.
/// **Usage Example**:
/// ```dart
/// PcSnackbar.showSuccess(context, 'Project saved successfully!');
/// PcSnackbar.showError(context, 'Unable to sync changes.');
/// ```
abstract final class PcSnackbar {
  /// Displays a floating snackbar notification.
  static void show(
    BuildContext context, {
    required String message,
    PcSnackbarVariant variant = PcSnackbarVariant.info,
    Duration duration = const Duration(seconds: 3),
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    final backgroundColor = switch (variant) {
      PcSnackbarVariant.success => AppColors.successMain,
      PcSnackbarVariant.error => AppColors.dangerMain,
      PcSnackbarVariant.warning => AppColors.warningMain,
      PcSnackbarVariant.info => AppColors.infoMain,
    };

    final icon = switch (variant) {
      PcSnackbarVariant.success => Icons.check_circle_outline,
      PcSnackbarVariant.error => Icons.error_outline,
      PcSnackbarVariant.warning => Icons.warning_amber_outlined,
      PcSnackbarVariant.info => Icons.info_outline,
    };

    final snackBar = SnackBar(
      elevation: AppShadows.elevationMd,
      behavior: SnackBarBehavior.floating,
      backgroundColor: backgroundColor,
      duration: duration,
      shape: const RoundedRectangleBorder(
        borderRadius: AppRadius.borderSm,
      ),
      content: Row(
        children: [
          Icon(icon, color: AppColors.neutral0, size: 20),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              message,
              style: AppTypography.bodyMedium.copyWith(color: AppColors.neutral0),
            ),
          ),
          if (actionLabel != null && onAction != null) ...[
            TextButton(
              onPressed: onAction,
              child: Text(
                actionLabel,
                style: AppTypography.labelLarge.copyWith(color: AppColors.neutral0),
              ),
            ),
          ],
        ],
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  /// Displays success snackbar.
  static void showSuccess(BuildContext context, String message) {
    show(context, message: message, variant: PcSnackbarVariant.success);
  }

  /// Displays error snackbar.
  static void showError(BuildContext context, String message) {
    show(context, message: message, variant: PcSnackbarVariant.error);
  }

  /// Displays warning snackbar.
  static void showWarning(BuildContext context, String message) {
    show(context, message: message, variant: PcSnackbarVariant.warning);
  }

  /// Displays info snackbar.
  static void showInfo(BuildContext context, String message) {
    show(context, message: message, variant: PcSnackbarVariant.info);
  }
}
