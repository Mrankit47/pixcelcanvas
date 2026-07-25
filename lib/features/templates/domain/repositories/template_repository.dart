import 'package:pixelcanvas/core/domain/paginated_result.dart';
import 'package:pixelcanvas/core/domain/result.dart';
import 'package:pixelcanvas/core/domain/value_objects/identifiers.dart';
import 'package:pixelcanvas/features/templates/domain/entities/template.dart';

/// Contract interface for Starter Templates repository per Blueprint §6.1.
abstract interface class TemplateRepository {
  /// Gets all templates.
  Future<Result<List<Template>>> getTemplates();

  /// Gets paginated templates.
  Future<Result<PaginatedResult<Template>>> getPaginatedTemplates({
    required int page,
    required int pageSize,
    String? category,
    String? query,
  });

  /// Gets single template by ID.
  Future<Result<Template>> getTemplateById(TemplateId id);
}
