import 'package:isar/isar.dart';
import 'package:pixelcanvas/core/database/database_service.dart';
import 'package:pixelcanvas/core/database/isar_id_generator.dart';
import 'package:pixelcanvas/features/projects/data/models/project_model.dart';

/// Contract for local project database operations per Blueprint §6.2 & §11.2.
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

/// Isar Implementation of [ProjectLocalDataSource].
class ProjectLocalDataSourceImpl implements ProjectLocalDataSource {
  /// Creates a [ProjectLocalDataSourceImpl].
  ProjectLocalDataSourceImpl(this._dbService);

  final DatabaseService _dbService;

  @override
  Future<List<ProjectModel>> getProjects() async {
    return _dbService.isar.projectModels.where().sortByUpdatedAtDesc().findAll();
  }

  @override
  Future<ProjectModel?> getProjectByUuid(String uuid) async {
    return _dbService.isar.projectModels.where().uuidEqualTo(uuid).findFirst();
  }

  @override
  Future<void> saveProject(ProjectModel project) async {
    await _dbService.isar.writeTxn(() async {
      await _dbService.isar.projectModels.put(project);
    });
  }

  @override
  Future<void> deleteProject(String uuid) async {
    await _dbService.isar.writeTxn(() async {
      await _dbService.isar.projectModels.delete(fastHash(uuid));
    });
  }
}
