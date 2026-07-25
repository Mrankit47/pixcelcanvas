import 'package:flutter/material.dart';
import 'package:pixelcanvas/shared/widgets/pc_button.dart';
import 'package:pixelcanvas/shared/widgets/pc_card.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';
import 'package:pixelcanvas/theme/app_typography.dart';

/// Danger zone destructive action section for Profile per Blueprint §5.1 & §6.2.
///
/// **Purpose**: Contains Sign Out and Delete Account destructive CTAs.
/// **Parameters**:
/// - [onSignOut]: Callback when Sign Out button is tapped.
/// - [onDeleteAccount]: Callback when Delete Account button is tapped.
///
/// **Future Extension Notes**: Triggers authentication sign out or account deletion modal in Phase 3.
class DangerZoneSection extends StatelessWidget {
  /// Creates a [DangerZoneSection].
  const DangerZoneSection({
    this.onSignOut,
    this.onDeleteAccount,
    super.key,
  });

  /// Sign Out callback.
  final VoidCallback? onSignOut;

  /// Delete Account callback.
  final VoidCallback? onDeleteAccount;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Session & Account Control',
            style: AppTypography.titleMedium.copyWith(
              color: AppColors.dangerMain,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          PcCard(
            variant: PcCardVariant.outlined,
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              children: [
                PcButton(
                  label: 'Sign Out of Account',
                  variant: PcButtonVariant.outlined,
                  leadingIcon: Icons.logout_rounded,
                  fullWidth: true,
                  onPressed: onSignOut,
                ),
                const SizedBox(height: AppSpacing.sm),
                PcButton(
                  label: 'Delete Account & Data',
                  variant: PcButtonVariant.danger,
                  leadingIcon: Icons.delete_forever_rounded,
                  fullWidth: true,
                  onPressed: onDeleteAccount,
                ),
              ],
            ),
          ),
        ],
      );
}
