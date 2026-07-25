import 'package:pixelcanvas/core/domain/paginated_result.dart';
import 'package:pixelcanvas/core/domain/result.dart';
import 'package:pixelcanvas/core/domain/value_objects/identifiers.dart';
import 'package:pixelcanvas/features/community/domain/entities/artwork.dart';

/// Contract interface for Community feed and social interactions per Blueprint §6.1 & §14.1.
abstract interface class CommunityRepository {
  /// Gets paginated community artworks feed.
  Future<Result<PaginatedResult<Artwork>>> getFeed({
    required int page,
    required int pageSize,
    String? category,
    String? tag,
  });

  /// Toggles like status for an artwork.
  Future<Result<Artwork>> toggleLike(ArtworkId id);

  /// Publishes a project to community showcase.
  Future<Result<Artwork>> publishArtwork(ProjectId projectId, String title);
}
