import 'package:flutter/material.dart';
import 'package:pixelcanvas/shared/widgets/pc_button.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';
import 'package:pixelcanvas/theme/app_typography.dart';

/// Projects Gallery header bar per Blueprint §5.1 & §6.2.
///
/// **Purpose**: Displays page title, total project count, and Create Project CTA button.
/// **Parameters**:
/// - [projectCount]: Total project count integer (default: 12).
/// - [onCreateProject]: Callback when Create Project button is tapped.
///
/// **Future Extension Notes**: Count will be bound to `ProjectRepository.watchCount()` in Phase 2 Step 6.
class ProjectsHeader extends StatelessWidget {
  /// Creates a [ProjectsHeader].
  const ProjectsHeader({
    this.projectCount = 12,
    this.onCreateProject,
    super.key,
  });

  /// Total projects count.
  final int projectCount;

  /// Create project callback.
  final VoidCallback? onCreateProject;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Projects',
                style: AppTypography.headlineSmall.copyWith(
                  color: AppColors.neutral600,
                ),
              ),
              Text(
                '$projectCount Projects',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.neutral400,
                ),
              ),
            ],
          ),
          PcButton(
            label: 'New Project',
            size: PcButtonSize.small,
            variant: PcButtonVariant.primary,
            leadingIcon: Icons.add_rounded,
            onPressed: onCreateProject,
          ),
        ],
      );
}
