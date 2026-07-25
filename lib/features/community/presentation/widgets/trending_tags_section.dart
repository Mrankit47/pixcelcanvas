import 'package:flutter/material.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_radius.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';
import 'package:pixelcanvas/theme/app_typography.dart';

/// Trending hashtags horizontal section per Blueprint §5.1.
///
/// **Purpose**: Previews popular hashtags (#Fantasy, #Retro, #GameArt, #PixelIcon, #Landscape, #SciFi).
/// **Parameters**:
/// - [onTagTap]: Callback receiving selected tag string.
///
/// **Future Extension Notes**: Interacts with tag search filter in `CommunityRepository`.
class TrendingTagsSection extends StatelessWidget {
  /// Creates a [TrendingTagsSection].
  const TrendingTagsSection({
    this.onTagTap,
    super.key,
  });

  /// Tag tap callback.
  final ValueChanged<String>? onTagTap;

  static const List<String> _tags = [
    '#Fantasy',
    '#Retro',
    '#GameArt',
    '#PixelIcon',
    '#Landscape',
    '#SciFi',
    '#Cyberpunk',
    '#UI',
  ];

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Trending Tags',
            style: AppTypography.titleMedium.copyWith(
              color: AppColors.neutral600,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          SizedBox(
            height: 32,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _tags.length,
              itemBuilder: (context, index) {
                final tag = _tags[index];
                return Container(
                  margin: const EdgeInsets.only(right: AppSpacing.xs),
                  child: ActionChip(
                    label: Text(tag),
                    onPressed: () => onTagTap?.call(tag),
                    backgroundColor: AppColors.primary50,
                    labelStyle: AppTypography.labelSmall.copyWith(
                      color: AppColors.primary500,
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: AppRadius.borderFull,
                      side: BorderSide(color: AppColors.primary100),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
}
