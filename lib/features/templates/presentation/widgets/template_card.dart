import 'package:flutter/material.dart';
import 'package:pixelcanvas/shared/widgets/pc_button.dart';
import 'package:pixelcanvas/shared/widgets/pc_card.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_radius.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';
import 'package:pixelcanvas/theme/app_typography.dart';

/// Single template card component for Templates Browser grid per Blueprint §5.1 & §6.2.
///
/// **Purpose**: Displays starter template details, badges, preview trigger, and Use Template button.
/// **Parameters**:
/// - [name]: Template name string.
/// - [category]: Category string (default: "Game Assets").
/// - [gridSize]: Dimensions label (default: "32 × 32").
/// - [difficulty]: Level label (default: "Beginner").
/// - [isFavorite]: True if favorited.
/// - [onPreview]: Callback for Preview.
/// - [onUseTemplate]: Callback for Use Template.
///
/// **Future Extension Notes**: Triggers template cloning into new project in Phase 2 Step 8.
class TemplateCard extends StatelessWidget {
  /// Creates a [TemplateCard].
  const TemplateCard({
    required this.name,
    this.category = 'Game Assets',
    this.gridSize = '32 × 32',
    this.difficulty = 'Beginner',
    this.isFavorite = false,
    this.onPreview,
    this.onUseTemplate,
    super.key,
  });

  /// Template name.
  final String name;

  /// Category name.
  final String category;

  /// Canvas dimensions.
  final String gridSize;

  /// Difficulty level.
  final String difficulty;

  /// Favorite status.
  final bool isFavorite;

  /// Callbacks.
  final VoidCallback? onPreview;
  final VoidCallback? onUseTemplate;

  @override
  Widget build(BuildContext context) => PcCard(
        variant: PcCardVariant.elevated,
        padding: const EdgeInsets.all(AppSpacing.xs),
        onTap: onPreview,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail Container with Category & Difficulty Badges
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.primary50,
                      borderRadius: AppRadius.borderSm,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.grid_view_rounded,
                        color: AppColors.primary300,
                        size: 36,
                      ),
                    ),
                  ),
                  Positioned(
                    top: AppSpacing.xs,
                    left: AppSpacing.xs,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: AppRadius.borderFull,
                      ),
                      child: Text(
                        difficulty,
                        style: AppTypography.labelSmall.copyWith(
                          fontSize: 9,
                          color: AppColors.neutral500,
                        ),
                      ),
                    ),
                  ),
                  if (isFavorite)
                    const Positioned(
                      top: AppSpacing.xs,
                      right: AppSpacing.xs,
                      child: Icon(
                        Icons.favorite_rounded,
                        size: 16,
                        color: AppColors.dangerMain,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xs),

            // Metadata & Actions Column
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: AppTypography.labelMedium.copyWith(
                      color: AppColors.neutral600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '$category • $gridSize',
                    style: AppTypography.bodySmall.copyWith(
                      fontSize: 10,
                      color: AppColors.neutral400,
                    ),
                    maxLines: 1,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  PcButton(
                    label: 'Use Template',
                    size: PcButtonSize.small,
                    variant: PcButtonVariant.primary,
                    fullWidth: true,
                    onPressed: onUseTemplate,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
