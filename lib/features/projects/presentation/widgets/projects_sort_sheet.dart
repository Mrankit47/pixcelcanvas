import 'package:flutter/material.dart';
import 'package:pixelcanvas/shared/widgets/pc_bottom_sheet.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';
import 'package:pixelcanvas/theme/app_typography.dart';

/// Sort options bottom sheet modal for Projects Gallery per Blueprint §5.1.
///
/// **Purpose**: Presents sort order options ("Recently Edited", "Name (A-Z)", "Date Created", "Canvas Size").
/// **Parameters**:
/// - [selectedOption]: Active sort option label.
/// - [onSortSelected]: Callback when sort option is selected.
///
/// **Future Extension Notes**: Interacts with Riverpod `ProjectSortNotifier` in Phase 2 Step 6.
class ProjectsSortSheet extends StatelessWidget {
  /// Creates a [ProjectsSortSheet].
  const ProjectsSortSheet({
    this.selectedOption = 'Recently Edited',
    this.onSortSelected,
    super.key,
  });

  /// Selected sort option label.
  final String selectedOption;

  /// Sort selection callback.
  final ValueChanged<String>? onSortSelected;

  static const List<Map<String, dynamic>> _sortOptions = [
    {'label': 'Recently Edited', 'icon': Icons.access_time_rounded},
    {'label': 'Name (A-Z)', 'icon': Icons.sort_by_alpha_rounded},
    {'label': 'Date Created', 'icon': Icons.calendar_today_rounded},
    {'label': 'Canvas Size', 'icon': Icons.aspect_ratio_rounded},
  ];

  /// Static helper to display sort bottom sheet.
  static Future<void> show(
    BuildContext context, {
    required String selectedOption,
    required ValueChanged<String> onSortSelected,
  }) =>
      PcBottomSheet.show(
        context,
        title: 'Sort Projects',
        child: ProjectsSortSheet(
          selectedOption: selectedOption,
          onSortSelected: (val) {
            onSortSelected(val);
            Navigator.of(context).pop();
          },
        ),
      );

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: _sortOptions.map((item) {
          final label = item['label'] as String;
          final icon = item['icon'] as IconData;
          final isSelected = label == selectedOption;

          return ListTile(
            leading: Icon(
              icon,
              color: isSelected ? AppColors.primary500 : AppColors.neutral400,
            ),
            title: Text(
              label,
              style: AppTypography.bodyMedium.copyWith(
                color: isSelected ? AppColors.primary500 : AppColors.neutral600,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
            trailing: isSelected
                ? const Icon(Icons.check_rounded, color: AppColors.primary500)
                : null,
            onTap: () => onSortSelected?.call(label),
          );
        }).toList(),
      );
}
