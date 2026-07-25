import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/profile/presentation/widgets/settings_tile.dart';
import 'package:pixelcanvas/shared/widgets/pc_card.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';
import 'package:pixelcanvas/theme/app_typography.dart';

/// General application settings section per Blueprint §5.1.
///
/// **Purpose**: Options for Notifications, Privacy, Local Storage, Backup & Sync, and Keyboard Shortcuts.
/// **Parameters**:
/// - [onSettingTap]: Callback receiving selected setting key.
///
/// **Future Extension Notes**: Interacts with `StorageManager` and `SyncManager` in Phase 2 Step 10.
class SettingsSection extends StatelessWidget {
  /// Creates a [SettingsSection].
  const SettingsSection({
    this.onSettingTap,
    super.key,
  });

  /// Setting tap callback.
  final ValueChanged<String>? onSettingTap;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Application Settings',
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
                  icon: Icons.notifications_none_rounded,
                  title: 'Push & Email Notifications',
                  subtitle: 'Activity, likes, community updates',
                  onTap: () => onSettingTap?.call('notifications'),
                ),
                const Divider(height: 1),
                SettingsTile(
                  icon: Icons.security_rounded,
                  title: 'Privacy & Permissions',
                  subtitle: 'Profile visibility and data sharing',
                  onTap: () => onSettingTap?.call('privacy'),
                ),
                const Divider(height: 1),
                SettingsTile(
                  icon: Icons.storage_rounded,
                  title: 'Local Storage & Cache',
                  subtitle: 'Isar NoSQL Database • 14.2 MB used',
                  onTap: () => onSettingTap?.call('storage'),
                ),
                const Divider(height: 1),
                SettingsTile(
                  icon: Icons.cloud_sync_rounded,
                  title: 'Backup & Cloud Sync',
                  subtitle: 'Offline sync status and database backup',
                  onTap: () => onSettingTap?.call('sync'),
                ),
                const Divider(height: 1),
                SettingsTile(
                  icon: Icons.keyboard_outlined,
                  title: 'Keyboard Shortcuts',
                  subtitle: 'View drawing tool hotkeys (Ctrl+N, Ctrl+S)',
                  onTap: () => onSettingTap?.call('shortcuts'),
                ),
              ],
            ),
          ),
        ],
      );
}
