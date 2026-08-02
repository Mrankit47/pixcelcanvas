import 'package:flutter/material.dart';
import 'package:pixelcanvas/shared/widgets/pixel_background.dart';
import 'package:pixelcanvas/theme/app_colors.dart';

/// Animated background widget for the Splash screen per Version 1.0 Design System.
class SplashBackground extends StatelessWidget {
  /// Creates a [SplashBackground].
  const SplashBackground({
    required this.animation,
    required this.child,
    super.key,
  });

  /// Gradient animation controller value.
  final Animation<double> animation;

  /// Foreground splash screen content.
  final Widget child;

  @override
  Widget build(BuildContext context) => PixelBackground(
        backgroundColor: AppColors.background,
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, child) => FadeTransition(
            opacity: animation,
            child: child,
          ),
          child: child,
        ),
      );
}
