import 'package:flutter/material.dart';
import 'package:pixelcanvas/shared/widgets/pc_avatar.dart';
import 'package:pixelcanvas/shared/widgets/pc_card.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_radius.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';
import 'package:pixelcanvas/theme/app_typography.dart';

/// Single community artwork card component per Blueprint §5.1 & §6.2.
///
/// **Purpose**: Renders artwork thumbnail, title, artist info, likes, views, and action buttons.
/// **Parameters**:
/// - [title]: Artwork title.
/// - [artistName]: Artist display name.
/// - [likes]: Like count integer.
/// - [views]: View count integer.
/// - [isLiked]: True if liked by current user.
/// - [onPreview]: Callback for Preview.
/// - [onLike]: Callback for Like button.
/// - [onSave]: Callback for Save button.
/// - [onShare]: Callback for Share button.
///
/// **Future Extension Notes**: Interacts with `CommunityRepository.toggleLike()` in Phase 2 Step 9.
class ArtworkCard extends StatelessWidget {
  /// Creates an [ArtworkCard].
  const ArtworkCard({
    required this.title,
    required this.artistName,
    this.likes = 128,
    this.views = 450,
    this.isLiked = false,
    this.onPreview,
    this.onLike,
    this.onSave,
    this.onShare,
    super.key,
  });

  /// Artwork title.
  final String title;

  /// Artist name.
  final String artistName;

  /// Likes count.
  final int likes;

  /// Views count.
  final int views;

  /// Liked flag.
  final bool isLiked;

  /// Callbacks.
  final VoidCallback? onPreview;
  final VoidCallback? onLike;
  final VoidCallback? onSave;
  final VoidCallback? onShare;

  @override
  Widget build(BuildContext context) => PcCard(
        variant: PcCardVariant.elevated,
        padding: const EdgeInsets.all(AppSpacing.xs),
        onTap: onPreview,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Artwork Image Placeholder Container
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.primary50,
                  borderRadius: AppRadius.borderSm,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Icon(
                      Icons.image_outlined,
                      color: AppColors.primary300,
                      size: 40,
                    ),
                    Positioned(
                      top: AppSpacing.xs,
                      right: AppSpacing.xs,
                      child: GestureDetector(
                        onTap: onLike,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isLiked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                            size: 16,
                            color: isLiked ? AppColors.dangerMain : AppColors.neutral400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xs),

            // Metadata Column
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.labelMedium.copyWith(
                      color: AppColors.neutral600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      PcAvatar(
                        name: artistName,
                        size: PcAvatarSize.small,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Expanded(
                        child: Text(
                          artistName,
                          style: AppTypography.bodySmall.copyWith(
                            fontSize: 10,
                            color: AppColors.neutral400,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.remove_red_eye_outlined, size: 12, color: AppColors.neutral300),
                          const SizedBox(width: 2),
                          Text(
                            '$views',
                            style: AppTypography.bodySmall.copyWith(fontSize: 10, color: AppColors.neutral400),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
