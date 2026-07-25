import 'package:flutter/material.dart';
import 'package:pixelcanvas/shared/widgets/pc_button.dart';
import 'package:pixelcanvas/shared/widgets/pc_card.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';
import 'package:pixelcanvas/theme/app_typography.dart';

/// Guest Mode option card component per Blueprint §5.1 & §6.2.
///
/// **Purpose**: Explains Guest Mode capabilities and provides instant access without account creation.
/// **Parameters**:
/// - [onGuestMode]: Callback when Continue as Guest button is tapped.
/// - [isLoading]: True if process is loading.
///
/// **Future Extension Notes**: Tapping Guest Mode populates guest user state in Riverpod AuthNotifier in Phase 3.
class GuestModeCard extends StatelessWidget {
  /// Creates a [GuestModeCard].
  const GuestModeCard({
    required this.onGuestMode,
    this.isLoading = false,
    super.key,
  });

  /// Guest mode callback.
  final VoidCallback onGuestMode;

  /// Loading state flag.
  final bool isLoading;

  @override
  Widget build(BuildContext context) => PcCard(
        variant: PcCardVariant.filled,
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: const BoxDecoration(
                    color: AppColors.primary100,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.offline_bolt_outlined,
                    color: AppColors.primary500,
                    size: 20,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Guest Mode',
                        style: AppTypography.titleSmall.copyWith(
                          color: AppColors.neutral600,
                        ),
                      ),
                      Text(
                        'Create & edit pixel art offline. No account required.',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.neutral400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            PcButton(
              label: 'Continue as Guest',
              variant: PcButtonVariant.secondary,
              fullWidth: true,
              trailingIcon: Icons.arrow_forward_rounded,
              onPressed: isLoading ? null : onGuestMode,
            ),
          ],
        ),
      );
}
