import 'package:flutter/material.dart';
import 'package:pixelcanvas/shared/widgets/pc_avatar.dart';
import 'package:pixelcanvas/shared/widgets/pc_button.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';
import 'package:pixelcanvas/theme/app_typography.dart';

/// User profile header section per Blueprint §5.1 & §6.2.
///
/// **Purpose**: Displays user avatar, display name, handle, bio, and Edit Profile button.
/// **Parameters**:
/// - [displayName]: User display name (default: "Alex Rivers").
/// - [username]: Handle handle (default: "@pixelmaster").
/// - [bio]: User bio summary.
/// - [avatarUrl]: Optional avatar URL.
/// - [onEditProfile]: Callback when Edit Profile is tapped.
///
/// **Future Extension Notes**: Profile info will bind to `ProfileRepository` in Phase 2 Step 10.
class ProfileHeader extends StatelessWidget {
  /// Creates a [ProfileHeader].
  const ProfileHeader({
    this.displayName = 'Alex Rivers',
    this.username = '@pixelmaster',
    this.bio = 'Pixel Artist & Game Dev • Creating retro worlds 🎨',
    this.avatarUrl,
    this.onEditProfile,
    super.key,
  });

  /// Display name.
  final String displayName;

  /// Username.
  final String username;

  /// Bio string.
  final String bio;

  /// Avatar URL.
  final String? avatarUrl;

  /// Edit profile callback.
  final VoidCallback? onEditProfile;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          PcAvatar(
            name: displayName,
            imageUrl: avatarUrl,
            size: PcAvatarSize.large,
            isOnline: true,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            displayName,
            style: AppTypography.headlineSmall.copyWith(
              color: AppColors.neutral600,
            ),
          ),
          Text(
            username,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.neutral400,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            bio,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.neutral500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.md),
          PcButton(
            label: 'Edit Profile',
            size: PcButtonSize.small,
            variant: PcButtonVariant.outlined,
            leadingIcon: Icons.edit_outlined,
            onPressed: onEditProfile,
          ),
        ],
      );
}
