import 'package:flutter/material.dart';
import 'package:pixelcanvas/shared/widgets/pc_empty_state.dart';

/// Empty state container for Community Gallery per Blueprint §5.1.
///
/// **Purpose**: Displayed when search yields 0 community artworks.
/// **Parameters**:
/// - [onExplore]: Callback when Explore button is tapped.
///
/// **Future Extension Notes**: Triggered dynamically when `CommunityRepository` feed query returns empty.
class EmptyCommunityState extends StatelessWidget {
  /// Creates an [EmptyCommunityState].
  const EmptyCommunityState({
    this.onExplore,
    super.key,
  });

  /// Explore callback.
  final VoidCallback? onExplore;

  @override
  Widget build(BuildContext context) => PcEmptyState(
        title: 'No Artworks Found',
        message: 'No pixel art matches your current search or feed filter.',
        icon: Icons.explore_outlined,
        actionLabel: 'Explore Trending Art',
        onAction: onExplore,
      );
}
