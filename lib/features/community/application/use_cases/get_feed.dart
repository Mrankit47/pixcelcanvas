import 'package:pixelcanvas/core/domain/paginated_result.dart';
import 'package:pixelcanvas/core/domain/result.dart';
import 'package:pixelcanvas/core/domain/use_case.dart';
import 'package:pixelcanvas/features/community/domain/entities/artwork.dart';
import 'package:pixelcanvas/features/community/domain/repositories/community_repository.dart';

/// Parameter object for [GetFeed] use case query.
final class GetFeedParams {
  /// Creates a [GetFeedParams].
  const GetFeedParams({
    required this.page,
    required this.pageSize,
    this.category,
    this.tag,
  });

  /// Page index.
  final int page;

  /// Page size.
  final int pageSize;

  /// Category filter.
  final String? category;

  /// Hashtag filter.
  final String? tag;
}

/// Concrete Use Case fetching paginated community feed per Blueprint §6.1.
class GetFeed implements UseCase<GetFeedParams, PaginatedResult<Artwork>> {
  /// Creates a [GetFeed] usecase.
  const GetFeed(this._communityRepository);

  final CommunityRepository _communityRepository;

  @override
  Future<Result<PaginatedResult<Artwork>>> call(GetFeedParams params) =>
      _communityRepository.getFeed(
        page: params.page,
        pageSize: params.pageSize,
        category: params.category,
        tag: params.tag,
      );
}
