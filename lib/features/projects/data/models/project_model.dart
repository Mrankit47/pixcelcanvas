import 'package:pixelcanvas/features/projects/data/models/canvas_model.dart';

/// Local Data Model for Project Entity.
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

  /// Unique UUID string index.
  String uuid;

  /// Owner user ID index.
  String ownerId;

  /// Project title.
  String title;

  /// Embedded canvas matrix model.
  CanvasModel? canvas;

  /// Creation date.
  DateTime createdAt;

  /// Last updated date index.
  DateTime updatedAt;

  /// Favorite flag.
  bool isFavorite;

  /// Sync status flag.
  bool isSynced;
}
