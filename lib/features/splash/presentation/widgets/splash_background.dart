import 'package:flutter/material.dart';
import 'package:pixelcanvas/theme/app_colors.dart';

/// Animated background widget for the Splash screen per Blueprint §5.1 and §26.5.
///
/// **Purpose**: Renders a subtle animated gradient background matching the light theme palette.
/// **Parameters**:
/// - [animation]: Animation emitting gradient alignment interpolation values.
/// - [child]: Foreground content widget.
///
/// **Future Extension Notes**: Can incorporate subtle pixel grid background patterns in V2.
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
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: animation,
        builder: (context, _) {
          final value = animation.value;
          return SizedBox.expand(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(-1.0 + value * 0.5, -1.0),
                  end: Alignment(1.0 - value * 0.5, 1.0),
                  colors: [
                    AppColors.surface,
                    AppColors.background,
                    AppColors.primary50,
                  ],
                ),
              ),
              child: child,
            ),
          );
        },
      );
}
