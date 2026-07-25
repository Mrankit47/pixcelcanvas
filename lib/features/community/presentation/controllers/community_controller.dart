import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixelcanvas/core/di/use_case_providers.dart';
import 'package:pixelcanvas/core/domain/value_objects/identifiers.dart';
import 'package:pixelcanvas/features/community/application/use_cases/get_feed.dart';
import 'package:pixelcanvas/features/community/application/use_cases/publish_artwork.dart';
import 'package:pixelcanvas/features/community/application/use_cases/toggle_like.dart';
import 'package:pixelcanvas/features/community/presentation/state/community_state.dart';

/// Riverpod Controller managing Community Gallery presentation state per Blueprint §6.3.
class CommunityController extends StateNotifier<CommunityState> {
  /// Creates a [CommunityController].
  CommunityController({
    required GetFeed getFeed,
    required PublishArtwork publishArtwork,
    required ToggleLike toggleLike,
  })  : _getFeed = getFeed,
        _publishArtwork = publishArtwork,
        _toggleLike = toggleLike,
        super(const CommunityState());

  final GetFeed _getFeed;
  final PublishArtwork _publishArtwork;
  final ToggleLike _toggleLike;

  /// Loads community feed.
  Future<void> loadFeed() async {
    state = state.copyWith(isLoading: true, errorMessage: () => null);
    final result = await _getFeed(const GetFeedParams(page: 1, pageSize: 20));
    result.fold(
      (paginated) => state = state.copyWith(artworks: paginated.items, isLoading: false),
      (failure) => state = state.copyWith(isLoading: false, errorMessage: () => failure.message),
    );
  }

  /// Publishes a project to community.
  Future<void> publishArtwork(ProjectId projectId, String title) async {
    state = state.copyWith(isLoading: true, errorMessage: () => null);
    final result = await _publishArtwork(PublishArtworkParams(projectId: projectId, title: title));
    result.fold(
      (_) => loadFeed(),
      (failure) => state = state.copyWith(isLoading: false, errorMessage: () => failure.message),
    );
  }

  /// Toggles artwork like.
  Future<void> toggleLike(ArtworkId id) async {
    final result = await _toggleLike(id);
    result.fold(
      (_) => loadFeed(),
      (failure) => state = state.copyWith(errorMessage: () => failure.message),
    );
  }
}

/// Riverpod provider for [CommunityController].
final communityControllerProvider = StateNotifierProvider<CommunityController, CommunityState>((ref) {
  return CommunityController(
    getFeed: ref.watch(getFeedProvider),
    publishArtwork: ref.watch(publishArtworkProvider),
    toggleLike: ref.watch(toggleLikeProvider),
  );
});
