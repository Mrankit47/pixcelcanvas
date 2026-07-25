import 'package:flutter/material.dart';
import 'package:pixelcanvas/shared/widgets/pc_card.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';
import 'package:pixelcanvas/theme/app_typography.dart';

/// User activity metrics stats card per Blueprint §5.1.
///
/// **Purpose**: Displays count metrics for Projects, Templates, Followers, Following, and Community Likes.
/// **Parameters**:
/// - [projects]: Projects count (default: 24).
/// - [templates]: Templates count (default: 8).
/// - [followers]: Followers string (default: "1.4k").
/// - [following]: Following count (default: 250).
/// - [likes]: Likes string (default: "3.2k").
///
/// **Future Extension Notes**: Binds to `ProfileRepository.getStats()` in Phase 2 Step 10.
class ProfileStatsCard extends StatelessWidget {
  /// Creates a [ProfileStatsCard].
  const ProfileStatsCard({
    this.projects = 24,
    this.templates = 8,
    this.followers = '1.4k',
    this.following = 250,
    this.likes = '3.2k',
    super.key,
  });

  /// Projects count.
  final int projects;

  /// Templates count.
  final int templates;

  /// Followers string.
  final String followers;

  /// Following count.
  final int following;

  /// Likes string.
  final String likes;

  @override
  Widget build(BuildContext context) => PcCard(
        variant: PcCardVariant.elevated,
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem('Projects', '$projects'),
            _buildStatItem('Templates', '$templates'),
            _buildStatItem('Followers', followers),
            _buildStatItem('Following', '$following'),
            _buildStatItem('Likes', likes),
          ],
        ),
      );

  Widget _buildStatItem(String label, String value) => Column(
        children: [
          Text(
            value,
            style: AppTypography.titleMedium.copyWith(
              color: AppColors.primary500,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: AppTypography.labelSmall.copyWith(
              fontSize: 10,
              color: AppColors.neutral400,
            ),
          ),
        ],
      );
}
