import 'package:pixelcanvas/core/domain/result.dart';
import 'package:pixelcanvas/core/domain/use_case.dart';
import 'package:pixelcanvas/core/domain/value_objects/identifiers.dart';
import 'package:pixelcanvas/features/templates/domain/entities/template.dart';
import 'package:pixelcanvas/features/templates/domain/repositories/template_repository.dart';

/// Concrete Use Case fetching single template by ID per Blueprint §6.1.
class GetTemplateById implements UseCase<TemplateId, Template> {
  /// Creates a [GetTemplateById] usecase.
  const GetTemplateById(this._templateRepository);

  final TemplateRepository _templateRepository;

  @override
  Future<Result<Template>> call(TemplateId params) => _templateRepository.getTemplateById(params);
}
