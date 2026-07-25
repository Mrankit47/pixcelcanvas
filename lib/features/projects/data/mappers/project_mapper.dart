import 'package:pixelcanvas/core/domain/value_objects/domain_values.dart';
import 'package:pixelcanvas/core/domain/value_objects/identifiers.dart';
import 'package:pixelcanvas/features/projects/data/models/canvas_model.dart';
import 'package:pixelcanvas/features/projects/data/models/layer_model.dart';
import 'package:pixelcanvas/features/projects/data/models/project_model.dart';
import 'package:pixelcanvas/features/projects/domain/entities/canvas.dart';
import 'package:pixelcanvas/features/projects/domain/entities/layer.dart';
import 'package:pixelcanvas/features/projects/domain/entities/project.dart';

/// Bidirectional Mapper between [Project] domain entity and [ProjectModel] Isar collection per Blueprint §6.2.
abstract final class ProjectMapper {
  /// Converts [ProjectModel] to [Project] domain entity.
  static Project toDomain(ProjectModel model) => Project(
        id: ProjectId(model.uuid),
        ownerId: UserId(model.ownerId),
        title: model.title,
        canvas: _canvasToDomain(model.canvas ?? CanvasModel()),
        createdAt: model.createdAt,
        updatedAt: model.updatedAt,
        isFavorite: model.isFavorite,
        isSynced: model.isSynced,
      );

  /// Converts [Project] domain entity to [ProjectModel].
  static ProjectModel fromDomain(Project entity) => ProjectModel(
        uuid: entity.id.value,
        ownerId: entity.ownerId.value,
        title: entity.title,
        canvas: _canvasFromDomain(entity.canvas),
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
        isFavorite: entity.isFavorite,
        isSynced: entity.isSynced,
      );

  static Canvas _canvasToDomain(CanvasModel model) => Canvas(
        id: CanvasId(model.uuid),
        size: CanvasSize(model.width, model.height),
        layers: model.layers.map(_layerToDomain).toList(),
      );

  static CanvasModel _canvasFromDomain(Canvas entity) => CanvasModel(
        uuid: entity.id.value,
        width: entity.size.width,
        height: entity.size.height,
        layers: entity.layers.map(_layerFromDomain).toList(),
      );

  static Layer _layerToDomain(LayerModel model) => Layer(
        id: LayerId(model.uuid),
        name: model.name,
        isVisible: model.isVisible,
        isLocked: model.isLocked,
        opacity: model.opacity,
        index: model.index,
      );

  static LayerModel _layerFromDomain(Layer entity) => LayerModel(
        uuid: entity.id.value,
        name: entity.name,
        isVisible: entity.isVisible,
        isLocked: entity.isLocked,
        opacity: entity.opacity,
        index: entity.index,
      );
}
