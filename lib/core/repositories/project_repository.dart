import 'package:pixelcanvas/core/repositories/sync_repository.dart';

/// Project repository interface contract per Blueprint §6.2 and §11.
///
/// Purpose: Manages project CRUD, canvas metadata, layer stack data, and `.pxc` serialization.
/// Responsibilities: Offline project persistence, auto-save local writes, project search, and cloud sync.
/// Future Implementation Notes: Concrete implementation `ProjectRepositoryImpl` will be created in `features/projects/data/`.
abstract class ProjectRepository implements SyncRepository<Map<String, dynamic>, String> {
  /// Fetches recent projects ordered by last modified timestamp.
  Future<List<Map<String, dynamic>>> getRecentProjects({int limit = 20});

  /// Searches local projects by title query.
  Future<List<Map<String, dynamic>>> searchProjects(String query);

  /// Duplicates existing project locally.
  Future<Map<String, dynamic>> duplicateProject(String projectId);
}
