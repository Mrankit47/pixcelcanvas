import 'package:flutter/material.dart';
import 'package:pixelcanvas/shared/widgets/pc_bottom_sheet.dart';
import 'package:pixelcanvas/shared/widgets/pc_button.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';
import 'package:pixelcanvas/theme/app_typography.dart';

/// Filters bottom sheet modal for Templates Browser per Blueprint §5.1.
///
/// **Purpose**: Category, Difficulty, Canvas Size, and Sort filter options modal.
/// **Parameters**:
/// - [onApply]: Callback when Apply Filters is tapped.
/// - [onReset]: Callback when Reset Filters is tapped.
///
/// **Future Extension Notes**: Interacts with Riverpod `TemplateFilterNotifier` in Phase 2 Step 8.
class TemplateFiltersSheet extends StatelessWidget {
  /// Creates a [TemplateFiltersSheet].
  const TemplateFiltersSheet({
    this.onApply,
    this.onReset,
    super.key,
  });

  /// Apply callback.
  final VoidCallback? onApply;

  /// Reset callback.
  final VoidCallback? onReset;

  /// Static helper to show filters bottom sheet.
  static Future<void> show(
    BuildContext context, {
    required VoidCallback onApply,
  }) =>
      PcBottomSheet.show(
        context,
        title: 'Filter Templates',
        child: TemplateFiltersSheet(
          onApply: () {
            onApply();
            Navigator.of(context).pop();
          },
          onReset: () => Navigator.of(context).pop(),
        ),
      );

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildFilterSection('Difficulty', ['All', 'Beginner', 'Medium', 'Expert']),
          const SizedBox(height: AppSpacing.md),
          _buildFilterSection('Canvas Dimensions', ['All', '16×16', '32×32', '64×64']),
          const SizedBox(height: AppSpacing.md),
          _buildFilterSection('Sort Order', ['Popularity', 'Newest', 'Name (A-Z)']),
          const SizedBox(height: AppSpacing.xl),
          Row(
            children: [
              Expanded(
                child: PcButton(
                  label: 'Reset',
                  variant: PcButtonVariant.outlined,
                  onPressed: onReset,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: PcButton(
                  label: 'Apply Filters',
                  variant: PcButtonVariant.primary,
                  onPressed: onApply,
                ),
              ),
            ],
          ),
        ],
      );

  Widget _buildFilterSection(String title, List<String> options) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTypography.labelMedium.copyWith(color: AppColors.neutral600)),
          const SizedBox(height: AppSpacing.xs),
          Wrap(
            spacing: AppSpacing.xs,
            children: options.map((opt) => Chip(
              label: Text(opt),
              backgroundColor: opt == options.first ? AppColors.primary100 : AppColors.surface,
              labelStyle: AppTypography.labelSmall.copyWith(
                color: opt == options.first ? AppColors.primary500 : AppColors.neutral500,
              ),
            )).toList(),
          ),
        ],
      );
}
