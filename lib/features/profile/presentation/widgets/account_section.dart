import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/profile/presentation/widgets/settings_tile.dart';
import 'package:pixelcanvas/shared/widgets/pc_card.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_radius.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';
import 'package:pixelcanvas/theme/app_typography.dart';

/// Account management settings section per Blueprint §5.1 & §6.2.
///
/// **Purpose**: Displays user email, subscription status, connected OAuth accounts, and Manage Account trigger.
/// **Parameters**:
/// - [email]: Email string (default: "artist@pixelcanvas.app").
/// - [subscriptionPlan]: Plan string (default: "Pro Pixel Creator").
/// - [onManageAccount]: Callback when Manage Account is tapped.
///
/// **Future Extension Notes**: Binds to `SupabaseClient.auth.currentUser` in Phase 3.
class AccountSection extends StatelessWidget {
  /// Creates an [AccountSection].
  const AccountSection({
    this.email = 'artist@pixelcanvas.app',
    this.subscriptionPlan = 'Pro Pixel Creator',
    this.onManageAccount,
    super.key,
  });

  /// User email.
  final String email;

  /// Subscription tier.
  final String subscriptionPlan;

  /// Manage account callback.
  final VoidCallback? onManageAccount;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Account & Security',
            style: AppTypography.titleMedium.copyWith(
              color: AppColors.neutral600,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          PcCard(
            variant: PcCardVariant.elevated,
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                SettingsTile(
                  icon: Icons.email_outlined,
                  title: 'Email Address',
                  subtitle: email,
                  trailing: Text(
                    'Verified',
                    style: AppTypography.labelSmall.copyWith(color: AppColors.successMain),
                  ),
                ),
                const Divider(height: 1),
                SettingsTile(
                  icon: Icons.workspace_premium_outlined,
                  title: 'Subscription Tier',
                  subtitle: subscriptionPlan,
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.primary100,
                      borderRadius: AppRadius.borderFull,
                    ),
                    child: Text(
                      'PRO',
                      style: AppTypography.labelSmall.copyWith(color: AppColors.primary500),
                    ),
                  ),
                ),
                const Divider(height: 1),
                SettingsTile(
                  icon: Icons.link_rounded,
                  title: 'Connected OAuth Accounts',
                  subtitle: 'Google, GitHub Linked',
                  onTap: onManageAccount,
                ),
              ],
            ),
          ),
        ],
      );
}
