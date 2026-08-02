import 'package:flutter/material.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';
import 'package:pixelcanvas/theme/app_typography.dart';

/// Footer metadata container for the Splash screen per Blueprint §5.1.
///
/// **Purpose**: Displays application version string and copyright note at the bottom of the screen.
/// **Parameters**:
/// - [version]: Version string (default: "v1.0.0 (1)").
///
/// **Future Extension Notes**: Version string will be injected from `packageInfoProvider` in Phase 2.
class SplashFooter extends StatelessWidget {
  /// Creates a [SplashFooter].
  const SplashFooter({
    this.version = 'v1.0.0 (1)',
    super.key,
  });

  /// Version string.
  final String version;

  @override
  Widget build(BuildContext context) => Semantics(
        label: 'Application version $version',
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Pixel Blocks Assembling Progress Indicator
            SizedBox(
              width: 140,
              height: 4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: const LinearProgressIndicator(
                  backgroundColor: AppColors.surface,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary500),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            Text(
              version,
              style: AppTypography.labelSmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.xxs),
            Text(
              'PixelCanvas Studio • Version 1.0',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.neutral400,
              ),
            ),
          ],
        ),
      );
}
