import 'package:flutter/material.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_radius.dart';
import 'package:pixelcanvas/theme/app_shadows.dart';

/// PixelCanvas branded logo mark widget for the Splash screen per Blueprint §5.1.
///
/// **Purpose**: Displays the pixel-art styled brand logo icon with subtle container elevation.
/// **Parameters**:
/// - [size]: Width and height dimension (default: 96dp).
///
/// **Future Extension Notes**: Can load vector SVG or Lottie brand animation in future iterations.
class SplashLogo extends StatelessWidget {
  /// Creates a [SplashLogo].
  const SplashLogo({
    this.size = 96.0,
    super.key,
  });

  /// Logo container size.
  final double size;

  @override
  Widget build(BuildContext context) => Semantics(
        label: 'PixelCanvas Brand Logo',
        image: true,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: AppColors.primary500,
            borderRadius: AppRadius.borderLg,
            boxShadow: AppShadows.lg,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Grid pattern graphic representation inside logo
              Icon(
                Icons.grid_on_rounded,
                size: size * 0.55,
                color: AppColors.neutral0,
              ),
              // Secondary color accent badge
              Positioned(
                right: size * 0.15,
                bottom: size * 0.15,
                child: Container(
                  width: size * 0.22,
                  height: size * 0.22,
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
