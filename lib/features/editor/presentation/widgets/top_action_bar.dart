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
        decoration: BoxDecoration(
          color: AppColors.panel,
          border: const Border(bottom: BorderSide(color: AppColors.border, width: 1.0)),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary700.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary),
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
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  canvasSize,
                  style: AppTypography.pixelCoordinates,
                ),
              ],
            ),
            const Spacer(),

            // Action Buttons
            IconButton(
              icon: const Icon(Icons.undo_rounded, color: AppColors.textPrimary),
              onPressed: onUndo,
              tooltip: 'Undo (Ctrl+Z)',
            ),
            IconButton(
              icon: const Icon(Icons.redo_rounded, color: AppColors.textPrimary),
              onPressed: onRedo,
              tooltip: 'Redo (Ctrl+Y)',
            ),
            const VerticalDivider(indent: 14, endIndent: 14, color: AppColors.border),
            IconButton(
              icon: const Icon(Icons.save_rounded, color: AppColors.primary500),
              onPressed: onSave,
              tooltip: 'Save Project',
            ),
            IconButton(
              icon: const Icon(Icons.ios_share_rounded, color: AppColors.accentCyan),
              onPressed: onExport,
              tooltip: 'Export Artwork',
            ),
            IconButton(
              icon: const Icon(Icons.share_rounded, color: AppColors.secondary),
              onPressed: onShare,
              tooltip: 'Share Artwork',
            ),
            IconButton(
              icon: const Icon(Icons.settings_rounded, color: AppColors.textSecondary),
              onPressed: onSettings,
              tooltip: 'Canvas Settings',
            ),
          ],
        ),
      );
}
