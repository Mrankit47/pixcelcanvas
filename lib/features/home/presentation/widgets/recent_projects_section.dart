import 'package:flutter/material.dart';
import 'package:pixelcanvas/shared/widgets/pc_card.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_radius.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';
import 'package:pixelcanvas/theme/app_typography.dart';

/// Recent projects horizontal scroll section for the Home Dashboard per Blueprint §5.1.
///
/// **Purpose**: Displays 5 placeholder recent project cards.
/// **Parameters**:
/// - [onViewAll]: Callback when "View All" header button is tapped.
/// - [onProjectTap]: Callback receiving project index when card is tapped.
///
/// **Future Extension Notes**: Data source will be bound to `projectRepository.getAll()` in Phase 2 Step 5.
class RecentProjectsSection extends StatelessWidget {
  /// Creates a [RecentProjectsSection].
  const RecentProjectsSection({
    this.onViewAll,
    this.onProjectTap,
    super.key,
  });

  /// View All callback.
  final VoidCallback? onViewAll;

  /// Project tap callback.
  final ValueChanged<int>? onProjectTap;

  static const List<Map<String, String>> _placeholders = [
    {'title': 'Cyber Sword', 'size': '16 × 16', 'time': '1h ago'},
    {'title': 'Potion Bottle', 'size': '32 × 32', 'time': '3h ago'},
    {'title': 'Space Ship', 'size': '64 × 64', 'time': '1d ago'},
    {'title': 'Coin Animation', 'size': '16 × 16', 'time': '2d ago'},
    {'title': 'Dungeon Tile', 'size': '32 × 32', 'time': '3d ago'},
  ];

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Projects',
                style: AppTypography.titleMedium.copyWith(
                  color: AppColors.neutral600,
                ),
              ),
              TextButton(
                onPressed: onViewAll,
                child: Text(
                  'View All',
                  style: AppTypography.labelMedium.copyWith(
                    color: AppColors.primary500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          SizedBox(
            height: 140,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _placeholders.length,
              itemBuilder: (context, index) {
                final item = _placeholders[index];
                return Container(
                  width: 120,
                  margin: const EdgeInsets.only(right: AppSpacing.sm),
                  child: PcCard(
                    variant: PcCardVariant.outlined,
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    onTap: () => onProjectTap?.call(index),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.neutral100,
                              borderRadius: AppRadius.borderXs,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.grid_on_rounded,
                                color: AppColors.neutral300,
                                size: 28,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          item['title']!,
                          style: AppTypography.labelMedium.copyWith(
                            color: AppColors.neutral600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '${item['size']!} • ${item['time']!}',
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.neutral400,
                          ),
                          maxLines: 1,
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
