import 'package:flutter/material.dart';
import 'package:pixelcanvas/shared/widgets/pc_avatar.dart';
import 'package:pixelcanvas/shared/widgets/pc_button.dart';
import 'package:pixelcanvas/shared/widgets/pc_card.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';
import 'package:pixelcanvas/theme/app_typography.dart';

/// Single artist profile card component per Blueprint §5.1.
///
/// **Purpose**: Previews artist profile, avatar, follower count, and Follow button.
/// **Parameters**:
/// - [name]: Artist display name.
/// - [followers]: Follower count string.
/// - [avatarUrl]: Optional avatar URL.
/// - [isFollowing]: True if user is following.
/// - [onFollow]: Callback when Follow button is tapped.
/// - [onTap]: Callback when card is tapped.
///
/// **Future Extension Notes**: Triggers follow mutation in `CommunityRepository` in Phase 2 Step 9.
class ArtistProfileCard extends StatelessWidget {
  /// Creates an [ArtistProfileCard].
  const ArtistProfileCard({
    required this.name,
    required this.followers,
    this.avatarUrl,
    this.isFollowing = false,
    this.onFollow,
    this.onTap,
    super.key,
  });

  /// Artist name.
  final String name;

  /// Followers string.
  final String followers;

  /// Avatar URL.
  final String? avatarUrl;

  /// Following status.
  final bool isFollowing;

  /// Callbacks.
  final VoidCallback? onFollow;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 140,
        child: PcCard(
          variant: PcCardVariant.elevated,
          padding: const EdgeInsets.all(AppSpacing.sm),
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PcAvatar(
                name: name,
                imageUrl: avatarUrl,
                size: PcAvatarSize.medium,
                isOnline: true,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                name,
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.neutral600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                '$followers Followers',
                style: AppTypography.bodySmall.copyWith(
                  fontSize: 10,
                  color: AppColors.neutral400,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              PcButton(
                label: isFollowing ? 'Following' : 'Follow',
                size: PcButtonSize.small,
                variant: isFollowing ? PcButtonVariant.outlined : PcButtonVariant.primary,
                fullWidth: true,
                onPressed: onFollow,
              ),
            ],
          ),
        ),
      );
}
