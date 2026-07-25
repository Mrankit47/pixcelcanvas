import 'package:pixelcanvas/core/domain/entity.dart';
import 'package:pixelcanvas/core/domain/value_objects/identifiers.dart';
import 'package:pixelcanvas/features/projects/domain/entities/canvas.dart';

/// Project Domain Entity per Blueprint §6.1 & §11.2.
///
/// **Purpose**: Master entity representing a pixel art project.
/// **Responsibilities**: Encapsulates project title, owner ID, canvas, timestamps, favorite status, and sync status.
/// **Future Persistence Notes**: Mapped to Isar `@collection` `ProjectModel` and Supabase `projects` table.
class Project extends Entity<ProjectId> {
  /// Creates a [Project] domain entity.
  const Project({
    required ProjectId id,
    required this.ownerId,
    required this.title,
    required this.canvas,
    required this.createdAt,
    required this.updatedAt,
    this.isFavorite = false,
    this.isSynced = true,
  }) : super(id);

  /// Owner user ID.
  final UserId ownerId;

  /// Project title.
  final String title;

  /// Embedded canvas matrix entity.
  final Canvas canvas;

  /// Creation timestamp.
  final DateTime createdAt;

  /// Last updated timestamp.
  final DateTime updatedAt;

  /// Favorite status.
  final bool isFavorite;

  /// Cloud sync status.
  final bool isSynced;

  @override
  List<Object?> get props => [
        id,
        ownerId,
        title,
        canvas,
        createdAt,
        updatedAt,
        isFavorite,
        isSynced,
      ];
}
