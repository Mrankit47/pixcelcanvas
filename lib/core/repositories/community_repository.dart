import 'package:pixelcanvas/core/repositories/repository.dart';

/// Community repository interface contract per Blueprint §6.2 and §14.
///
/// Purpose: Manages community gallery feed, publishing artworks, and artwork likes.
/// Responsibilities: Gallery feed pagination, artwork publishing, and like toggling.
/// Future Implementation Notes: Concrete implementation `CommunityRepositoryImpl` in `features/community/data/`.
abstract class CommunityRepository implements Repository<Map<String, dynamic>, String> {
  /// Fetches public gallery feed with cursor pagination per Blueprint §37.1.
  Future<List<Map<String, dynamic>>> getGalleryFeed({
    int limit = 20,
    String? cursor,
  });

  /// Publishes local artwork project to community gallery.
  Future<void> publishArtwork({
    required String projectId,
    required String title,
    required String description,
  });

  /// Toggles like status on a published artwork.
  Future<bool> toggleLike(String artworkId);
}
