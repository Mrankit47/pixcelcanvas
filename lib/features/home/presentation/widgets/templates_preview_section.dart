import 'package:flutter/material.dart';
import 'package:pixelcanvas/shared/widgets/pc_card.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_radius.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';
import 'package:pixelcanvas/theme/app_typography.dart';

/// Templates preview horizontal carousel section for the Home Dashboard per Blueprint §5.1.
///
/// **Purpose**: Previews starter templates library.
/// **Parameters**:
/// - [onViewAll]: Callback when "View All" header button is tapped.
/// - [onTemplateTap]: Callback receiving template index when card is tapped.
///
/// **Future Extension Notes**: Data source will be bound to `templateRepository.getAll()` in Phase 2 Step 5.
class TemplatesPreviewSection extends StatelessWidget {
  /// Creates a [TemplatesPreviewSection].
  const TemplatesPreviewSection({
    this.onViewAll,
    this.onTemplateTap,
    super.key,
  });

  /// View All callback.
  final VoidCallback? onViewAll;

  /// Template tap callback.
  final ValueChanged<int>? onTemplateTap;

  static const List<Map<String, String>> _templates = [
    {'name': 'Character Sprite', 'cat': 'Game Assets'},
    {'name': 'Tilemap 16x16', 'cat': 'Environment'},
    {'name': 'App Icon 32x32', 'cat': 'UI Design'},
    {'name': 'NFT Canvas 64x64', 'cat': 'Art'},
  ];

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Starter Templates',
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
            height: 110,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _templates.length,
              itemBuilder: (context, index) {
                final item = _templates[index];
                return Container(
                  width: 140,
                  margin: const EdgeInsets.only(right: AppSpacing.sm),
                  child: PcCard(
                    variant: PcCardVariant.filled,
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    onTap: () => onTemplateTap?.call(index),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.primary100,
                            borderRadius: AppRadius.borderXs,
                          ),
                          child: const Icon(
                            Icons.grid_view_rounded,
                            color: AppColors.primary500,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                item['name']!,
                                style: AppTypography.labelSmall.copyWith(
                                  color: AppColors.neutral600,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                item['cat']!,
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
