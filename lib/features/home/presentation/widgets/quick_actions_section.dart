import 'package:flutter/material.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_radius.dart';
import 'package:pixelcanvas/theme/app_shadows.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';
import 'package:pixelcanvas/theme/app_typography.dart';

/// Quick actions shortcut bar for the Home Dashboard per Blueprint §5.1.
///
/// **Purpose**: Provides 1-tap shortcuts for primary creation tasks.
/// **Parameters**:
/// - [onNewProject]: Callback for New Project.
/// - [onImportImage]: Callback for Import Image.
/// - [onTemplates]: Callback for Templates.
/// - [onColorPalette]: Callback for Color Palette.
///
/// **Future Extension Notes**: Actions will trigger navigation or bottom sheets in Phase 2 Step 5.
class QuickActionsSection extends StatelessWidget {
  /// Creates a [QuickActionsSection].
  const QuickActionsSection({
    this.onNewProject,
    this.onImportImage,
    this.onTemplates,
    this.onColorPalette,
    super.key,
  });

  /// New project callback.
  final VoidCallback? onNewProject;

  /// Import image callback.
  final VoidCallback? onImportImage;

  /// Templates callback.
  final VoidCallback? onTemplates;

  /// Color palette callback.
  final VoidCallback? onColorPalette;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildActionItem(
            context,
            label: 'New Project',
            icon: Icons.add_box_rounded,
            color: AppColors.primary500,
            onTap: onNewProject,
          ),
          _buildActionItem(
            context,
            label: 'Import',
            icon: Icons.image_search_rounded,
            color: AppColors.secondary,
            onTap: onImportImage,
          ),
          _buildActionItem(
            context,
            label: 'Templates',
            icon: Icons.grid_view_rounded,
            color: AppColors.infoMain,
            onTap: onTemplates,
          ),
          _buildActionItem(
            context,
            label: 'Palettes',
            icon: Icons.color_lens_rounded,
            color: AppColors.warningMain,
            onTap: onColorPalette,
          ),
        ],
      );

  Widget _buildActionItem(
    BuildContext context, {
    required String label,
    required IconData icon,
    required Color color,
    VoidCallback? onTap,
  }) =>
      Expanded(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: AppRadius.borderLg,
                boxShadow: AppShadows.xs,
                border: Border.all(color: AppColors.neutral200, width: 0.5),
              ),
              child: Material(
                color: Colors.transparent,
                borderRadius: AppRadius.borderLg,
                child: InkWell(
                  borderRadius: AppRadius.borderLg,
                  onTap: onTap,
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Center(
                      child: Icon(icon, color: color, size: 28),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              label,
              style: AppTypography.labelSmall.copyWith(
                color: AppColors.neutral500,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      );
}
