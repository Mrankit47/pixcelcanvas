import 'package:flutter/material.dart';
import 'package:pixelcanvas/shared/widgets/pc_button.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_radius.dart';
import 'package:pixelcanvas/theme/app_shadows.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';
import 'package:pixelcanvas/theme/app_typography.dart';

/// Modal preview dialog for inspecting starter templates per Blueprint §5.1.
///
/// **Purpose**: Full modal view presenting template preview, color count, dimensions, tags, and Use Template CTA.
/// **Parameters**:
/// - [name]: Template name (default: "Knight Sprite").
/// - [description]: Template description string.
/// - [gridSize]: Canvas dimensions (default: "32 × 32 px").
/// - [colorCount]: Number of colors (default: 16).
/// - [onUseTemplate]: Callback when Use Template button is tapped.
/// - [onClose]: Callback when Close button is tapped.
///
/// **Future Extension Notes**: Loads full preview image and palette swatches in Phase 2 Step 8.
class TemplatePreviewDialog extends StatelessWidget {
  /// Creates a [TemplatePreviewDialog].
  const TemplatePreviewDialog({
    this.name = 'Knight Sprite',
    this.description = 'A starter 32x32 character sprite with walking animation frames.',
    this.gridSize = '32 × 32 px',
    this.colorCount = 16,
    this.onUseTemplate,
    this.onClose,
    super.key,
  });

  /// Template name.
  final String name;

  /// Description string.
  final String description;

  /// Canvas dimensions.
  final String gridSize;

  /// Color palette count.
  final int colorCount;

  /// Callbacks.
  final VoidCallback? onUseTemplate;
  final VoidCallback? onClose;

  /// Static helper to display template preview modal.
  static Future<void> show(
    BuildContext context, {
    required String name,
    required VoidCallback onUseTemplate,
  }) =>
      showDialog<void>(
        context: context,
        builder: (context) => TemplatePreviewDialog(
          name: name,
          onUseTemplate: () {
            Navigator.of(context).pop();
            onUseTemplate();
          },
          onClose: () => Navigator.of(context).pop(),
        ),
      );

  @override
  Widget build(BuildContext context) => Dialog(
        backgroundColor: AppColors.surface,
        elevation: AppShadows.elevationLg,
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.borderLg),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Large Preview Box
              Container(
                height: 180,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.primary50,
                  borderRadius: AppRadius.borderMd,
                ),
                child: const Center(
                  child: Icon(
                    Icons.grid_view_rounded,
                    color: AppColors.primary500,
                    size: 64,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              // Title & Description
              Text(
                name,
                style: AppTypography.headlineSmall.copyWith(color: AppColors.neutral600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                description,
                style: AppTypography.bodyMedium.copyWith(color: AppColors.neutral400),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.md),

              // Specifications Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildSpecItem('Canvas Size', gridSize),
                  _buildSpecItem('Color Swatch', '$colorCount Colors'),
                  _buildSpecItem('Difficulty', 'Beginner'),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),

              // CTAs Row
              Row(
                children: [
                  Expanded(
                    child: PcButton(
                      label: 'Close',
                      variant: PcButtonVariant.outlined,
                      onPressed: onClose ?? () => Navigator.of(context).pop(),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: PcButton(
                      label: 'Use Template',
                      variant: PcButtonVariant.primary,
                      onPressed: onUseTemplate,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Widget _buildSpecItem(String label, String value) => Column(
        children: [
          Text(label, style: AppTypography.labelSmall.copyWith(color: AppColors.neutral400)),
          Text(value, style: AppTypography.labelMedium.copyWith(color: AppColors.neutral600)),
        ],
      );
}
