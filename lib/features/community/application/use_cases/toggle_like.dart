import 'package:pixelcanvas/core/domain/result.dart';
import 'package:pixelcanvas/core/domain/use_case.dart';
import 'package:pixelcanvas/core/domain/value_objects/identifiers.dart';
import 'package:pixelcanvas/features/community/domain/entities/artwork.dart';
import 'package:pixelcanvas/features/community/domain/repositories/community_repository.dart';

/// Concrete Use Case toggling artwork like status per Blueprint §6.1.
class ToggleLike implements UseCase<ArtworkId, Artwork> {
  /// Creates a [ToggleLike] usecase.
  const ToggleLike(this._communityRepository);

  final CommunityRepository _communityRepository;

  @override
  Future<Result<Artwork>> call(ArtworkId params) => _communityRepository.toggleLike(params);
}
