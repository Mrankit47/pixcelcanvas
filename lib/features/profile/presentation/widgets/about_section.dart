import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/profile/presentation/widgets/settings_tile.dart';
import 'package:pixelcanvas/shared/widgets/pc_card.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';
import 'package:pixelcanvas/theme/app_typography.dart';

/// About application information section per Blueprint §5.1.
///
/// **Purpose**: Displays version string, build number, MIT License, Open Source licenses, Privacy Policy, and Terms.
/// **Parameters**:
/// - [version]: Version string (default: "v1.0.0 (1)").
/// - [onLinkTap]: Callback when policy/license link is tapped.
///
/// **Future Extension Notes**: Version string injected from `PackageInfo` in Phase 2 Step 10.
class AboutSection extends StatelessWidget {
  /// Creates an [AboutSection].
  const AboutSection({
    this.version = 'v1.0.0 (1)',
    this.onLinkTap,
    super.key,
  });

  /// Version string.
  final String version;

  /// Link tap callback.
  final ValueChanged<String>? onLinkTap;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About PixelCanvas',
            style: AppTypography.titleMedium.copyWith(
              color: AppColors.neutral600,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          PcCard(
            variant: PcCardVariant.elevated,
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                SettingsTile(
                  icon: Icons.info_outline_rounded,
                  title: 'Application Version',
                  subtitle: version,
                  trailing: Text(
                    'Up to date',
                    style: AppTypography.labelSmall.copyWith(color: AppColors.successMain),
                  ),
                ),
                const Divider(height: 1),
                SettingsTile(
                  icon: Icons.gavel_rounded,
                  title: 'MIT License',
                  subtitle: 'Open Source Software License',
                  onTap: () => onLinkTap?.call('license'),
                ),
                const Divider(height: 1),
                SettingsTile(
                  icon: Icons.code_rounded,
                  title: 'Open Source Libraries',
                  subtitle: 'Flutter, Riverpod, Isar, Supabase',
                  onTap: () => onLinkTap?.call('oss'),
                ),
                const Divider(height: 1),
                SettingsTile(
                  icon: Icons.privacy_tip_outlined,
                  title: 'Privacy Policy',
                  onTap: () => onLinkTap?.call('privacy_policy'),
                ),
                const Divider(height: 1),
                SettingsTile(
                  icon: Icons.description_outlined,
                  title: 'Terms of Service',
                  onTap: () => onLinkTap?.call('terms'),
                ),
              ],
            ),
          ),
        ],
      );
}
