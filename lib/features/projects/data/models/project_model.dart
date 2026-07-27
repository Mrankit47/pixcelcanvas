import 'package:isar/isar.dart';
import 'package:pixelcanvas/core/database/isar_id_generator.dart';
import 'package:pixelcanvas/features/projects/data/models/canvas_model.dart';


/// Isar Local NoSQL Collection for Project Entity per Blueprint §6.2 & §11.2.
///
/// **Purpose**: Persists pixel art projects locally in Isar database.
/// **Mapped Entity**: [Project]
/// **Migration Considerations**: Schema v1 initial collection with indexes on ownerId and updatedAt.
@collection
class ProjectModel {
  /// Creates a [ProjectModel].
  ProjectModel({
    this.uuid = '',
    this.ownerId = '',
    this.title = '',
    this.canvas,
    required this.createdAt,
    required this.updatedAt,
    this.isFavorite = false,
    this.isSynced = true,
  });

  /// Isar primary key.
  Id get id => fastHash(uuid);

  /// Unique UUID string index.
  @Index(unique: true, replace: true)
  String uuid;

  /// Owner user ID index.
  @Index()
  String ownerId;

  /// Project title.
  String title;

  /// Embedded canvas matrix model.
  CanvasModel? canvas;

  /// Creation date.
  DateTime createdAt;

  /// Last updated date index.
  @Index()
  DateTime updatedAt;

  /// Favorite flag.
  bool isFavorite;

  /// Sync status flag.
  bool isSynced;
}
