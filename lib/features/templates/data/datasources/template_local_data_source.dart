import 'package:isar/isar.dart';
import 'package:pixelcanvas/core/database/database_service.dart';
import 'package:pixelcanvas/features/templates/data/models/template_model.dart';

/// Contract for local template database operations per Blueprint §6.2.
abstract interface class TemplateLocalDataSource {
  /// Gets all templates.
  Future<List<TemplateModel>> getTemplates();

  /// Gets template by UUID.
  Future<TemplateModel?> getTemplateByUuid(String uuid);

  /// Saves template model.
  Future<void> saveTemplate(TemplateModel template);
}

/// Isar Implementation of [TemplateLocalDataSource].
class TemplateLocalDataSourceImpl implements TemplateLocalDataSource {
  /// Creates a [TemplateLocalDataSourceImpl].
  TemplateLocalDataSourceImpl(this._dbService);

  final DatabaseService _dbService;

  @override
  Future<List<TemplateModel>> getTemplates() async {
    return _dbService.isar.templateModels.where().findAll();
  }

  @override
  Future<TemplateModel?> getTemplateByUuid(String uuid) async {
    return _dbService.isar.templateModels.where().uuidEqualTo(uuid).findFirst();
  }

  @override
  Future<void> saveTemplate(TemplateModel template) async {
    await _dbService.isar.writeTxn(() async {
      await _dbService.isar.templateModels.put(template);
    });
  }
}
