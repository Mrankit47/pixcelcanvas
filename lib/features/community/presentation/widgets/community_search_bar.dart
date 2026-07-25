import 'package:flutter/material.dart';
import 'package:pixelcanvas/shared/widgets/pc_text_field.dart';

/// Community Gallery search bar component per Blueprint §5.1.
///
/// **Purpose**: Search input field for searching artwork titles, tags, and artists.
/// **Parameters**:
/// - [onSearch]: Callback emitting search query text.
///
/// **Future Extension Notes**: Search query will filter `CommunityRepository` feed items.
class CommunitySearchBar extends StatelessWidget {
  /// Creates a [CommunitySearchBar].
  const CommunitySearchBar({
    this.onSearch,
    super.key,
  });

  /// Search query callback.
  final ValueChanged<String>? onSearch;

  @override
  Widget build(BuildContext context) => PcTextField(
        variant: PcTextFieldVariant.search,
        hintText: 'Search artworks, tags, or artists...',
        onChanged: onSearch,
      );
}
