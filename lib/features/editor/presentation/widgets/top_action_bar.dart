import 'package:flutter/material.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';
import 'package:pixelcanvas/theme/app_typography.dart';

/// Top action header bar for the Pixel Editor workspace per Blueprint §5.1 & §8.2.
///
/// **Purpose**: Displays project title, back button, undo/redo history controls, save, export, share, and settings.
/// **Parameters**:
/// - [projectName]: Project name string (default: "Dragon Sprite").
/// - [canvasSize]: Dimensions label (default: "32 × 32").
/// - [onBack]: Callback for back navigation.
/// - [onUndo]: Callback for undo.
/// - [onRedo]: Callback for redo.
/// - [onSave]: Callback for manual save.
/// - [onExport]: Callback for export.
/// - [onShare]: Callback for share.
/// - [onSettings]: Callback for settings.
///
/// **Future Extension Notes**: Undo/redo buttons will bind to `UndoHistoryNotifier` in Phase 4.
class TopActionBar extends StatelessWidget implements PreferredSizeWidget {
  /// Creates a [TopActionBar].
  const TopActionBar({
    this.projectName = 'Dragon Sprite',
    this.canvasSize = '32 × 32 px',
    this.onBack,
    this.onUndo,
    this.onRedo,
    this.onSave,
    this.onExport,
    this.onShare,
    this.onSettings,
    super.key,
  });

  /// Project title string.
  final String projectName;

  /// Canvas dimensions string.
  final String canvasSize;

  /// Callbacks.
  final VoidCallback? onBack;
  final VoidCallback? onUndo;
  final VoidCallback? onRedo;
  final VoidCallback? onSave;
  final VoidCallback? onExport;
  final VoidCallback? onShare;
  final VoidCallback? onSettings;

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) => Container(
        height: 56,
        decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(bottom: BorderSide(color: AppColors.neutral200)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_rounded, color: AppColors.neutral500),
              onPressed: onBack,
              tooltip: 'Back to projects',
            ),
            const SizedBox(width: AppSpacing.xs),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  projectName,
                  style: AppTypography.titleMedium.copyWith(
                    color: AppColors.neutral600,
                  ),
                ),
                Text(
                  canvasSize,
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.neutral400,
                  ),
                ),
              ],
            ),
            const Spacer(),

            // Action Icons
            IconButton(
              icon: const Icon(Icons.undo_rounded, color: AppColors.neutral500),
              onPressed: onUndo,
              tooltip: 'Undo (Ctrl+Z)',
            ),
            IconButton(
              icon: const Icon(Icons.redo_rounded, color: AppColors.neutral500),
              onPressed: onRedo,
              tooltip: 'Redo (Ctrl+Y)',
            ),
            const VerticalDivider(indent: 12, endIndent: 12),
            IconButton(
              icon: const Icon(Icons.save_outlined, color: AppColors.neutral500),
              onPressed: onSave,
              tooltip: 'Save Project',
            ),
            IconButton(
              icon: const Icon(Icons.ios_share_rounded, color: AppColors.neutral500),
              onPressed: onExport,
              tooltip: 'Export Artwork',
            ),
            IconButton(
              icon: const Icon(Icons.share_outlined, color: AppColors.neutral500),
              onPressed: onShare,
              tooltip: 'Share Artwork',
            ),
            IconButton(
              icon: const Icon(Icons.settings_outlined, color: AppColors.neutral500),
              onPressed: onSettings,
              tooltip: 'Canvas Settings',
            ),
          ],
        ),
      );
}
