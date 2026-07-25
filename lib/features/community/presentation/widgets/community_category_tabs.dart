import 'package:flutter/material.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_durations.dart';
import 'package:pixelcanvas/theme/app_radius.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';
import 'package:pixelcanvas/theme/app_typography.dart';

/// Animated category choice chips bar for Community Gallery per Blueprint §5.1.
///
/// **Purpose**: Filters community feed ("Trending", "Newest", "Following", "Pixel Art", "Animations", "Game Assets", "UI", "Favorites").
/// **Parameters**:
/// - [selectedCategory]: Active category label string (default: "Trending").
/// - [onCategorySelected]: Callback emitting selected category.
///
/// **Future Extension Notes**: Interacts with Riverpod `CommunityFeedCategoryNotifier` in Phase 2 Step 9.
class CommunityCategoryTabs extends StatelessWidget {
  /// Creates a [CommunityCategoryTabs].
  const CommunityCategoryTabs({
    this.selectedCategory = 'Trending',
    this.onCategorySelected,
    super.key,
  });

  /// Selected category string.
  final String selectedCategory;

  /// Selection callback.
  final ValueChanged<String>? onCategorySelected;

  static const List<String> _categories = [
    'Trending',
    'Newest',
    'Following',
    'Pixel Art',
    'Animations',
    'Game Assets',
    'UI',
    'Favorites',
  ];

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 36,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _categories.length,
          itemBuilder: (context, index) {
            final category = _categories[index];
            final isSelected = category == selectedCategory;

            return Padding(
              padding: const EdgeInsets.only(right: AppSpacing.xs),
              child: AnimatedContainer(
                duration: AppDurations.fast,
                child: ChoiceChip(
                  label: Text(category),
                  selected: isSelected,
                  onSelected: (_) => onCategorySelected?.call(category),
                  selectedColor: AppColors.primary500,
                  backgroundColor: AppColors.surface,
                  labelStyle: AppTypography.labelSmall.copyWith(
                    color: isSelected ? AppColors.neutral0 : AppColors.neutral500,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: AppRadius.borderFull,
                    side: BorderSide(
                      color: isSelected ? AppColors.primary500 : AppColors.neutral200,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
}
