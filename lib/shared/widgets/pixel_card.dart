import 'package:flutter/material.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_radius.dart';
import 'package:pixelcanvas/theme/app_shadows.dart';

/// Premium Pixel Card component per Version 1.0 Design System.
///
/// Features rounded corners, soft elevation, pixel edge highlights, and hover lift.
class PixelCard extends StatefulWidget {
  /// Creates a [PixelCard].
  const PixelCard({
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(16),
    this.backgroundColor = AppColors.surface,
    this.borderColor = AppColors.border,
    this.showPixelCorner = true,
    super.key,
  });

  /// Card body content.
  final Widget child;

  /// Optional tap handler.
  final VoidCallback? onTap;

  /// Padding inside card.
  final EdgeInsetsGeometry padding;

  /// Background fill color.
  final Color backgroundColor;

  /// Outline border color.
  final Color borderColor;

  /// Whether to render micro-pixel corner accents.
  final bool showPixelCorner;

  @override
  State<PixelCard> createState() => _PixelCardState();
}

class _PixelCardState extends State<PixelCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) => MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          transform: Matrix4.translationValues(0, _isHovered ? -3 : 0, 0),
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: AppRadius.borderLg,
            border: Border.all(
              color: _isHovered ? AppColors.primary500 : widget.borderColor,
              width: _isHovered ? 1.5 : 1.0,
            ),
            boxShadow: _isHovered ? AppShadows.pixelGlow : AppShadows.pixelCardShadow,
          ),
          child: Stack(
            children: [
              // Body
              Material(
                color: Colors.transparent,
                borderRadius: AppRadius.borderLg,
                child: InkWell(
                  borderRadius: AppRadius.borderLg,
                  onTap: widget.onTap,
                  child: Padding(
                    padding: widget.padding,
                    child: widget.child,
                  ),
                ),
              ),

              // Micro Pixel Corner Decoration
              if (widget.showPixelCorner)
                Positioned(
                  top: 6,
                  right: 6,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 3,
                        height: 3,
                        color: _isHovered ? AppColors.accentCyan : AppColors.primary300,
                      ),
                      const SizedBox(width: 2),
                      Container(
                        width: 3,
                        height: 3,
                        color: _isHovered ? AppColors.primary500 : AppColors.primary200,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      );
}
