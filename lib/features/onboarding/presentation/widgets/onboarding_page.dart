import 'package:flutter/material.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_radius.dart';
import 'package:pixelcanvas/theme/app_shadows.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';
import 'package:pixelcanvas/theme/app_typography.dart';

/// Data model representing content for a single onboarding page.
class OnboardingPageData {
  /// Creates an [OnboardingPageData] instance.
  const OnboardingPageData({
    required this.title,
    required this.description,
    required this.icon,
    this.badgeText,
  });

  /// Page title.
  final String title;

  /// Page description text.
  final String description;

  /// Page hero icon.
  final IconData icon;

  /// Optional badge text.
  final String? badgeText;
}

/// Renders a single onboarding page layout per Blueprint §5.1.
///
/// **Purpose**: Presentational container for individual onboarding steps.
/// **Parameters**:
/// - [data]: Title, description, and icon content model.
/// - [pageIndex]: Index of current page.
///
/// **Future Extension Notes**: Can accept custom Lottie animation asset paths in V2.
class OnboardingPage extends StatelessWidget {
  /// Creates an [OnboardingPage].
  const OnboardingPage({
    required this.data,
    required this.pageIndex,
    super.key,
  });

  /// Page data model.
  final OnboardingPageData data;

  /// Current page index.
  final int pageIndex;

  @override
  Widget build(BuildContext context) => Semantics(
        label: '${data.title}. ${data.description}',
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Hero Icon Card Graphic
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: AppColors.primary50,
                  borderRadius: AppRadius.borderXxl,
                  boxShadow: AppShadows.md,
                ),
                child: Center(
                  child: Icon(
                    data.icon,
                    size: 64,
                    color: AppColors.primary500,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),

              // Title
              Text(
                data.title,
                style: AppTypography.displayMedium.copyWith(
                  color: AppColors.neutral600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.md),

              // Description
              Text(
                data.description,
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.neutral400,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
}
