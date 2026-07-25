import 'package:flutter/material.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_durations.dart';
import 'package:pixelcanvas/theme/app_radius.dart';
import 'package:pixelcanvas/theme/app_shadows.dart';

/// Variant style for [PcCard].
enum PcCardVariant {
  /// Surface card with elevation shadow.
  elevated,

  /// Flat card with border outline.
  outlined,

  /// Filled background card.
  filled,
}

/// PixelCanvas branded card container component per Blueprint §9.6 and §31.8.
///
/// **Purpose**: Container for project items, templates, and gallery cards.
/// **Parameters**:
/// - [child]: Card content widget.
/// - [variant]: Visual card variant (default: [PcCardVariant.elevated]).
/// - [padding]: Inner padding (default: 16dp base padding).
/// - [onTap]: Optional tap callback enabling hover/press states.
/// - [margin]: Outer margin around card.
///
/// **Usage Example**:
/// ```dart
/// PcCard(
///   variant: PcCardVariant.elevated,
///   onTap: () => print('Card tapped'),
///   child: Text('Card Content'),
/// )
/// ```
/// **Accessibility**: Includes semantic container and tap target semantics.
class PcCard extends StatelessWidget {
  /// Creates a [PcCard].
  const PcCard({
    required this.child,
    this.variant = PcCardVariant.elevated,
    this.padding = const EdgeInsets.all(16),
    this.onTap,
    this.margin,
    super.key,
  });

  /// Card body content.
  final Widget child;

  /// Visual variant.
  final PcCardVariant variant;

  /// Inner padding.
  final EdgeInsetsGeometry padding;

  /// Optional tap callback.
  final VoidCallback? onTap;

  /// Outer margin.
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = switch (variant) {
      PcCardVariant.elevated => AppColors.surface,
      PcCardVariant.outlined => AppColors.surface,
      PcCardVariant.filled => AppColors.neutral50,
    };

    final boxShadow = switch (variant) {
      PcCardVariant.elevated => AppShadows.sm,
      PcCardVariant.outlined => AppShadows.none,
      PcCardVariant.filled => AppShadows.none,
    };

    final border = switch (variant) {
      PcCardVariant.elevated =>
        Border.all(color: AppColors.neutral200, width: 0.5),
      PcCardVariant.outlined => Border.all(color: AppColors.neutral200),
      PcCardVariant.filled => null,
    };

    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: AppRadius.borderMd,
        border: border,
        boxShadow: boxShadow,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: AppRadius.borderMd,
        child: InkWell(
          borderRadius: AppRadius.borderMd,
          onTap: onTap,
          splashColor: AppColors.primary100,
          highlightColor: AppColors.primary50,
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}
