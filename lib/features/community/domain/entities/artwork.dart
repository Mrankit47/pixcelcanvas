import 'package:pixelcanvas/core/domain/entity.dart';
import 'package:pixelcanvas/core/domain/value_objects/identifiers.dart';

/// Artwork Domain Entity per Blueprint §6.1.
class Artwork extends Entity<ArtworkId> {
  /// Creates an [Artwork].
  const Artwork({
    required ArtworkId id,
    required this.authorId,
    required this.authorName,
    required this.title,
    required this.likesCount,
    required this.viewsCount,
    this.isLiked = false,
    this.tags = const [],
  }) : super(id);

  /// Author ID.
  final UserId authorId;

  /// Author name.
  final String authorName;

  /// Artwork title.
  final String title;

  /// Total likes count.
  final int likesCount;

  /// Total views count.
  final int viewsCount;

  /// True if liked by current user.
  final bool isLiked;

  /// Hashtag strings list.
  final List<String> tags;

  @override
  List<Object?> get props => [
        id,
        authorId,
        authorName,
        title,
        likesCount,
        viewsCount,
        isLiked,
        tags,
      ];
}
