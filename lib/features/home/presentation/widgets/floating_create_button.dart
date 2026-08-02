import 'package:flutter/material.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_shadows.dart';

/// Floating Action Button for initiating project creation per Blueprint §5.1 & Version 1.0 Design System.
class FloatingCreateButton extends StatelessWidget {
  /// Creates a [FloatingCreateButton].
  const FloatingCreateButton({
    required this.onPressed,
    super.key,
  });

  /// Tap callback.
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [AppColors.primary700, AppColors.primary500],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: AppShadows.pixelGlow,
          border: Border.all(
            color: AppColors.accentCyan.withValues(alpha: 0.6),
            width: 1.5,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: onPressed,
            child: const Center(
              child: Icon(
                Icons.add_rounded,
                size: 28,
                color: AppColors.canvas,
              ),
            ),
          ),
        ),
      );
}
