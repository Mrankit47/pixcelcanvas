import 'package:flutter/material.dart';
import 'package:pixelcanvas/shared/widgets/pc_avatar.dart';
import 'package:pixelcanvas/shared/widgets/pc_button.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_radius.dart';
import 'package:pixelcanvas/theme/app_shadows.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';
import 'package:pixelcanvas/theme/app_typography.dart';

/// Modal dialog previewing community artwork details per Blueprint §5.1.
///
/// **Purpose**: Full modal view presenting high-res artwork preview, artist info, likes, tags, and action buttons.
/// **Parameters**:
/// - [title]: Artwork title (default: "Neon Knight").
/// - [artistName]: Artist name (default: "PixelGuru").
/// - [likes]: Likes count.
/// - [views]: Views count.
/// - [onLike]: Callback for Like.
/// - [onSave]: Callback for Save.
/// - [onDownload]: Callback for Download.
/// - [onClose]: Callback for Close.
///
/// **Future Extension Notes**: Loads original PNG image asset and comments in Phase 2 Step 9.
class ArtworkPreviewDialog extends StatelessWidget {
  /// Creates an [ArtworkPreviewDialog].
  const ArtworkPreviewDialog({
    this.title = 'Neon Knight',
    this.artistName = 'PixelGuru',
    this.likes = 342,
    this.views = 1200,
    this.onLike,
    this.onSave,
    this.onDownload,
    this.onClose,
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

  /// Callbacks.
  final VoidCallback? onLike;
  final VoidCallback? onSave;
  final VoidCallback? onDownload;
  final VoidCallback? onClose;

  /// Static helper to display artwork preview dialog.
  static Future<void> show(
    BuildContext context, {
    required String title,
    required String artistName,
  }) =>
      showDialog<void>(
        context: context,
        builder: (context) => ArtworkPreviewDialog(
          title: title,
          artistName: artistName,
          onClose: () => Navigator.of(context).pop(),
        ),
      );

  @override
  Widget build(BuildContext context) => Dialog(
        backgroundColor: AppColors.surface,
        elevation: AppShadows.elevationLg,
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.borderLg),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Large Image Preview Box
              Container(
                height: 220,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.primary50,
                  borderRadius: AppRadius.borderMd,
                ),
                child: const Center(
                  child: Icon(
                    Icons.image_outlined,
                    color: AppColors.primary500,
                    size: 64,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              // Title & Artist Info Header
              Row(
                children: [
                  PcAvatar(name: artistName, size: PcAvatarSize.medium),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: AppTypography.titleMedium.copyWith(color: AppColors.neutral600)),
                        Text('by $artistName', style: AppTypography.bodySmall.copyWith(color: AppColors.neutral400)),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.favorite_border_rounded, color: AppColors.dangerMain),
                    onPressed: onLike,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),

              // Action Buttons Row
              Row(
                children: [
                  Expanded(
                    child: PcButton(
                      label: 'Save',
                      variant: PcButtonVariant.outlined,
                      leadingIcon: Icons.bookmark_border_rounded,
                      onPressed: onSave,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: PcButton(
                      label: 'Download',
                      variant: PcButtonVariant.primary,
                      leadingIcon: Icons.download_rounded,
                      onPressed: onDownload,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
