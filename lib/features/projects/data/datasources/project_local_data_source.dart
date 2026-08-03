import 'package:pixelcanvas/features/projects/data/models/project_model.dart';

/// Contract for local project database operations.
abstract interface class ProjectLocalDataSource {
  /// Gets all saved projects.
  Future<List<ProjectModel>> getProjects();

  /// Gets single project by UUID.
  Future<ProjectModel?> getProjectByUuid(String uuid);

  /// Saves or updates a project model.
  Future<void> saveProject(ProjectModel project);

  /// Deletes a project by UUID.
  Future<void> deleteProject(String uuid);
}

/// Pure in-memory implementation of [ProjectLocalDataSource].
class ProjectLocalDataSourceImpl implements ProjectLocalDataSource {
  /// Creates a [ProjectLocalDataSourceImpl].
  ProjectLocalDataSourceImpl(dynamic dbService);

  final List<ProjectModel> _projects = [];

  @override
  Future<List<ProjectModel>> getProjects() async {
    final list = List<ProjectModel>.from(_projects);
    list.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return list;
  }

  @override
  Future<ProjectModel?> getProjectByUuid(String uuid) async {
    try {
      return _projects.firstWhere((p) => p.uuid == uuid);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> saveProject(ProjectModel project) async {
    _projects.removeWhere((p) => p.uuid == project.uuid);
    _projects.add(project);
  }

  @override
  Future<void> deleteProject(String uuid) async {
    _projects.removeWhere((p) => p.uuid == uuid);
  }
}
