import 'package:flutter/material.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_radius.dart';
import 'package:pixelcanvas/theme/app_shadows.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';

/// PixelCanvas branded modal bottom sheet container component per Blueprint §9.6 and §31.8.
///
/// **Purpose**: Draggable and scrollable bottom sheet container.
/// **Parameters**:
/// - [child]: Sheet body content.
/// - [title]: Optional header title string.
/// - [showDragHandle]: True to display top handle bar (default: true).
/// - [isScrollable]: True if content can scroll inside sheet.
///
/// **Usage Example**:
/// ```dart
/// PcBottomSheet.show(
///   context,
///   title: 'Export Options',
///   child: ExportOptionsWidget(),
/// )
/// ```
/// **Accessibility**: Accessible bottom sheet modal with drag handle semantics.
class PcBottomSheet extends StatelessWidget {
  /// Creates a [PcBottomSheet].
  const PcBottomSheet({
    required this.child,
    this.title,
    this.showDragHandle = true,
    this.isScrollable = false,
    super.key,
  });

  /// Sheet body content.
  final Widget child;

  /// Optional header title string.
  final String? title;

  /// True to display drag handle bar.
  final bool showDragHandle;

  /// True if sheet body is scrollable.
  final bool isScrollable;

  /// Static helper to display bottom sheet.
  static Future<T?> show<T>(
    BuildContext context, {
    required Widget child,
    String? title,
    bool showDragHandle = true,
    bool isScrollable = false,
  }) =>
      showModalBottomSheet<T>(
        context: context,
        isScrollControlled: isScrollable,
        backgroundColor: Colors.transparent,
        builder: (context) => PcBottomSheet(
          title: title,
          showDragHandle: showDragHandle,
          isScrollable: isScrollable,
          child: child,
        ),
      );

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadius.topLg,
          boxShadow: AppShadows.xl,
        ),
        padding: const EdgeInsets.only(
          top: AppSpacing.md,
          left: AppSpacing.base,
          right: AppSpacing.base,
          bottom: AppSpacing.xl,
        ),
        child: Column(
          mainAxisSize: isScrollable ? MainAxisSize.max : MainAxisSize.min,
          children: [
            if (showDragHandle) ...[
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.neutral200,
                    borderRadius: AppRadius.borderFull,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
            ],
            if (title != null) ...[
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: Text(
                  title!,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
            Flexible(
              child: child,
            ),
          ],
        ),
      );
}
