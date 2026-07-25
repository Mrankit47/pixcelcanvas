import 'package:flutter/material.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_shadows.dart';

/// Floating Action Button for initiating project creation per Blueprint §5.1 & §7.1.
///
/// **Purpose**: Primary floating trigger to open New Project modal or canvas editor.
/// **Parameters**:
/// - [onPressed]: Callback when FAB is tapped.
///
/// **Future Extension Notes**: Triggers New Project dialog or directly opens empty editor.
class FloatingCreateButton extends StatelessWidget {
  /// Creates a [FloatingCreateButton].
  const FloatingCreateButton({
    required this.onPressed,
    super.key,
  });

  /// Tap callback.
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => FloatingActionButton.extended(
        elevation: AppShadows.elevationMd,
        backgroundColor: AppColors.primary500,
        foregroundColor: AppColors.neutral0,
        onPressed: onPressed,
        icon: const Icon(Icons.add_rounded, size: 24),
        label: const Text('Create'),
      );
}
