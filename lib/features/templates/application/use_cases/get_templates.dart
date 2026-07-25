import 'package:pixelcanvas/core/domain/result.dart';
import 'package:pixelcanvas/core/domain/use_case.dart';
import 'package:pixelcanvas/features/templates/domain/entities/template.dart';
import 'package:pixelcanvas/features/templates/domain/repositories/template_repository.dart';

/// Concrete Use Case fetching starter templates per Blueprint §6.1.
class GetTemplates implements UseCase<NoParams, List<Template>> {
  /// Creates a [GetTemplates] usecase.
  const GetTemplates(this._templateRepository);

  final TemplateRepository _templateRepository;

  @override
  Future<Result<List<Template>>> call(NoParams params) => _templateRepository.getTemplates();
}
