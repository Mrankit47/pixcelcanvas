import 'package:flutter/material.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_durations.dart';
import 'package:pixelcanvas/theme/app_radius.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';
import 'package:pixelcanvas/theme/app_typography.dart';

/// Horizontal filter chip selector for Projects Gallery per Blueprint §5.1.
///
/// **Purpose**: Filters projects by category ("All", "Recent", "Favorites", "Shared", "Archived").
/// **Parameters**:
/// - [selectedFilter]: Currently active filter label string (default: "All").
/// - [onFilterSelected]: Callback emitting selected filter label.
///
/// **Future Extension Notes**: Interacts with Riverpod `ProjectFilterNotifier` in Phase 2 Step 6.
class ProjectsFilterBar extends StatelessWidget {
  /// Creates a [ProjectsFilterBar].
  const ProjectsFilterBar({
    this.selectedFilter = 'All',
    this.onFilterSelected,
    super.key,
  });

  /// Selected filter label.
  final String selectedFilter;

  /// Filter selection callback.
  final ValueChanged<String>? onFilterSelected;

  static const List<String> _filters = [
    'All',
    'Recent',
    'Favorites',
    'Shared',
    'Archived',
  ];

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 36,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _filters.length,
          itemBuilder: (context, index) {
            final filter = _filters[index];
            final isSelected = filter == selectedFilter;

            return Padding(
              padding: const EdgeInsets.only(right: AppSpacing.xs),
              child: AnimatedContainer(
                duration: AppDurations.fast,
                child: ChoiceChip(
                  label: Text(filter),
                  selected: isSelected,
                  onSelected: (_) => onFilterSelected?.call(filter),
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
