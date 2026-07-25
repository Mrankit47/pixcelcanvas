import 'package:pixelcanvas/core/domain/value_objects/identifiers.dart';
import 'package:pixelcanvas/features/community/data/models/artwork_model.dart';
import 'package:pixelcanvas/features/community/domain/entities/artwork.dart';

/// Bidirectional Mapper between [Artwork] domain entity and [ArtworkModel] Isar collection.
abstract final class ArtworkMapper {
  /// Converts [ArtworkModel] to [Artwork] domain entity.
  static Artwork toDomain(ArtworkModel model) => Artwork(
        id: ArtworkId(model.uuid),
        authorId: UserId(model.authorId),
        authorName: model.authorName,
        title: model.title,
        likesCount: model.likesCount,
        viewsCount: model.viewsCount,
        isLiked: model.isLiked,
        tags: model.tags,
      );

  /// Converts [Artwork] domain entity to [ArtworkModel].
  static ArtworkModel fromDomain(Artwork entity) => ArtworkModel(
        uuid: entity.id.value,
        authorId: entity.authorId.value,
        authorName: entity.authorName,
        title: entity.title,
        likesCount: entity.likesCount,
        viewsCount: entity.viewsCount,
        isLiked: entity.isLiked,
        tags: entity.tags,
      );
}
