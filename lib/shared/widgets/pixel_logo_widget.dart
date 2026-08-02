import 'package:flutter/material.dart';
import 'package:pixelcanvas/theme/app_colors.dart';

/// Reusable PixelCanvas Brand Logo Widget per Version 1.0 Design System.
class PixelLogoWidget extends StatelessWidget {
  /// Creates a [PixelLogoWidget].
  const PixelLogoWidget({
    this.size = 110.0,
    this.showTagline = true,
    super.key,
  });

  /// Size of the logo icon.
  final double size;

  /// Whether to display tagline below brand name.
  final bool showTagline;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // User Uploaded Square App Icon Logo Mark
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size * 0.22),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary500.withValues(alpha: 0.35),
                  blurRadius: size * 0.25,
                  offset: Offset(0, size * 0.1),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(size * 0.22),
              child: Image.asset(
                'assets/images/logo.png',
                width: size,
                height: size,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Icon(
                  Icons.palette_rounded,
                  size: size * 0.6,
                  color: AppColors.primary500,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Brand Typography "Pixel Canvas"
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'Pixel ',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                    letterSpacing: -0.5,
                  ),
                ),
                TextSpan(
                  text: 'Canvas',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary500,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ),

          if (showTagline) ...[
            const SizedBox(height: 4),
            const Text(
              'Create Pixels. Build Worlds.',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ],
      );
}

class _MiniCanvasPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.15)
      ..strokeWidth = 1.0;

    const step = 8.0;
    for (double x = step; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = step; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
