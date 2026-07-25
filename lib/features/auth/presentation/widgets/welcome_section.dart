import 'package:flutter/material.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';
import 'package:pixelcanvas/theme/app_typography.dart';

/// Welcome headline and subtitle text section for Auth screen per Blueprint §5.1.
///
/// **Purpose**: Welcomes user and explains authentication options.
/// **Parameters**: None.
/// **Future Extension Notes**: Content is localized in future l10n step.
class WelcomeSection extends StatelessWidget {
  /// Creates a [WelcomeSection].
  const WelcomeSection({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(
            'Welcome Back',
            style: AppTypography.displayMedium.copyWith(
              color: AppColors.neutral600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Sign in to sync your artwork across devices, or continue as a guest to create offline.',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.neutral400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      );
}
