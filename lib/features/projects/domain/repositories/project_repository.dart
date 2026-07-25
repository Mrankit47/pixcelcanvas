import 'package:pixelcanvas/core/domain/paginated_result.dart';
import 'package:pixelcanvas/core/domain/result.dart';
import 'package:pixelcanvas/core/domain/value_objects/identifiers.dart';
import 'package:pixelcanvas/features/projects/domain/entities/project.dart';

/// Contract interface for Project persistence and sync per Blueprint §6.1 & §11.2.
abstract interface class ProjectRepository {
  /// Gets all projects for current user.
  Future<Result<List<Project>>> getProjects();

  /// Gets paginated projects list.
  Future<Result<PaginatedResult<Project>>> getPaginatedProjects({
    required int page,
    required int pageSize,
    String? query,
    String? category,
  });

  /// Gets a single project by ID.
  Future<Result<Project>> getProjectById(ProjectId id);

  /// Saves or creates a project.
  Future<Result<Project>> saveProject(Project project);

  /// Deletes a project by ID.
  Future<Result<void>> deleteProject(ProjectId id);

  /// Toggles favorite status for a project.
  Future<Result<Project>> toggleFavorite(ProjectId id);
}
