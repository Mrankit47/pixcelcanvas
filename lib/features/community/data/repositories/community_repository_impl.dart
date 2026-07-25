import 'package:pixelcanvas/core/domain/failure.dart';
import 'package:pixelcanvas/core/domain/paginated_result.dart';
import 'package:pixelcanvas/core/domain/result.dart';
import 'package:pixelcanvas/core/domain/value_objects/identifiers.dart';
import 'package:pixelcanvas/features/community/data/datasources/community_local_data_source.dart';
import 'package:pixelcanvas/features/community/data/mappers/artwork_mapper.dart';
import 'package:pixelcanvas/features/community/domain/entities/artwork.dart';
import 'package:pixelcanvas/features/community/domain/repositories/community_repository.dart';

/// Implementation of [CommunityRepository] domain contract per Blueprint §6.2.
class CommunityRepositoryImpl implements CommunityRepository {
  /// Creates a [CommunityRepositoryImpl].
  CommunityRepositoryImpl(this._localDataSource);

  final CommunityLocalDataSource _localDataSource;

  @override
  Future<Result<PaginatedResult<Artwork>>> getFeed({
    required int page,
    required int pageSize,
    String? category,
    String? tag,
  }) async {
    try {
      final models = await _localDataSource.getArtworks();
      var filtered = models;

      if (tag != null && tag.isNotEmpty) {
        filtered = filtered.where((a) => a.tags.contains(tag)).toList();
      }

      final total = filtered.length;
      final startIndex = (page - 1) * pageSize;
      if (startIndex >= total) {
        return Success(PaginatedResult(
          items: const [],
          totalCount: total,
          page: page,
          pageSize: pageSize,
          hasMore: false,
        ));
      }

      final endIndex = (startIndex + pageSize < total) ? startIndex + pageSize : total;
      final items = filtered.sublist(startIndex, endIndex).map(ArtworkMapper.toDomain).toList();

      return Success(PaginatedResult(
        items: items,
        totalCount: total,
        page: page,
        pageSize: pageSize,
        hasMore: endIndex < total,
      ));
    } catch (e) {
      return FailureResult(StorageFailure('Failed to load community feed', e));
    }
  }

  @override
  Future<Result<Artwork>> toggleLike(ArtworkId id) async {
    try {
      final model = await _localDataSource.getArtworkByUuid(id.value);
      if (model == null) {
        return FailureResult(ValidationFailure('Artwork not found: ${id.value}'));
      }
      model.isLiked = !model.isLiked;
      model.likesCount += model.isLiked ? 1 : -1;
      await _localDataSource.saveArtwork(model);
      return Success(ArtworkMapper.toDomain(model));
    } catch (e) {
      return FailureResult(StorageFailure('Failed to toggle artwork like', e));
    }
  }

  @override
  Future<Result<Artwork>> publishArtwork(ProjectId projectId, String title) async {
    try {
      final artwork = Artwork(
        id: ArtworkId('artwork_${projectId.value}'),
        authorId: const UserId('user_current'),
        authorName: 'PixelArtist',
        title: title,
        likesCount: 0,
        viewsCount: 1,
        isLiked: false,
        tags: const ['#PixelArt'],
      );
      await _localDataSource.saveArtwork(ArtworkMapper.fromDomain(artwork));
      return Success(artwork);
    } catch (e) {
      return FailureResult(StorageFailure('Failed to publish artwork', e));
    }
  }
}
