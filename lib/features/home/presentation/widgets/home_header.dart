import 'package:flutter/material.dart';
import 'package:pixelcanvas/shared/widgets/pc_avatar.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';
import 'package:pixelcanvas/theme/app_typography.dart';

/// Top header bar for the Home Dashboard per Blueprint §5.1.
///
/// **Purpose**: Displays user greeting, user avatar, and top action icons (search, notifications, settings).
/// **Parameters**:
/// - [userName]: User display name (default: "Artist").
/// - [userAvatarUrl]: Optional user avatar URL.
/// - [onSearch]: Callback when search button is tapped.
/// - [onNotifications]: Callback when notification bell is tapped.
/// - [onSettings]: Callback when settings gear is tapped.
///
/// **Future Extension Notes**: User info will be bound to `ProfileRepository` in Phase 2 Step 5.
class HomeHeader extends StatelessWidget {
  /// Creates a [HomeHeader].
  const HomeHeader({
    this.userName = 'Artist',
    this.userAvatarUrl,
    this.onSearch,
    this.onNotifications,
    this.onSettings,
    super.key,
  });

  /// User display name.
  final String userName;

  /// Optional avatar URL.
  final String? userAvatarUrl;

  /// Search button callback.
  final VoidCallback? onSearch;

  /// Notification button callback.
  final VoidCallback? onNotifications;

  /// Settings button callback.
  final VoidCallback? onSettings;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          // User Avatar
          PcAvatar(
            imageUrl: userAvatarUrl,
            name: userName,
            size: PcAvatarSize.medium,
            isOnline: true,
          ),
          const SizedBox(width: AppSpacing.md),

          // Greeting Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Welcome back,',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.neutral400,
                  ),
                ),
                Text(
                  userName,
                  style: AppTypography.titleLarge.copyWith(
                    color: AppColors.neutral600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

        ],
      );
}
