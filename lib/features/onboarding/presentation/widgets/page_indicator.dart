import 'package:flutter/material.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_durations.dart';
import 'package:pixelcanvas/theme/app_radius.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';

/// Animated page indicator dots component per Blueprint §5.1.
///
/// **Purpose**: Indicates current active page index in onboarding sequence with animated pill expansion.
/// **Parameters**:
/// - [count]: Total page count.
/// - [currentIndex]: Current active page index.
///
/// **Future Extension Notes**: Supports tap-to-page navigation if needed.
class PageIndicator extends StatelessWidget {
  /// Creates a [PageIndicator].
  const PageIndicator({
    required this.count,
    required this.currentIndex,
    super.key,
  });

  /// Total page count.
  final int count;

  /// Active page index.
  final int currentIndex;

  @override
  Widget build(BuildContext context) => Semantics(
        label: 'Page ${currentIndex + 1} of $count',
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(count, (index) {
            final isActive = index == currentIndex;
            return AnimatedContainer(
              duration: AppDurations.fast,
              margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
              width: isActive ? 24.0 : 8.0,
              height: 8.0,
              decoration: BoxDecoration(
                color: isActive ? AppColors.primary500 : AppColors.neutral200,
                borderRadius: AppRadius.borderFull,
              ),
            );
          }),
        ),
      );
}
