import 'package:flutter/material.dart';
import 'package:pixelcanvas/theme/app_colors.dart';

/// Micro-pixel background decorator per Version 1.0 Design System.
///
/// **Design Goal**: Subtle micro-pixel texture background (Soft Pearl White with micro-pixel grid dots).
class PixelBackground extends StatelessWidget {
  /// Creates a [PixelBackground].
  const PixelBackground({
    required this.child,
    this.backgroundColor = AppColors.background,
    super.key,
  });

  /// Background color.
  final Color backgroundColor;

  /// Body widget.
  final Widget child;

  @override
  Widget build(BuildContext context) => CustomPaint(
        painter: _PixelGridPainter(
          gridColor: AppColors.primary500.withValues(alpha: 0.04),
          dotColor: AppColors.primary500.withValues(alpha: 0.08),
        ),
        child: Container(
          color: backgroundColor == AppColors.background
              ? Colors.transparent
              : backgroundColor,
          child: child,
        ),
      );
}

class _PixelGridPainter extends CustomPainter {
  _PixelGridPainter({
    required this.gridColor,
    required this.dotColor,
  });

  final Color gridColor;
  final Color dotColor;

  @override
  void paint(Canvas canvas, Size size) {
    final dotPaint = Paint()..color = dotColor;
    const spacing = 24.0;
    const pixelSize = 2.0;

    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        // Draw tiny micro-pixel square dots
        canvas.drawRect(
          Rect.fromLTWH(x, y, pixelSize, pixelSize),
          dotPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _PixelGridPainter oldDelegate) => false;
}
