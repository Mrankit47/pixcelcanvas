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
  final List<TemplateModel> _inMemoryTemplates = [];

  @override
  Future<List<TemplateModel>> getTemplates() async {
    final isar = _dbService.isar;
    if (isar != null) {
      return isar.collection<TemplateModel>().where().findAll();
    }
    return _inMemoryTemplates;
  }

  @override
  Future<TemplateModel?> getTemplateByUuid(String uuid) async {
    final list = await getTemplates();
    try {
      return list.firstWhere((t) => t.uuid == uuid);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> saveTemplate(TemplateModel template) async {
    final isar = _dbService.isar;
    if (isar != null) {
      await isar.writeTxn(() async {
        await isar.collection<TemplateModel>().put(template);
      });
    } else {
      _inMemoryTemplates.removeWhere((t) => t.uuid == template.uuid);
      _inMemoryTemplates.add(template);
    }
  }
}
