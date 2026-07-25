import 'package:flutter/material.dart';
import 'package:pixelcanvas/shared/widgets/pc_card.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_radius.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';
import 'package:pixelcanvas/theme/app_typography.dart';

/// Featured templates horizontal carousel for Templates Browser per Blueprint §5.1.
///
/// **Purpose**: Previews top 5 hero featured templates in a horizontal scrolling list.
/// **Parameters**:
/// - [onTemplateTap]: Callback receiving template index when tapped.
///
/// **Future Extension Notes**: Supports auto-scrolling page controller in Phase 2 Step 8.
class FeaturedTemplatesCarousel extends StatelessWidget {
  /// Creates a [FeaturedTemplatesCarousel].
  const FeaturedTemplatesCarousel({
    this.onTemplateTap,
    super.key,
  });

  /// Template tap callback.
  final ValueChanged<int>? onTemplateTap;

  static const List<Map<String, String>> _featured = [
    {'name': 'RPG Hero Pack', 'size': '32 × 32', 'badge': 'POPULAR'},
    {'name': 'Cyberpunk City', 'size': '64 × 64', 'badge': 'FEATURED'},
    {'name': 'Pixel UI Kit', 'size': '16 × 16', 'badge': 'NEW'},
    {'name': 'Dungeon Crawler', 'size': '32 × 32', 'badge': 'TRENDING'},
    {'name': 'Space Invaders', 'size': '16 × 16', 'badge': 'CLASSIC'},
  ];

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Featured Collections',
            style: AppTypography.titleMedium.copyWith(
              color: AppColors.neutral600,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          SizedBox(
            height: 140,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _featured.length,
              itemBuilder: (context, index) {
                final item = _featured[index];
                return Container(
                  width: 220,
                  margin: const EdgeInsets.only(right: AppSpacing.sm),
                  child: PcCard(
                    variant: PcCardVariant.elevated,
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    onTap: () => onTemplateTap?.call(index),
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          height: double.infinity,
                          decoration: const BoxDecoration(
                            color: AppColors.primary50,
                            borderRadius: AppRadius.borderXs,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.grid_view_rounded,
                              color: AppColors.primary500,
                              size: 36,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: const BoxDecoration(
                                  color: AppColors.secondary,
                                  borderRadius: AppRadius.borderFull,
                                ),
                                child: Text(
                                  item['badge']!,
                                  style: AppTypography.labelSmall.copyWith(
                                    fontSize: 9,
                                    color: AppColors.neutral0,
                                  ),
                                ),
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                item['name']!,
                                style: AppTypography.labelMedium.copyWith(
                                  color: AppColors.neutral600,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                item['size']!,
                                style: AppTypography.bodySmall.copyWith(
                                  color: AppColors.neutral400,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
}
