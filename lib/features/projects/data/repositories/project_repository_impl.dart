import 'package:pixelcanvas/core/domain/failure.dart';
import 'package:pixelcanvas/core/domain/paginated_result.dart';
import 'package:pixelcanvas/core/domain/result.dart';
import 'package:pixelcanvas/core/domain/value_objects/identifiers.dart';
import 'package:pixelcanvas/features/projects/data/datasources/project_local_data_source.dart';
import 'package:pixelcanvas/features/projects/data/mappers/project_mapper.dart';
import 'package:pixelcanvas/features/projects/domain/entities/project.dart';
import 'package:pixelcanvas/features/projects/domain/repositories/project_repository.dart';

/// Implementation of [ProjectRepository] domain contract per Blueprint §6.2 & §11.2.
///
/// **Purpose**: Manages project CRUD and local NoSQL persistence via Isar.
/// **Dependencies**: [ProjectLocalDataSource]
/// **Future Extensions**: Will sync with Supabase RemoteDataSource in Phase 3 Step 4.
class ProjectRepositoryImpl implements ProjectRepository {
  /// Creates a [ProjectRepositoryImpl].
  ProjectRepositoryImpl(this._localDataSource);

  final ProjectLocalDataSource _localDataSource;

  @override
  Future<Result<List<Project>>> getProjects() async {
    try {
      final models = await _localDataSource.getProjects();
      final entities = models.map(ProjectMapper.toDomain).toList();
      return Success(entities);
    } catch (e) {
      return FailureResult(StorageFailure('Failed to load projects from storage', e));
    }
  }

  @override
  Future<Result<PaginatedResult<Project>>> getPaginatedProjects({
    required int page,
    required int pageSize,
    String? query,
    String? category,
  }) async {
    try {
      final allModels = await _localDataSource.getProjects();
      var filtered = allModels;

      if (query != null && query.isNotEmpty) {
        filtered = filtered.where((p) => p.title.toLowerCase().contains(query.toLowerCase())).toList();
      }

      final total = filtered.length;
      final startIndex = (page - 1) * pageSize;
      if (startIndex >= total) {
        return Success(PaginatedResult(
          items: const [],
          totalCount: total,
          page: page,
          pageSize: pageSize,
          hasMore: false,
        ));
      }

      final endIndex = (startIndex + pageSize < total) ? startIndex + pageSize : total;
      final pageModels = filtered.sublist(startIndex, endIndex);
      final items = pageModels.map(ProjectMapper.toDomain).toList();

      return Success(PaginatedResult(
        items: items,
        totalCount: total,
        page: page,
        pageSize: pageSize,
        hasMore: endIndex < total,
      ));
    } catch (e) {
      return FailureResult(StorageFailure('Failed to load paginated projects', e));
    }
  }

  @override
  Future<Result<Project>> getProjectById(ProjectId id) async {
    try {
      final model = await _localDataSource.getProjectByUuid(id.value);
      if (model == null) {
        return FailureResult(ValidationFailure('Project not found: ${id.value}'));
      }
      return Success(ProjectMapper.toDomain(model));
    } catch (e) {
      return FailureResult(StorageFailure('Failed to load project by ID', e));
    }
  }

  @override
  Future<Result<Project>> saveProject(Project project) async {
    try {
      final model = ProjectMapper.fromDomain(project);
      await _localDataSource.saveProject(model);
      return Success(project);
    } catch (e) {
      return FailureResult(StorageFailure('Failed to save project', e));
    }
  }

  @override
  Future<Result<void>> deleteProject(ProjectId id) async {
    try {
      await _localDataSource.deleteProject(id.value);
      return const Success(null);
    } catch (e) {
      return FailureResult(StorageFailure('Failed to delete project', e));
    }
  }

  @override
  Future<Result<Project>> toggleFavorite(ProjectId id) async {
    try {
      final model = await _localDataSource.getProjectByUuid(id.value);
      if (model == null) {
        return FailureResult(ValidationFailure('Project not found to favorite'));
      }
      model.isFavorite = !model.isFavorite;
      await _localDataSource.saveProject(model);
      return Success(ProjectMapper.toDomain(model));
    } catch (e) {
      return FailureResult(StorageFailure('Failed to toggle project favorite', e));
    }
  }
}
