import 'package:pixelcanvas/core/domain/failure.dart';
import 'package:pixelcanvas/core/domain/paginated_result.dart';
import 'package:pixelcanvas/core/domain/result.dart';
import 'package:pixelcanvas/core/domain/value_objects/identifiers.dart';
import 'package:pixelcanvas/features/templates/data/datasources/template_local_data_source.dart';
import 'package:pixelcanvas/features/templates/data/mappers/template_mapper.dart';
import 'package:pixelcanvas/features/templates/domain/entities/template.dart';
import 'package:pixelcanvas/features/templates/domain/repositories/template_repository.dart';

/// Implementation of [TemplateRepository] domain contract per Blueprint §6.2.
class TemplateRepositoryImpl implements TemplateRepository {
  /// Creates a [TemplateRepositoryImpl].
  TemplateRepositoryImpl(this._localDataSource);

  final TemplateLocalDataSource _localDataSource;

  @override
  Future<Result<List<Template>>> getTemplates() async {
    try {
      final models = await _localDataSource.getTemplates();
      final entities = models.map(TemplateMapper.toDomain).toList();
      return Success(entities);
    } catch (e) {
      return FailureResult(StorageFailure('Failed to load templates', e));
    }
  }

  @override
  Future<Result<PaginatedResult<Template>>> getPaginatedTemplates({
    required int page,
    required int pageSize,
    String? category,
    String? query,
  }) async {
    try {
      final models = await _localDataSource.getTemplates();
      var filtered = models;

      if (category != null && category.isNotEmpty && category != 'All') {
        filtered = filtered.where((t) => t.category.toLowerCase() == category.toLowerCase()).toList();
      }

      if (query != null && query.isNotEmpty) {
        filtered = filtered.where((t) => t.name.toLowerCase().contains(query.toLowerCase())).toList();
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
      final items = filtered.sublist(startIndex, endIndex).map(TemplateMapper.toDomain).toList();

      return Success(PaginatedResult(
        items: items,
        totalCount: total,
        page: page,
        pageSize: pageSize,
        hasMore: endIndex < total,
      ));
    } catch (e) {
      return FailureResult(StorageFailure('Failed to load paginated templates', e));
    }
  }

  @override
  Future<Result<Template>> getTemplateById(TemplateId id) async {
    try {
      final model = await _localDataSource.getTemplateByUuid(id.value);
      if (model == null) {
        return FailureResult(ValidationFailure('Template not found: ${id.value}'));
      }
      return Success(TemplateMapper.toDomain(model));
    } catch (e) {
      return FailureResult(StorageFailure('Failed to load template by ID', e));
    }
  }
}
