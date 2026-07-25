import 'package:pixelcanvas/core/domain/entity.dart';
import 'package:pixelcanvas/core/domain/value_objects/identifiers.dart';

/// Comment Domain Entity per Blueprint §6.1.
class Comment extends Entity<String> {
  /// Creates a [Comment].
  const Comment({
    required String id,
    required this.authorId,
    required this.authorName,
    required this.content,
    required this.createdAt,
  }) : super(id);

  /// Author user ID.
  final UserId authorId;

  /// Author display name.
  final String authorName;

  /// Comment text body.
  final String content;

  /// Creation timestamp.
  final DateTime createdAt;

  @override
  List<Object?> get props => [id, authorId, authorName, content, createdAt];
}
