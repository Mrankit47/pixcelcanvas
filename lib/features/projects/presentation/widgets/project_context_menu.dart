import 'package:flutter/material.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_typography.dart';

/// Context menu popup for individual project action options per Blueprint §5.1 & §6.2.
///
/// **Purpose**: Three-dot context menu exposing project operations.
/// **Parameters**:
/// - [onRename]: Rename callback.
/// - [onDuplicate]: Duplicate callback.
/// - [onExport]: Export callback.
/// - [onArchive]: Archive callback.
/// - [onDelete]: Delete callback.
///
/// **Future Extension Notes**: Actions will trigger repository mutations in Phase 2 Step 6.
class ProjectContextMenu extends StatelessWidget {
  /// Creates a [ProjectContextMenu].
  const ProjectContextMenu({
    this.onRename,
    this.onDuplicate,
    this.onExport,
    this.onArchive,
    this.onDelete,
    super.key,
  });

  /// Rename callback.
  final VoidCallback? onRename;

  /// Duplicate callback.
  final VoidCallback? onDuplicate;

  /// Export callback.
  final VoidCallback? onExport;

  /// Archive callback.
  final VoidCallback? onArchive;

  /// Delete callback.
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) => PopupMenuButton<String>(
        icon: const Icon(Icons.more_vert_rounded, color: AppColors.neutral400, size: 20),
        onSelected: (value) {
          switch (value) {
            case 'rename':
              onRename?.call();
            case 'duplicate':
              onDuplicate?.call();
            case 'export':
              onExport?.call();
            case 'archive':
              onArchive?.call();
            case 'delete':
              onDelete?.call();
          }
        },
        itemBuilder: (context) => [
          _buildMenuItem('rename', 'Rename', Icons.edit_outlined),
          _buildMenuItem('duplicate', 'Duplicate', Icons.copy_outlined),
          _buildMenuItem('export', 'Export', Icons.ios_share_rounded),
          _buildMenuItem('archive', 'Archive', Icons.archive_outlined),
          _buildMenuItem('delete', 'Delete', Icons.delete_outline_rounded, isDestructive: true),
        ],
      );

  PopupMenuItem<String> _buildMenuItem(
    String value,
    String label,
    IconData icon, {
    bool isDestructive = false,
  }) =>
      PopupMenuItem<String>(
        value: value,
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: isDestructive ? AppColors.dangerMain : AppColors.neutral500,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: AppTypography.labelMedium.copyWith(
                color: isDestructive ? AppColors.dangerMain : AppColors.neutral600,
              ),
            ),
          ],
        ),
      );
}
