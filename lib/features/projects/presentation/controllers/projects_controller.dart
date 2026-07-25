import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixelcanvas/core/di/use_case_providers.dart';
import 'package:pixelcanvas/core/domain/use_case.dart';
import 'package:pixelcanvas/core/domain/value_objects/identifiers.dart';
import 'package:pixelcanvas/features/projects/application/use_cases/delete_project.dart';
import 'package:pixelcanvas/features/projects/application/use_cases/get_projects.dart';
import 'package:pixelcanvas/features/projects/application/use_cases/save_project.dart';
import 'package:pixelcanvas/features/projects/application/use_cases/toggle_favorite.dart';
import 'package:pixelcanvas/features/projects/domain/entities/project.dart';
import 'package:pixelcanvas/features/projects/presentation/state/projects_state.dart';

/// Riverpod Controller managing Projects Gallery presentation state per Blueprint §6.3.
class ProjectsController extends StateNotifier<ProjectsState> {
  /// Creates a [ProjectsController].
  ProjectsController({
    required GetProjects getProjects,
    required SaveProject saveProject,
    required DeleteProject deleteProject,
    required ToggleFavorite toggleFavorite,
  })  : _getProjects = getProjects,
        _saveProject = saveProject,
        _deleteProject = deleteProject,
        _toggleFavorite = toggleFavorite,
        super(const ProjectsState());

  final GetProjects _getProjects;
  final SaveProject _saveProject;
  final DeleteProject _deleteProject;
  final ToggleFavorite _toggleFavorite;

  /// Loads projects list.
  Future<void> loadProjects() async {
    state = state.copyWith(isLoading: true, errorMessage: () => null);
    final result = await _getProjects(const NoParams());
    result.fold(
      (projects) => state = state.copyWith(projects: projects, isLoading: false),
      (failure) => state = state.copyWith(isLoading: false, errorMessage: () => failure.message),
    );
  }

  /// Saves or creates a project.
  Future<void> saveProject(Project project) async {
    state = state.copyWith(isLoading: true, errorMessage: () => null);
    final result = await _saveProject(project);
    result.fold(
      (_) => loadProjects(),
      (failure) => state = state.copyWith(isLoading: false, errorMessage: () => failure.message),
    );
  }

  /// Deletes a project by ID.
  Future<void> deleteProject(ProjectId id) async {
    state = state.copyWith(isLoading: true, errorMessage: () => null);
    final result = await _deleteProject(id);
    result.fold(
      (_) => loadProjects(),
      (failure) => state = state.copyWith(isLoading: false, errorMessage: () => failure.message),
    );
  }

  /// Toggles favorite status.
  Future<void> toggleFavorite(ProjectId id) async {
    final result = await _toggleFavorite(id);
    result.fold(
      (_) => loadProjects(),
      (failure) => state = state.copyWith(errorMessage: () => failure.message),
    );
  }
}

/// Riverpod provider for [ProjectsController].
final projectsControllerProvider = StateNotifierProvider<ProjectsController, ProjectsState>((ref) {
  return ProjectsController(
    getProjects: ref.watch(getProjectsProvider),
    saveProject: ref.watch(saveProjectProvider),
    deleteProject: ref.watch(deleteProjectProvider),
    toggleFavorite: ref.watch(toggleFavoriteProvider),
  );
});
