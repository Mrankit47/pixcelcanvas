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
  final List<ProjectModel> _inMemoryProjects = [];

  @override
  Future<List<ProjectModel>> getProjects() async {
    final isar = _dbService.isar;
    if (isar != null) {
      final list = await isar.collection<ProjectModel>().where().findAll();
      list.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
      return list;
    }
    final list = List<ProjectModel>.from(_inMemoryProjects);
    list.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return list;
  }

  @override
  Future<ProjectModel?> getProjectByUuid(String uuid) async {
    final isar = _dbService.isar;
    if (isar != null) {
      final list = await isar.collection<ProjectModel>().where().findAll();
      try {
        return list.firstWhere((p) => p.uuid == uuid);
      } catch (_) {
        return null;
      }
    }
    try {
      return _inMemoryProjects.firstWhere((p) => p.uuid == uuid);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> saveProject(ProjectModel project) async {
    final isar = _dbService.isar;
    if (isar != null) {
      await isar.writeTxn(() async {
        await isar.collection<ProjectModel>().put(project);
      });
    } else {
      _inMemoryProjects.removeWhere((p) => p.uuid == project.uuid);
      _inMemoryProjects.add(project);
    }
  }

  @override
  Future<void> deleteProject(String uuid) async {
    final isar = _dbService.isar;
    if (isar != null) {
      await isar.writeTxn(() async {
        await isar.collection<ProjectModel>().delete(fastHash(uuid));
      });
    } else {
      _inMemoryProjects.removeWhere((p) => p.uuid == uuid);
    }
  }
}
