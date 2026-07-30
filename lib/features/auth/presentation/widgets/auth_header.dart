import 'package:flutter/material.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_radius.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';
import 'package:pixelcanvas/theme/app_typography.dart';

/// Top header branding bar for the Authentication screen per Blueprint §5.1.
///
/// **Purpose**: Displays the PixelCanvas brand icon and title.
/// **Parameters**: None.
/// **Future Extension Notes**: Can include dark/light theme toggle button if requested.
class AuthHeader extends StatelessWidget {
  /// Creates an [AuthHeader].
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary500,
              borderRadius: AppRadius.borderSm,
            ),
            child: const Icon(
              Icons.grid_on_rounded,
              color: AppColors.neutral0,
              size: 24,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            'PixelCanvas',
            style: AppTypography.headlineMedium.copyWith(
              color: AppColors.neutral600,
            ),
          ),
        ],
      );
}
