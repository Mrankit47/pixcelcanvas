import 'package:flutter/material.dart';
import 'package:pixelcanvas/shared/widgets/pc_button.dart';
import 'package:pixelcanvas/shared/widgets/pc_card.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_radius.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';
import 'package:pixelcanvas/theme/app_typography.dart';

/// Featured active project card for the Home Dashboard per Blueprint §5.1.
///
/// **Purpose**: Highlights the most recently edited project for 1-tap continuation.
/// **Parameters**:
/// - [title]: Project title string (default: "Dragon Sprite").
/// - [gridSize]: Canvas dimension label (default: "32x32").
/// - [lastEdited]: Time ago string (default: "Edited 2m ago").
/// - [onContinue]: Callback when "Continue Editing" button is tapped.
///
/// **Future Extension Notes**: Will bind to `projectRepository.getRecentProjects()` in Phase 2 Step 5.
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
              color: AppColors.neutral600,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          PcCard(
            variant: PcCardVariant.elevated,
            padding: const EdgeInsets.all(AppSpacing.base),
            onTap: onContinue,
            child: Row(
              children: [
                // Pixel Canvas Thumbnail Placeholder
                Container(
                  width: 72,
                  height: 72,
                  decoration: const BoxDecoration(
                    color: AppColors.primary50,
                    borderRadius: AppRadius.borderSm,
                    border: Border.fromBorderSide(
                      BorderSide(color: AppColors.neutral200),
                    ),
                  ),
                  child: const Icon(
                    Icons.palette_outlined,
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
                          color: AppColors.neutral600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppSpacing.xxs),
                      Text(
                        '$gridSize • $lastEdited',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.neutral400,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      PcButton(
                        label: 'Continue Editing',
                        size: PcButtonSize.small,
                        variant: PcButtonVariant.primary,
                        leadingIcon: Icons.edit_rounded,
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
