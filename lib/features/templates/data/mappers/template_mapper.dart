import 'package:pixelcanvas/core/domain/value_objects/domain_values.dart';
import 'package:pixelcanvas/core/domain/value_objects/identifiers.dart';
import 'package:pixelcanvas/features/templates/data/models/template_model.dart';
import 'package:pixelcanvas/features/templates/domain/entities/template.dart';

/// Bidirectional Mapper between [Template] domain entity and [TemplateModel] Isar collection.
abstract final class TemplateMapper {
  /// Converts [TemplateModel] to [Template] domain entity.
  static Template toDomain(TemplateModel model) => Template(
        id: TemplateId(model.uuid),
        name: model.name,
        category: model.category,
        size: CanvasSize(model.width, model.height),
        difficulty: model.difficulty,
        description: model.description,
        badgeText: model.badgeText,
        isFavorite: model.isFavorite,
      );

  /// Converts [Template] domain entity to [TemplateModel].
  static TemplateModel fromDomain(Template entity) => TemplateModel(
        uuid: entity.id.value,
        name: entity.name,
        category: entity.category,
        width: entity.size.width,
        height: entity.size.height,
        difficulty: entity.difficulty,
        description: entity.description,
        badgeText: entity.badgeText,
        isFavorite: entity.isFavorite,
      );
}
