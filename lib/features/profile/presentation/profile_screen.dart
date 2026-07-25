import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pixelcanvas/features/auth/presentation/controllers/auth_controller.dart';
import 'package:pixelcanvas/features/profile/presentation/controllers/profile_controller.dart';
import 'package:pixelcanvas/features/profile/presentation/widgets/about_section.dart';
import 'package:pixelcanvas/features/profile/presentation/widgets/account_section.dart';
import 'package:pixelcanvas/features/profile/presentation/widgets/achievements_section.dart';
import 'package:pixelcanvas/features/profile/presentation/widgets/danger_zone_section.dart';
import 'package:pixelcanvas/features/profile/presentation/widgets/preferences_section.dart';
import 'package:pixelcanvas/features/profile/presentation/widgets/profile_header.dart';
import 'package:pixelcanvas/features/profile/presentation/widgets/profile_stats_card.dart';
import 'package:pixelcanvas/features/profile/presentation/widgets/recent_activity_section.dart';
import 'package:pixelcanvas/features/profile/presentation/widgets/settings_section.dart';
import 'package:pixelcanvas/navigation/route_paths.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';

/// Production-ready User Profile and Settings Screen for PixelCanvas per Blueprint §5.1 & §6.3.
///
/// **Purpose**: Profile and system settings workspace reacting to [AuthController] and [ProfileController].
/// **Consumed Providers**: [authControllerProvider], [profileControllerProvider]
class ProfileScreen extends ConsumerStatefulWidget {
  /// Creates a [ProfileScreen].
  const ProfileScreen({
    this.onEditProfile,
    this.onManageAccount,
    this.onSignOut,
    this.onDeleteAccount,
    super.key,
  });

  /// Callbacks.
  final VoidCallback? onEditProfile;
  final VoidCallback? onManageAccount;
  final VoidCallback? onSignOut;
  final VoidCallback? onDeleteAccount;

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(profileControllerProvider.notifier).loadProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.base,
            vertical: AppSpacing.md,
          ),
          children: [
            ProfileHeader(
              displayName: authState.user?.displayName.value ?? 'Alex Rivers',
              username: authState.user?.username.value ?? '@pixelmaster',
              avatarUrl: authState.user?.avatarUrl,
              onEditProfile: widget.onEditProfile,
            ),
            const SizedBox(height: AppSpacing.xl),

            const ProfileStatsCard(),
            const SizedBox(height: AppSpacing.xl),

            const AchievementsSection(),
            const SizedBox(height: AppSpacing.xl),

            const RecentActivitySection(),
            const SizedBox(height: AppSpacing.xl),

            const PreferencesSection(),
            const SizedBox(height: AppSpacing.xl),

            AccountSection(
              email: authState.user?.email.value ?? 'artist@pixelcanvas.app',
              onManageAccount: widget.onManageAccount,
            ),
            const SizedBox(height: AppSpacing.xl),

            const SettingsSection(),
            const SizedBox(height: AppSpacing.xl),

            const AboutSection(),
            const SizedBox(height: AppSpacing.xl),

            DangerZoneSection(
              onSignOut: () async {
                await ref.read(authControllerProvider.notifier).signOut();
                if (context.mounted) context.go(RoutePaths.auth);
              },
              onDeleteAccount: widget.onDeleteAccount,
            ),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}
