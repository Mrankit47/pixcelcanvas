import 'package:flutter/material.dart';
import 'package:pixelcanvas/shared/widgets/pc_button.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';
import 'package:pixelcanvas/theme/app_typography.dart';

/// PixelCanvas branded empty state container component per Blueprint §9.6.
///
/// **Purpose**: Displayed when list, search, or grid contains no records.
/// **Parameters**:
/// - [title]: Main heading string.
/// - [message]: Descriptive message string.
/// - [icon]: Optional icon fallback.
/// - [imagePath]: Optional illustration asset path.
/// - [actionLabel]: Optional CTA button text.
/// - [onAction]: Optional CTA callback.
///
/// **Usage Example**:
/// ```dart
/// PcEmptyState(
///   title: 'No Projects Found',
///   message: 'Tap below to create your first pixel art project!',
///   icon: Icons.palette_outlined,
///   actionLabel: 'Create Project',
///   onAction: () => createProject(),
/// )
/// ```
class PcEmptyState extends StatelessWidget {
  /// Creates a [PcEmptyState].
  const PcEmptyState({
    required this.title,
    required this.message,
    this.icon,
    this.imagePath,
    this.actionLabel,
    this.onAction,
    super.key,
  });

  /// Main heading string.
  final String title;

  /// Descriptive message string.
  final String message;

  /// Optional icon fallback.
  final IconData? icon;

  /// Optional illustration asset path.
  final String? imagePath;

  /// Optional CTA button text.
  final String? actionLabel;

  /// Optional CTA callback.
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (imagePath != null) ...[
                Image.asset(imagePath!, width: 120, height: 120),
                const SizedBox(height: AppSpacing.lg),
              ] else if (icon != null) ...[
                Icon(icon, size: 64, color: AppColors.neutral300),
                const SizedBox(height: AppSpacing.lg),
              ],
              Text(
                title,
                style: AppTypography.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                message,
                style: AppTypography.bodyMedium,
                textAlign: TextAlign.center,
              ),
              if (actionLabel != null && onAction != null) ...[
                const SizedBox(height: AppSpacing.xl),
                PcButton(
                  label: actionLabel!,
                  onPressed: onAction,
                  variant: PcButtonVariant.primary,
                ),
              ],
            ],
          ),
        ),
      );
}
