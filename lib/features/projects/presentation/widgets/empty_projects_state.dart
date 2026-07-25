import 'package:flutter/material.dart';
import 'package:pixelcanvas/shared/widgets/pc_empty_state.dart';

/// Empty state container for Projects Gallery per Blueprint §5.1.
///
/// **Purpose**: Displayed when search yields 0 results or user has 0 saved projects.
/// **Parameters**:
/// - [onCreateProject]: Callback when Create Project button is tapped.
///
/// **Future Extension Notes**: Triggered dynamically when `ProjectRepository` returns an empty list.
class EmptyProjectsState extends StatelessWidget {
  /// Creates an [EmptyProjectsState].
  const EmptyProjectsState({
    this.onCreateProject,
    super.key,
  });

  /// Create project callback.
  final VoidCallback? onCreateProject;

  @override
  Widget build(BuildContext context) => PcEmptyState(
        title: 'No Projects Found',
        message: 'You have not created any pixel art projects yet. Tap below to start your first canvas!',
        icon: Icons.palette_outlined,
        actionLabel: 'Create New Project',
        onAction: onCreateProject,
      );
}
