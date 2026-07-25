import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/community/presentation/widgets/artwork_card.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';

/// Responsive GridView displaying community artwork cards per Blueprint §5.1 & §6.2.
///
/// **Purpose**: Responsive 2-column (mobile), 3-column (tablet), or 4-column (desktop) artwork grid.
/// **Parameters**:
/// - [itemCount]: Item count (default: 12).
/// - [onPreview]: Callback when artwork is tapped.
/// - [onLike]: Callback when like is tapped.
///
/// **Future Extension Notes**: Consumes `List<CommunityArtworkEntity>` in Phase 2 Step 9.
class ArtworkGrid extends StatelessWidget {
  /// Creates an [ArtworkGrid].
  const ArtworkGrid({
    this.itemCount = 12,
    this.onPreview,
    this.onLike,
    super.key,
  });

  /// Item count.
  final int itemCount;

  /// Preview callback.
  final ValueChanged<int>? onPreview;

  /// Like callback.
  final ValueChanged<int>? onLike;

  static const List<Map<String, dynamic>> _placeholders = [
    {'title': 'Neon Knight', 'artist': 'PixelGuru', 'likes': 342, 'views': 1200, 'liked': true},
    {'title': 'Retro Cyberpunk', 'artist': 'RetroCrafter', 'likes': 210, 'views': 890, 'liked': false},
    {'title': 'Space Rover', 'artist': 'AstroSprite', 'likes': 512, 'views': 2300, 'liked': true},
    {'title': 'Fantasy Castle', 'artist': 'PixelQueen', 'likes': 190, 'views': 760, 'liked': false},
    {'title': 'Coin Quest', 'artist': 'CyberNinja', 'likes': 98, 'views': 410, 'liked': false},
    {'title': 'Dungeon Portal', 'artist': 'PixelGuru', 'likes': 420, 'views': 1800, 'liked': true},
    {'title': 'Magic Potion', 'artist': 'RetroCrafter', 'likes': 310, 'views': 1100, 'liked': false},
    {'title': 'Sci-Fi Mech', 'artist': 'AstroSprite', 'likes': 680, 'views': 3100, 'liked': true},
    {'title': 'Pixel Landscape', 'artist': 'PixelQueen', 'likes': 275, 'views': 950, 'liked': false},
    {'title': 'Game Tilemap', 'artist': 'CyberNinja', 'likes': 145, 'views': 520, 'liked': false},
    {'title': 'Alien Insect', 'artist': 'PixelGuru', 'likes': 290, 'views': 1050, 'liked': true},
    {'title': 'Health Crystal', 'artist': 'RetroCrafter', 'likes': 380, 'views': 1400, 'liked': true},
  ];

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          final crossAxisCount = constraints.maxWidth > 900
              ? 4
              : constraints.maxWidth > 600
                  ? 3
                  : 2;

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: itemCount,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: AppSpacing.sm,
              mainAxisSpacing: AppSpacing.sm,
              childAspectRatio: 0.85,
            ),
            itemBuilder: (context, index) {
              final item = _placeholders[index % _placeholders.length];
              return ArtworkCard(
                title: item['title'] as String,
                artistName: item['artist'] as String,
                likes: item['likes'] as int,
                views: item['views'] as int,
                isLiked: item['liked'] as bool,
                onPreview: () => onPreview?.call(index),
                onLike: () => onLike?.call(index),
              );
            },
          );
        },
      );
}
