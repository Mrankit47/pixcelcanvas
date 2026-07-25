import 'package:flutter/material.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_radius.dart';

/// Loading indicator variant for [PcLoading].
enum PcLoadingVariant {
  /// Circular spinner loader.
  circular,

  /// Linear progress bar loader.
  linear,

  /// Skeleton box loader.
  skeleton,
}

/// PixelCanvas branded loading indicator component per Blueprint §9.6 and §31.8.
///
/// **Purpose**: Feedback indicator during async operations and page loading.
/// **Parameters**:
/// - [variant]: Type variant (default: [PcLoadingVariant.circular]).
/// - [size]: Size for circular loader or height for skeleton loader.
/// - [width]: Width for skeleton loader.
/// - [color]: Custom color override.
///
/// **Usage Example**:
/// ```dart
/// PcLoading(variant: PcLoadingVariant.circular)
/// PcLoading(variant: PcLoadingVariant.skeleton, width: 200, size: 24)
/// ```
class PcLoading extends StatelessWidget {
  /// Creates a [PcLoading].
  const PcLoading({
    this.variant = PcLoadingVariant.circular,
    this.size = 36.0,
    this.width,
    this.color,
    super.key,
  });

  /// Variant type.
  final PcLoadingVariant variant;

  /// Diameter for circular or height for skeleton loader.
  final double size;

  /// Width for skeleton loader.
  final double? width;

  /// Color override.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final activeColor = color ?? AppColors.primary500;

    return switch (variant) {
      PcLoadingVariant.circular => Center(
          child: SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(activeColor),
            ),
          ),
        ),
      PcLoadingVariant.linear => LinearProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(activeColor),
          backgroundColor: AppColors.primary100,
        ),
      PcLoadingVariant.skeleton => Container(
          width: width,
          height: size,
          decoration: const BoxDecoration(
            color: AppColors.neutral100,
            borderRadius: AppRadius.borderSm,
          ),
        ),
    };
  }
}
