import 'package:flutter/material.dart';
import 'package:pixelcanvas/shared/widgets/pc_card.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_radius.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';
import 'package:pixelcanvas/theme/app_typography.dart';

/// Community gallery preview horizontal section for the Home Dashboard per Blueprint §5.1.
///
/// **Purpose**: Previews community gallery artworks.
/// **Parameters**:
/// - [onExplore]: Callback when "Explore Community" header button is tapped.
/// - [onArtworkTap]: Callback receiving artwork index when card is tapped.
///
/// **Future Extension Notes**: Data source will be bound to `communityRepository.getGalleryFeed()` in Phase 2 Step 5.
class CommunityPreviewSection extends StatelessWidget {
  /// Creates a [CommunityPreviewSection].
  const CommunityPreviewSection({
    this.onExplore,
    this.onArtworkTap,
    super.key,
  });

  /// Explore callback.
  final VoidCallback? onExplore;

  /// Artwork tap callback.
  final ValueChanged<int>? onArtworkTap;

  static const List<Map<String, String>> _artworks = [
    {'title': 'Neon Knight', 'author': '@pixelartist', 'likes': '248'},
    {'title': 'Retro Castle', 'author': '@gamecraft', 'likes': '190'},
    {'title': 'Space Rover', 'author': '@astro', 'likes': '312'},
  ];

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Community Showcase',
                style: AppTypography.titleMedium.copyWith(
                  color: AppColors.neutral600,
                ),
              ),
              TextButton(
                onPressed: onExplore,
                child: Text(
                  'Explore',
                  style: AppTypography.labelMedium.copyWith(
                    color: AppColors.primary500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _artworks.length,
              itemBuilder: (context, index) {
                final item = _artworks[index];
                return Container(
                  width: 140,
                  margin: const EdgeInsets.only(right: AppSpacing.sm),
                  child: PcCard(
                    variant: PcCardVariant.elevated,
                    padding: const EdgeInsets.all(AppSpacing.xs),
                    onTap: () => onArtworkTap?.call(index),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(
                              color: AppColors.primary50,
                              borderRadius: AppRadius.borderXs,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.image_outlined,
                                color: AppColors.primary300,
                                size: 32,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['title']!,
                                style: AppTypography.labelMedium.copyWith(
                                  color: AppColors.neutral600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item['author']!,
                                    style: AppTypography.bodySmall.copyWith(
                                      color: AppColors.neutral400,
                                      fontSize: 10,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.favorite_rounded,
                                        size: 12,
                                        color: AppColors.dangerMain,
                                      ),
                                      const SizedBox(width: 2),
                                      Text(
                                        item['likes']!,
                                        style: AppTypography.bodySmall.copyWith(
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
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
