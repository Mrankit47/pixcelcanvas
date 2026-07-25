import 'package:flutter/material.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';
import 'package:pixelcanvas/theme/app_typography.dart';

/// Recent user activity list section per Blueprint §5.1.
///
/// **Purpose**: Previews user's recent uploads, project edits, and community likes.
/// **Parameters**: None.
/// **Future Extension Notes**: Consumes user activity stream from `ProfileRepository`.
class RecentActivitySection extends StatelessWidget {
  /// Creates a [RecentActivitySection].
  const RecentActivitySection({super.key});

  static const List<Map<String, String>> _activities = [
    {'title': 'Edited "Dragon Sprite 32x32"', 'time': '10 minutes ago', 'type': 'edit'},
    {'title': 'Uploaded "Cyber Knight" to Community', 'time': '2 hours ago', 'type': 'upload'},
    {'title': 'Liked "Neon Knight" by PixelGuru', 'time': '1 day ago', 'type': 'like'},
  ];

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Activity',
            style: AppTypography.titleMedium.copyWith(
              color: AppColors.neutral600,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Column(
            children: _activities.map((item) {
              final type = item['type']!;
              final icon = type == 'edit'
                  ? Icons.edit_outlined
                  : type == 'upload'
                      ? Icons.cloud_upload_outlined
                      : Icons.favorite_border_rounded;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
                child: Row(
                  children: [
                    Icon(icon, size: 18, color: AppColors.primary500),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        item['title']!,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.neutral600,
                        ),
                      ),
                    ),
                    Text(
                      item['time']!,
                      style: AppTypography.labelSmall.copyWith(
                        fontSize: 10,
                        color: AppColors.neutral400,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      );
}
