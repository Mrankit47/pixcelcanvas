import 'package:flutter/material.dart';
import 'package:pixelcanvas/shared/widgets/pixel_button.dart';
import 'package:pixelcanvas/shared/widgets/pixel_card.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_radius.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';
import 'package:pixelcanvas/theme/app_typography.dart';

/// Featured active project card for the Home Dashboard per Blueprint §5.1 & Version 1.0 Design System.
class ContinueWorkingCard extends StatelessWidget {
  /// Creates a [ContinueWorkingCard].
  const ContinueWorkingCard({
    this.title = 'Dragon Sprite',
    this.gridSize = '32 × 32',
    this.lastEdited = 'Edited 2m ago',
    this.onContinue,
    super.key,
  });

  /// Project title.
  final String title;

  /// Grid size string.
  final String gridSize;

  /// Time ago label.
  final String lastEdited;

  /// Continue callback.
  final VoidCallback? onContinue;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Continue Working',
            style: AppTypography.titleMedium.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          PixelCard(
            padding: const EdgeInsets.all(AppSpacing.base),
            onTap: onContinue,
            child: Row(
              children: [
                // Pixel Canvas Thumbnail Placeholder with Cyan Accent Border
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: AppColors.primary50,
                    borderRadius: AppRadius.borderSm,
                    border: Border.all(
                      color: AppColors.accentCyan.withValues(alpha: 0.4),
                      width: 1.5,
                    ),
                  ),
                  child: const Icon(
                    Icons.palette_rounded,
                    color: AppColors.primary500,
                    size: 32,
                  ),
                ),
                const SizedBox(width: AppSpacing.base),

                // Details Column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTypography.titleMedium.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppSpacing.xxs),
                      Text(
                        '$gridSize • $lastEdited',
                        style: AppTypography.pixelCoordinates.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      PixelButton(
                        label: 'Continue Editing',
                        variant: PixelButtonVariant.primary,
                        icon: const Icon(
                          Icons.edit_rounded,
                          size: 16,
                          color: AppColors.canvas,
                        ),
                        onPressed: onContinue,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}
