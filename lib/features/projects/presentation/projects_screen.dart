import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pixelcanvas/features/projects/presentation/controllers/projects_controller.dart';
import 'package:pixelcanvas/features/projects/presentation/widgets/empty_projects_state.dart';
import 'package:pixelcanvas/features/projects/presentation/widgets/projects_filter_bar.dart';
import 'package:pixelcanvas/features/projects/presentation/widgets/projects_grid.dart';
import 'package:pixelcanvas/features/projects/presentation/widgets/projects_header.dart';
import 'package:pixelcanvas/features/projects/presentation/widgets/projects_search_bar.dart';
import 'package:pixelcanvas/features/projects/presentation/widgets/projects_sort_sheet.dart';
import 'package:pixelcanvas/navigation/route_paths.dart';
import 'package:pixelcanvas/shared/widgets/pc_loading.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';

/// Production-ready Projects Gallery Screen for PixelCanvas per Blueprint §5.1 & §6.2.
///
/// **Purpose**: Gallery screen reacting to [ProjectsController] state.
/// **Consumed Providers**: [projectsControllerProvider]
class ProjectsScreen extends ConsumerStatefulWidget {
  /// Creates a [ProjectsScreen].
  const ProjectsScreen({super.key});

  @override
  ConsumerState<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends ConsumerState<ProjectsScreen> {
  String _selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(projectsControllerProvider.notifier).loadProjects();
    });
  }

  void _handleSortTap() {
    ProjectsSortSheet.show(
      context,
      selectedOption: 'Recently Edited',
      onSortSelected: (option) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(projectsControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.base,
                vertical: AppSpacing.md,
              ),
              child: Column(
                children: [
                  ProjectsHeader(
                    projectCount: state.projects.length,
                    onCreateProject: () => context.push(RoutePaths.editorPath('new')),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  const ProjectsSearchBar(),
                  const SizedBox(height: AppSpacing.md),
                  ProjectsFilterBar(
                    selectedFilter: _selectedFilter,
                    onFilterSelected: (filter) {
                      setState(() {
                        _selectedFilter = filter;
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: state.isLoading
                  ? const Center(child: PcLoading())
                  : state.projects.isEmpty
                      ? EmptyProjectsState(
                          onCreateProject: () => context.push(RoutePaths.editorPath('new')),
                        )
                      : ProjectsGrid(
                          itemCount: state.projects.length,
                          onProjectTap: (index) => context.push(RoutePaths.editorPath('project_$index')),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
