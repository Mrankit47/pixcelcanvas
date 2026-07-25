import 'package:flutter/material.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_radius.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';
import 'package:pixelcanvas/theme/app_typography.dart';

/// User achievement badges section per Blueprint §5.1.
///
/// **Purpose**: Previews user gamification badges ("First Artwork", "100 Projects", "Community Star", "Template Creator", "Pixel Master").
/// **Parameters**: None.
/// **Future Extension Notes**: Consumes user unlock status from `ProfileRepository`.
class AchievementsSection extends StatelessWidget {
  /// Creates an [AchievementsSection].
  const AchievementsSection({super.key});

  static const List<Map<String, dynamic>> _badges = [
    {'name': 'First Artwork', 'icon': Icons.palette_rounded, 'unlocked': true},
    {'name': '100 Projects', 'icon': Icons.military_tech_rounded, 'unlocked': true},
    {'name': 'Community Star', 'icon': Icons.star_rounded, 'unlocked': true},
    {'name': 'Template Creator', 'icon': Icons.grid_view_rounded, 'unlocked': false},
    {'name': 'Pixel Master', 'icon': Icons.workspace_premium_rounded, 'unlocked': false},
  ];

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Achievements',
            style: AppTypography.titleMedium.copyWith(
              color: AppColors.neutral600,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          SizedBox(
            height: 72,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _badges.length,
              itemBuilder: (context, index) {
                final item = _badges[index];
                final isUnlocked = item['unlocked'] as bool;
                final name = item['name'] as String;
                final icon = item['icon'] as IconData;

                return Container(
                  width: 64,
                  margin: const EdgeInsets.only(right: AppSpacing.sm),
                  child: Column(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: isUnlocked ? AppColors.primary100 : AppColors.neutral100,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isUnlocked ? AppColors.primary500 : AppColors.neutral200,
                          ),
                        ),
                        child: Icon(
                          icon,
                          size: 22,
                          color: isUnlocked ? AppColors.primary500 : AppColors.neutral300,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        name,
                        style: AppTypography.bodySmall.copyWith(
                          fontSize: 9,
                          color: isUnlocked ? AppColors.neutral600 : AppColors.neutral300,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      );
}
