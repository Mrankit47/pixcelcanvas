import 'package:flutter/material.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';
import 'package:pixelcanvas/theme/app_typography.dart';

/// Community Gallery header bar per Blueprint §5.1 & §6.2.
///
/// **Purpose**: Displays page title, artwork count, search, and filter buttons.
/// **Parameters**:
/// - [artworkCount]: Total artwork count integer (default: 1240).
/// - [onSearch]: Callback when search button is tapped.
/// - [onFilter]: Callback when filter button is tapped.
///
/// **Future Extension Notes**: Count will bind to `CommunityRepository.watchFeedCount()` in Phase 2 Step 9.
class CommunityHeader extends StatelessWidget {
  /// Creates a [CommunityHeader].
  const CommunityHeader({
    this.artworkCount = 1240,
    this.onSearch,
    this.onFilter,
    super.key,
  });

  /// Artwork count integer.
  final int artworkCount;

  /// Search button callback.
  final VoidCallback? onSearch;

  /// Filter button callback.
  final VoidCallback? onFilter;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Community Showcase',
                style: AppTypography.headlineSmall.copyWith(
                  color: AppColors.neutral600,
                ),
              ),
              Text(
                '$artworkCount Artworks',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.neutral400,
                ),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.search_rounded, color: AppColors.neutral500),
                onPressed: onSearch,
                tooltip: 'Search gallery',
              ),
              IconButton(
                icon: const Icon(Icons.tune_rounded, color: AppColors.neutral500),
                onPressed: onFilter,
                tooltip: 'Filter gallery',
              ),
            ],
          ),
        ],
      );
}
