import 'package:flutter/material.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_radius.dart';
import 'package:pixelcanvas/theme/app_shadows.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';

/// Floating zoom controls overlay widget per Blueprint §5.1.
///
/// **Purpose**: Floating pill bar providing Zoom In, Zoom Out, Reset 100%, and Fit Screen buttons.
/// **Parameters**:
/// - [onZoomIn]: Callback for Zoom In.
/// - [onZoomOut]: Callback for Zoom Out.
/// - [onZoomReset]: Callback for Reset 100%.
/// - [onFitScreen]: Callback for Fit Screen.
///
/// **Future Extension Notes**: Interacts with `CanvasViewportController` matrix transform in Phase 4.
class FloatingZoomControls extends StatelessWidget {
  /// Creates a [FloatingZoomControls].
  const FloatingZoomControls({
    this.onZoomIn,
    this.onZoomOut,
    this.onZoomReset,
    this.onFitScreen,
    super.key,
  });

  /// Zoom In callback.
  final VoidCallback? onZoomIn;

  /// Zoom Out callback.
  final VoidCallback? onZoomOut;

  /// Reset callback.
  final VoidCallback? onZoomReset;

  /// Fit Screen callback.
  final VoidCallback? onFitScreen;

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadius.borderFull,
          boxShadow: AppShadows.md,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xs,
          vertical: AppSpacing.xxs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.add_rounded, color: AppColors.neutral500, size: 20),
              onPressed: onZoomIn,
              tooltip: 'Zoom In (Ctrl+)',
            ),
            IconButton(
              icon: const Icon(Icons.remove_rounded, color: AppColors.neutral500, size: 20),
              onPressed: onZoomOut,
              tooltip: 'Zoom Out (Ctrl-)',
            ),
            IconButton(
              icon: const Icon(Icons.center_focus_strong_rounded, color: AppColors.neutral500, size: 20),
              onPressed: onZoomReset,
              tooltip: 'Reset 100% (Ctrl+0)',
            ),
            IconButton(
              icon: const Icon(Icons.fit_screen_rounded, color: AppColors.neutral500, size: 20),
              onPressed: onFitScreen,
              tooltip: 'Fit to Screen',
            ),
          ],
        ),
      );
}
