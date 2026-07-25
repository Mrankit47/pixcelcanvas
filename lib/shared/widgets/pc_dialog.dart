import 'package:flutter/material.dart';
import 'package:pixelcanvas/shared/widgets/pc_button.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_radius.dart';
import 'package:pixelcanvas/theme/app_shadows.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';
import 'package:pixelcanvas/theme/app_typography.dart';

/// Variant for [PcDialog].
enum PcDialogVariant {
  /// Confirmation dialog with Cancel and Confirm CTAs.
  confirmation,

  /// Alert dialog with single OK button.
  alert,

  /// Custom content dialog with user-defined child widget.
  custom,
}

/// PixelCanvas branded modal dialog component per Blueprint §9.6 and §31.8.
///
/// **Purpose**: Prompts user confirmation or displays critical warnings.
/// **Parameters**:
/// - [title]: Dialog title string.
/// - [content]: Message body text or custom content widget.
/// - [variant]: Dialog type variant (default: [PcDialogVariant.confirmation]).
/// - [icon]: Optional header icon.
/// - [confirmLabel]: Label for confirmation button (default: "Confirm").
/// - [cancelLabel]: Label for cancel button (default: "Cancel").
/// - [onConfirm]: Callback when confirm button is tapped.
/// - [onCancel]: Callback when cancel button is tapped.
///
/// **Usage Example**:
/// ```dart
/// PcDialog.showConfirmation(
///   context,
///   title: 'Delete Project?',
///   message: 'This action cannot be undone.',
///   onConfirm: () => deleteProject(),
/// )
/// ```
/// **Accessibility**: Accessible modal dialog semantics (`AlertDialog`).
class PcDialog extends StatelessWidget {
  /// Creates a [PcDialog].
  const PcDialog({
    required this.title,
    this.content,
    this.bodyWidget,
    this.variant = PcDialogVariant.confirmation,
    this.icon,
    this.confirmLabel = 'Confirm',
    this.cancelLabel = 'Cancel',
    this.onConfirm,
    this.onCancel,
    super.key,
  });

  /// Dialog title string.
  final String title;

  /// Optional text message content.
  final String? content;

  /// Optional custom body widget.
  final Widget? bodyWidget;

  /// Dialog type variant.
  final PcDialogVariant variant;

  /// Header icon.
  final IconData? icon;

  /// Confirmation CTA label.
  final String confirmLabel;

  /// Cancel CTA label.
  final String cancelLabel;

  /// Confirmation callback.
  final VoidCallback? onConfirm;

  /// Cancel callback.
  final VoidCallback? onCancel;

  /// Shows confirmation dialog helper.
  static Future<bool?> showConfirmation(
    BuildContext context, {
    required String title,
    required String message,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
    IconData? icon,
  }) =>
      showDialog<bool>(
        context: context,
        builder: (context) => PcDialog(
          title: title,
          content: message,
          icon: icon,
          variant: PcDialogVariant.confirmation,
          confirmLabel: confirmLabel,
          cancelLabel: cancelLabel,
          onConfirm: () => Navigator.of(context).pop(true),
          onCancel: () => Navigator.of(context).pop(false),
        ),
      );

  /// Shows alert dialog helper.
  static Future<void> showAlert(
    BuildContext context, {
    required String title,
    required String message,
    String confirmLabel = 'OK',
    IconData? icon,
  }) =>
      showDialog<void>(
        context: context,
        builder: (context) => PcDialog(
          title: title,
          content: message,
          icon: icon,
          variant: PcDialogVariant.alert,
          confirmLabel: confirmLabel,
          onConfirm: () => Navigator.of(context).pop(),
        ),
      );

  @override
  Widget build(BuildContext context) => Dialog(
        backgroundColor: AppColors.surface,
        elevation: AppShadows.elevationLg,
        shape: const RoundedRectangleBorder(
          borderRadius: AppRadius.borderLg,
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 36, color: AppColors.primary500),
                const SizedBox(height: AppSpacing.md),
              ],
              Text(
                title,
                style: AppTypography.headlineSmall,
                textAlign: TextAlign.center,
              ),
              if (content != null) ...[
                const SizedBox(height: AppSpacing.sm),
                Text(
                  content!,
                  style: AppTypography.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
              if (bodyWidget != null) ...[
                const SizedBox(height: AppSpacing.md),
                bodyWidget!,
              ],
              const SizedBox(height: AppSpacing.xl),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (variant == PcDialogVariant.confirmation) ...[
                    Expanded(
                      child: PcButton(
                        label: cancelLabel,
                        variant: PcButtonVariant.outlined,
                        onPressed: onCancel ?? () => Navigator.of(context).pop(),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                  ],
                  Expanded(
                    child: PcButton(
                      label: confirmLabel,
                      variant: variant == PcDialogVariant.confirmation
                          ? PcButtonVariant.primary
                          : PcButtonVariant.primary,
                      onPressed: onConfirm ?? () => Navigator.of(context).pop(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
