import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixelcanvas/features/community/presentation/controllers/community_controller.dart';
import 'package:pixelcanvas/features/community/presentation/widgets/artwork_grid.dart';
import 'package:pixelcanvas/features/community/presentation/widgets/artwork_preview_dialog.dart';
import 'package:pixelcanvas/features/community/presentation/widgets/community_category_tabs.dart';
import 'package:pixelcanvas/features/community/presentation/widgets/community_filters_sheet.dart';
import 'package:pixelcanvas/features/community/presentation/widgets/community_header.dart';
import 'package:pixelcanvas/features/community/presentation/widgets/community_search_bar.dart';
import 'package:pixelcanvas/features/community/presentation/widgets/empty_community_state.dart';
import 'package:pixelcanvas/features/community/presentation/widgets/featured_artists_carousel.dart';
import 'package:pixelcanvas/features/community/presentation/widgets/trending_tags_section.dart';
import 'package:pixelcanvas/shared/widgets/pc_loading.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';

/// Production-ready Community Gallery Screen for PixelCanvas per Blueprint §5.1 & §6.3.
///
/// **Purpose**: Community social showcase reacting to [CommunityController] state.
/// **Consumed Providers**: [communityControllerProvider]
class CommunityScreen extends ConsumerStatefulWidget {
  /// Creates a [CommunityScreen].
  const CommunityScreen({
    this.artworkCount = 1240,
    this.onSearch,
    this.onCategorySelected,
    this.onArtworkTap,
    this.onArtistTap,
    this.onTagTap,
    super.key,
  });

  /// Artwork count.
  final int artworkCount;

  /// Callbacks.
  final ValueChanged<String>? onSearch;
  final ValueChanged<String>? onCategorySelected;
  final ValueChanged<int>? onArtworkTap;
  final ValueChanged<int>? onArtistTap;
  final ValueChanged<String>? onTagTap;

  @override
  ConsumerState<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends ConsumerState<CommunityScreen> {
  String _selectedCategory = 'Trending';

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(communityControllerProvider.notifier).loadFeed();
    });
  }

  void _handleFilterTap() {
    CommunityFiltersSheet.show(
      context,
      onApply: () {},
    );
  }

  void _handlePreviewTap(int index) {
    ArtworkPreviewDialog.show(
      context,
      title: 'Artwork #${index + 1}',
      artistName: 'PixelArtist',
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(communityControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.base,
            vertical: AppSpacing.md,
          ),
          children: [
            CommunityHeader(
              artworkCount: state.artworks.isNotEmpty ? state.artworks.length : widget.artworkCount,
              onSearch: () {},
              onFilter: _handleFilterTap,
            ),
            const SizedBox(height: AppSpacing.md),
            CommunitySearchBar(
              onSearch: widget.onSearch,
            ),
            const SizedBox(height: AppSpacing.md),
            CommunityCategoryTabs(
              selectedCategory: _selectedCategory,
              onCategorySelected: (cat) {
                setState(() {
                  _selectedCategory = cat;
                });
                widget.onCategorySelected?.call(cat);
              },
            ),
            const SizedBox(height: AppSpacing.xl),
            FeaturedArtistsCarousel(
              onArtistTap: widget.onArtistTap,
            ),
            const SizedBox(height: AppSpacing.xl),
            TrendingTagsSection(
              onTagTap: widget.onTagTap,
            ),
            const SizedBox(height: AppSpacing.xl),
            state.isLoading
                ? const Center(child: PcLoadingIndicator())
                : state.artworks.isEmpty
                    ? EmptyCommunityState(
                        onExplore: () {
                          setState(() {
                            _selectedCategory = 'Trending';
                          });
                        },
                      )
                    : ArtworkGrid(
                        itemCount: 12,
                        onPreview: _handlePreviewTap,
                      ),
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }
}
