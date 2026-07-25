import 'package:pixelcanvas/core/domain/result.dart';
import 'package:pixelcanvas/core/domain/use_case.dart';
import 'package:pixelcanvas/core/domain/value_objects/identifiers.dart';
import 'package:pixelcanvas/features/community/domain/entities/artwork.dart';
import 'package:pixelcanvas/features/community/domain/repositories/community_repository.dart';

/// Parameter object for [PublishArtwork] use case.
final class PublishArtworkParams {
  /// Creates a [PublishArtworkParams].
  const PublishArtworkParams({
    required this.projectId,
    required this.title,
  });

  /// Project ID to publish.
  final ProjectId projectId;

  /// Artwork title.
  final String title;
}

/// Concrete Use Case publishing a project to community showcase per Blueprint §6.1.
class PublishArtwork implements UseCase<PublishArtworkParams, Artwork> {
  /// Creates a [PublishArtwork] usecase.
  const PublishArtwork(this._communityRepository);

  final CommunityRepository _communityRepository;

  @override
  Future<Result<Artwork>> call(PublishArtworkParams params) =>
      _communityRepository.publishArtwork(params.projectId, params.title);
}
