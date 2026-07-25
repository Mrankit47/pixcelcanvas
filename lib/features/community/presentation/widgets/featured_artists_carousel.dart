import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/community/presentation/widgets/artist_profile_card.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';
import 'package:pixelcanvas/theme/app_typography.dart';

/// Featured artists horizontal carousel per Blueprint §5.1.
///
/// **Purpose**: Previews top featured artists in a horizontal scroll list.
/// **Parameters**:
/// - [onArtistTap]: Callback receiving artist index when card is tapped.
/// - [onFollowTap]: Callback receiving artist index when Follow is tapped.
///
/// **Future Extension Notes**: Consumes featured creators feed from `CommunityRepository` in Phase 2 Step 9.
class FeaturedArtistsCarousel extends StatelessWidget {
  /// Creates a [FeaturedArtistsCarousel].
  const FeaturedArtistsCarousel({
    this.onArtistTap,
    this.onFollowTap,
    super.key,
  });

  /// Artist tap callback.
  final ValueChanged<int>? onArtistTap;

  /// Follow button callback.
  final ValueChanged<int>? onFollowTap;

  static const List<Map<String, dynamic>> _artists = [
    {'name': 'PixelGuru', 'followers': '14.2k', 'following': false},
    {'name': 'RetroCrafter', 'followers': '8.9k', 'following': true},
    {'name': 'AstroSprite', 'followers': '21.5k', 'following': false},
    {'name': 'CyberNinja', 'followers': '5.3k', 'following': false},
    {'name': 'PixelQueen', 'followers': '11.8k', 'following': true},
  ];

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Featured Artists',
            style: AppTypography.titleMedium.copyWith(
              color: AppColors.neutral600,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          SizedBox(
            height: 155,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _artists.length,
              itemBuilder: (context, index) {
                final item = _artists[index];
                return Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.sm),
                  child: ArtistProfileCard(
                    name: item['name'] as String,
                    followers: item['followers'] as String,
                    isFollowing: item['following'] as bool,
                    onTap: () => onArtistTap?.call(index),
                    onFollow: () => onFollowTap?.call(index),
                  ),
                );
              },
            ),
          ),
        ],
      );
}
