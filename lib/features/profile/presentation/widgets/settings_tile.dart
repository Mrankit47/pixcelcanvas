import 'package:flutter/material.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_radius.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';
import 'package:pixelcanvas/theme/app_typography.dart';

/// Reusable settings tile component per Blueprint §5.1.
///
/// **Purpose**: Standard list tile layout for settings, account, and preference sections.
/// **Parameters**:
/// - [icon]: Leading icon.
/// - [title]: Tile title string.
/// - [subtitle]: Optional subtitle description string.
/// - [trailing]: Optional trailing widget (chevron, badge, switch).
/// - [onTap]: Callback when tile is tapped.
/// - [iconColor]: Custom icon color override.
///
/// **Future Extension Notes**: Can support badge counts and async status indicators.
class SettingsTile extends StatelessWidget {
  /// Creates a [SettingsTile].
  const SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.iconColor,
    super.key,
  });

  /// Leading icon.
  final IconData icon;

  /// Tile title.
  final String title;

  /// Optional subtitle.
  final String? subtitle;

  /// Optional trailing widget.
  final Widget? trailing;

  /// Tap callback.
  final VoidCallback? onTap;

  /// Icon color override.
  final Color? iconColor;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        borderRadius: AppRadius.borderSm,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.xs),
                decoration: BoxDecoration(
                  color: AppColors.neutral50,
                  borderRadius: AppRadius.borderXs,
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: iconColor ?? AppColors.neutral500,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTypography.labelMedium.copyWith(
                        color: AppColors.neutral600,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle!,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.neutral400,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              trailing ??
                  const Icon(
                    Icons.chevron_right_rounded,
                    size: 20,
                    color: AppColors.neutral300,
                  ),
            ],
          ),
        ),
      );
}
