import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/onboarding/presentation/widgets/get_started_button.dart';
import 'package:pixelcanvas/features/onboarding/presentation/widgets/next_button.dart';
import 'package:pixelcanvas/features/onboarding/presentation/widgets/page_indicator.dart';
import 'package:pixelcanvas/features/onboarding/presentation/widgets/skip_button.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';

/// Navigation controls footer bar for onboarding screen per Blueprint §5.1.
///
/// **Purpose**: Integrates [PageIndicator], [SkipButton], [NextButton], and [GetStartedButton].
/// **Parameters**:
/// - [pageCount]: Total page count (4).
/// - [currentIndex]: Active page index.
/// - [onSkip]: Skip callback.
/// - [onNext]: Next callback.
/// - [onGetStarted]: Get Started callback.
///
/// **Future Extension Notes**: Callbacks are wired to navigation controller in parent screen.
class NavigationControls extends StatelessWidget {
  /// Creates a [NavigationControls].
  const NavigationControls({
    required this.pageCount,
    required this.currentIndex,
    required this.onSkip,
    required this.onNext,
    required this.onGetStarted,
    super.key,
  });

  /// Total pages.
  final int pageCount;

  /// Current page index.
  final int currentIndex;

  /// Skip callback.
  final VoidCallback onSkip;

  /// Next callback.
  final VoidCallback onNext;

  /// Get Started callback.
  final VoidCallback onGetStarted;

  bool get _isLastPage => currentIndex == pageCount - 1;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.lg,
        ),
        child: _isLastPage
            ? GetStartedButton(onPressed: onGetStarted)
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SkipButton(onPressed: onSkip),
                  PageIndicator(
                    count: pageCount,
                    currentIndex: currentIndex,
                  ),
                  NextButton(onPressed: onNext),
                ],
              ),
      );
}
