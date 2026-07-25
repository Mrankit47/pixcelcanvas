import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/projects/presentation/widgets/project_context_menu.dart';
import 'package:pixelcanvas/shared/widgets/pc_card.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_radius.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';
import 'package:pixelcanvas/theme/app_typography.dart';

/// Single project card component for Projects Gallery grid per Blueprint §5.1 & §6.2.
///
/// **Purpose**: Displays project thumbnail, metadata, sync status badge, and context menu.
/// **Parameters**:
/// - [title]: Project name string.
/// - [gridSize]: Canvas dimension label (default: "32 × 32").
/// - [lastEdited]: Time ago string.
/// - [isFavorite]: True if project is favorited.
/// - [isSynced]: True if project is synced to cloud.
/// - [onTap]: Callback when card is tapped.
/// - [onRename]: Callback for rename.
/// - [onDuplicate]: Callback for duplicate.
/// - [onExport]: Callback for export.
/// - [onArchive]: Callback for archive.
/// - [onDelete]: Callback for delete.
///
/// **Future Extension Notes**: Thumbnail will load Isar cached blob or file preview in Phase 2 Step 6.
class ProjectCard extends StatelessWidget {
  /// Creates a [ProjectCard].
  const ProjectCard({
    required this.title,
    this.gridSize = '32 × 32',
    this.lastEdited = 'Edited 10m ago',
    this.isFavorite = false,
    this.isSynced = true,
    this.onTap,
    this.onRename,
    this.onDuplicate,
    this.onExport,
    this.onArchive,
    this.onDelete,
    super.key,
  });

  /// Project title.
  final String title;

  /// Grid size string.
  final String gridSize;

  /// Time ago label.
  final String lastEdited;

  /// Favorite flag.
  final bool isFavorite;

  /// Sync status flag.
  final bool isSynced;

  /// Card tap callback.
  final VoidCallback? onTap;

  /// Context menu callbacks.
  final VoidCallback? onRename;
  final VoidCallback? onDuplicate;
  final VoidCallback? onExport;
  final VoidCallback? onArchive;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) => PcCard(
        variant: PcCardVariant.elevated,
        padding: const EdgeInsets.all(AppSpacing.xs),
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail Preview Container with Badges
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppColors.primary50,
                      borderRadius: AppRadius.borderSm,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.palette_outlined,
                        color: AppColors.primary300,
                        size: 40,
                      ),
                    ),
                  ),
                  // Sync Status Badge
                  Positioned(
                    top: AppSpacing.xs,
                    left: AppSpacing.xs,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: AppColors.surface,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isSynced ? Icons.cloud_done_rounded : Icons.cloud_off_rounded,
                        size: 14,
                        color: isSynced ? AppColors.successMain : AppColors.warningMain,
                      ),
                    ),
                  ),
                  // Favorite Badge
                  if (isFavorite)
                    const Positioned(
                      top: AppSpacing.xs,
                      right: AppSpacing.xs,
                      child: Icon(
                        Icons.favorite_rounded,
                        size: 16,
                        color: AppColors.dangerMain,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xs),

            // Metadata Row & Context Menu
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: AppSpacing.xs),
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
                        Text(
                          '$gridSize • $lastEdited',
                          style: AppTypography.bodySmall.copyWith(
                            fontSize: 10,
                            color: AppColors.neutral400,
                          ),
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ),
                ProjectContextMenu(
                  onRename: onRename,
                  onDuplicate: onDuplicate,
                  onExport: onExport,
                  onArchive: onArchive,
                  onDelete: onDelete,
                ),
              ],
            ),
          ],
        ),
      );
}
