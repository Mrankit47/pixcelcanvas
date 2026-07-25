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
            Text(
              version,
              style: AppTypography.labelSmall.copyWith(
                color: AppColors.neutral400,
              ),
            ),
            const SizedBox(height: AppSpacing.xxs),
            Text(
              'PixelCanvas • Light Edition',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.neutral300,
              ),
            ),
          ],
        ),
      );
}
