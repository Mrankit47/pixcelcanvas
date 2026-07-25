import 'package:flutter/material.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';
import 'package:pixelcanvas/theme/app_typography.dart';

/// Starter Templates header bar per Blueprint §5.1 & §6.2.
///
/// **Purpose**: Displays page title, total template count, search, and filter buttons.
/// **Parameters**:
/// - [templateCount]: Total templates count integer (default: 24).
/// - [onSearch]: Callback when search button is tapped.
/// - [onFilter]: Callback when filter button is tapped.
///
/// **Future Extension Notes**: Count will bind to `TemplateRepository.watchCount()` in Phase 2 Step 8.
class TemplatesHeader extends StatelessWidget {
  /// Creates a [TemplatesHeader].
  const TemplatesHeader({
    this.templateCount = 24,
    this.onSearch,
    this.onFilter,
    super.key,
  });

  /// Template count integer.
  final int templateCount;

  /// Search button callback.
  final VoidCallback? onSearch;

  /// Filter button callback.
  final VoidCallback? onFilter;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Starter Templates',
                style: AppTypography.headlineSmall.copyWith(
                  color: AppColors.neutral600,
                ),
              ),
              Text(
                '$templateCount Templates',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.neutral400,
                ),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.search_rounded, color: AppColors.neutral500),
                onPressed: onSearch,
                tooltip: 'Search templates',
              ),
              IconButton(
                icon: const Icon(Icons.tune_rounded, color: AppColors.neutral500),
                onPressed: onFilter,
                tooltip: 'Filter templates',
              ),
            ],
          ),
        ],
      );
}
