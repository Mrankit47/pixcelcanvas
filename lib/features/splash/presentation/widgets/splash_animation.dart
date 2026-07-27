import 'package:flutter/material.dart';
import 'package:pixelcanvas/theme/app_durations.dart';

/// Animation wrapper orchestrating logo scaling, floating effect, and text fade sequence.
///
/// **Purpose**: Provides smooth 60 FPS scale, fade, and floating/breathing curves for splash content.
/// **Parameters**:
/// - [controller]: Master animation controller driving sequence timing.
/// - [child]: Child widget wrapped by animation transforms.
///
/// **Future Extension Notes**: Can add particle effects for celebration events.
class SplashAnimation extends StatelessWidget {
  /// Creates a [SplashAnimation].
  const SplashAnimation({
    required this.controller,
    required this.child,
    super.key,
  });

  /// Master animation controller.
  final AnimationController controller;

  /// Child widget.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scaleAnimation = CurvedAnimation(
      parent: controller,
      curve: Interval(0.0, 0.6, curve: AppCurves.emphasize),
    );

    final fadeAnimation = CurvedAnimation(
      parent: controller,
      curve: Interval(0.2, 0.8, curve: AppCurves.enter),
    );

    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) => FadeTransition(
        opacity: fadeAnimation,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: child,
        ),
      ),
    );
  }
}
