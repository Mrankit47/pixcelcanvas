import 'package:flutter/material.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';
import 'package:pixelcanvas/theme/app_typography.dart';

/// Terms of Service and Privacy Policy footer section per Blueprint §5.1.
///
/// **Purpose**: Displays legal terms links at the bottom of the auth screen.
/// **Parameters**:
/// - [onTermsOfService]: Callback when Terms of Service link is tapped.
/// - [onPrivacyPolicy]: Callback when Privacy Policy link is tapped.
///
/// **Future Extension Notes**: Opens webview or browser with legal policy URLs.
class TermsSection extends StatelessWidget {
  /// Creates a [TermsSection].
  const TermsSection({
    required this.onTermsOfService,
    required this.onPrivacyPolicy,
    super.key,
  });

  /// Terms of service callback.
  final VoidCallback onTermsOfService;

  /// Privacy policy callback.
  final VoidCallback onPrivacyPolicy;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'By signing in, you agree to our ',
              style: AppTypography.labelSmall.copyWith(
                color: AppColors.neutral400,
              ),
            ),
            GestureDetector(
              onTap: onTermsOfService,
              child: Text(
                'Terms',
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.primary500,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            Text(
              ' & ',
              style: AppTypography.labelSmall.copyWith(
                color: AppColors.neutral400,
              ),
            ),
            GestureDetector(
              onTap: onPrivacyPolicy,
              child: Text(
                'Privacy Policy',
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.primary500,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      );
}
