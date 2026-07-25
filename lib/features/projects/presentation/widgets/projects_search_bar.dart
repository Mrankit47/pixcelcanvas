import 'package:flutter/material.dart';
import 'package:pixelcanvas/shared/widgets/pc_text_field.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_radius.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';

/// Projects search and sort toolbar component per Blueprint §5.1.
///
/// **Purpose**: Search bar input with sort filter trigger button.
/// **Parameters**:
/// - [onSearch]: Callback emitting search query string.
/// - [onSort]: Callback when sort button is tapped.
///
/// **Future Extension Notes**: Search query will debounce search in `ProjectRepository`.
class ProjectsSearchBar extends StatelessWidget {
  /// Creates a [ProjectsSearchBar].
  const ProjectsSearchBar({
    this.onSearch,
    this.onSort,
    super.key,
  });

  /// Search callback.
  final ValueChanged<String>? onSearch;

  /// Sort callback.
  final VoidCallback? onSort;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
            child: PcTextField(
              variant: PcTextFieldVariant.search,
              hintText: 'Search projects by name...',
              onChanged: onSearch,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: AppRadius.borderSm,
              border: Border.all(color: AppColors.outline),
            ),
            child: IconButton(
              icon: const Icon(Icons.sort_rounded, color: AppColors.neutral500),
              onPressed: onSort,
              tooltip: 'Sort projects',
            ),
          ),
        ],
      );
}
