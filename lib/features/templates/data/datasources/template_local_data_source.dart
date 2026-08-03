import 'package:pixelcanvas/features/templates/data/models/template_model.dart';

/// Contract for local template database operations.
abstract interface class TemplateLocalDataSource {
  /// Gets all templates.
  Future<List<TemplateModel>> getTemplates();

  /// Gets template by UUID.
  Future<TemplateModel?> getTemplateByUuid(String uuid);

  /// Saves template model.
  Future<void> saveTemplate(TemplateModel template);
}

/// Pure in-memory implementation of [TemplateLocalDataSource].
class TemplateLocalDataSourceImpl implements TemplateLocalDataSource {
  /// Creates a [TemplateLocalDataSourceImpl].
  TemplateLocalDataSourceImpl(dynamic dbService);

  final List<TemplateModel> _templates = [];

  @override
  Future<List<TemplateModel>> getTemplates() async {
    return List<TemplateModel>.from(_templates);
  }

  @override
  Future<TemplateModel?> getTemplateByUuid(String uuid) async {
    try {
      return _templates.firstWhere((t) => t.uuid == uuid);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> saveTemplate(TemplateModel template) async {
    _templates.removeWhere((t) => t.uuid == template.uuid);
    _templates.add(template);
  }
}
