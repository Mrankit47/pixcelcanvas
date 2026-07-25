import 'package:flutter/material.dart';
import 'package:pixelcanvas/shared/widgets/pc_button.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';
import 'package:pixelcanvas/theme/app_typography.dart';

/// PixelCanvas branded error state container component per Blueprint §9.6.
///
/// **Purpose**: Displayed when network, database, or runtime exception occurs.
/// **Parameters**:
/// - [title]: Heading text string (default: "Something went wrong").
/// - [message]: Detailed error message.
/// - [onRetry]: Optional retry callback.
/// - [icon]: Custom error icon (default: warning icon).
///
/// **Usage Example**:
/// ```dart
/// PcErrorState(
///   message: 'Unable to load projects from storage.',
///   onRetry: () => reloadProjects(),
/// )
/// ```
class PcErrorState extends StatelessWidget {
  /// Creates a [PcErrorState].
  const PcErrorState({
    required this.message,
    this.title = 'Something went wrong',
    this.onRetry,
    this.icon = Icons.error_outline_rounded,
    super.key,
  });

  /// Detailed error message string.
  final String message;

  /// Heading title text.
  final String title;

  /// Optional retry callback.
  final VoidCallback? onRetry;

  /// Custom error icon.
  final IconData icon;

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.base),
                decoration: const BoxDecoration(
                  color: AppColors.dangerLight,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 48, color: AppColors.dangerMain),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                title,
                style: AppTypography.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                message,
                style: AppTypography.bodyMedium.copyWith(color: AppColors.neutral400),
                textAlign: TextAlign.center,
              ),
              if (onRetry != null) ...[
                const SizedBox(height: AppSpacing.xl),
                PcButton(
                  label: 'Try Again',
                  leadingIcon: Icons.refresh,
                  onPressed: onRetry,
                  variant: PcButtonVariant.primary,
                ),
              ],
            ],
          ),
        ),
      );
}
