import 'package:flutter/material.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_radius.dart';
import 'package:pixelcanvas/theme/app_shadows.dart';

/// Button Variant Types per Version 1.0 Design System.
enum PixelButtonVariant {
  /// Primary Gradient (Deep Cosmic Purple -> Electric Violet) with pixel highlight edge.
  primary,

  /// Secondary Glass style with pixel border.
  secondary,

  /// Minimal Ghost button.
  ghost,
}

/// Premium Pixel Button component per Version 1.0 Design System.
class PixelButton extends StatefulWidget {
  /// Creates a [PixelButton].
  const PixelButton({
    required this.label,
    required this.onPressed,
    this.icon,
    this.variant = PixelButtonVariant.primary,
    this.isLoading = false,
    super.key,
  });

  /// Button text label.
  final String label;

  /// Icon widget.
  final Widget? icon;

  /// Tap handler callback.
  final VoidCallback? onPressed;

  /// Style variant.
  final PixelButtonVariant variant;

  /// Loading spinner state.
  final bool isLoading;

  @override
  State<PixelButton> createState() => _PixelButtonState();
}

class _PixelButtonState extends State<PixelButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final bool isPrimary = widget.variant == PixelButtonVariant.primary;
    final bool isSecondary = widget.variant == PixelButtonVariant.secondary;

    // Gradient background for primary button
    final Gradient? gradient = isPrimary
        ? const LinearGradient(
            colors: [AppColors.primary700, AppColors.primary500],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        : null;

    final Color bgColor = isSecondary
        ? AppColors.surface
        : (isPrimary ? Colors.transparent : Colors.transparent);

    final Color textColor = isPrimary
        ? AppColors.canvas
        : AppColors.textPrimary;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedScale(
          scale: _isPressed ? 0.96 : (_isHovered ? 1.02 : 1.0),
          duration: const Duration(milliseconds: 150),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              gradient: gradient,
              color: bgColor,
              borderRadius: AppRadius.borderMd,
              border: Border.all(
                color: isSecondary
                    ? (_isHovered ? AppColors.primary500 : AppColors.border)
                    : (isPrimary ? AppColors.primary300.withValues(alpha: 0.5) : Colors.transparent),
                width: 1.0,
              ),
              boxShadow: isPrimary && _isHovered
                  ? AppShadows.pixelGlow
                  : (isPrimary ? AppShadows.sm : AppShadows.none),
            ),
            child: Material(
              color: Colors.transparent,
              borderRadius: AppRadius.borderMd,
              child: InkWell(
                borderRadius: AppRadius.borderMd,
                onTap: widget.isLoading ? null : widget.onPressed,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.isLoading)
                        const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.canvas,
                          ),
                        )
                      else if (widget.icon != null) ...[
                        widget.icon!,
                        const SizedBox(width: 8),
                      ],
                      Text(
                        widget.label,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: textColor,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
