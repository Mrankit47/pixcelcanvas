import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pixelcanvas/features/auth/presentation/controllers/auth_controller.dart';
import 'package:pixelcanvas/features/auth/presentation/widgets/auth_header.dart';
import 'package:pixelcanvas/features/auth/presentation/widgets/guest_mode_card.dart';
import 'package:pixelcanvas/features/auth/presentation/widgets/sign_in_card.dart';
import 'package:pixelcanvas/features/auth/presentation/widgets/terms_section.dart';
import 'package:pixelcanvas/features/auth/presentation/widgets/welcome_section.dart';
import 'package:pixelcanvas/navigation/route_paths.dart';
import 'package:pixelcanvas/shared/widgets/pc_loading.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';

/// Production-ready Auth Screen for PixelCanvas per Blueprint §5.1 & §6.3.
///
/// **Purpose**: Authentication screen supporting email sign-in, OAuth, and guest mode.
/// **Consumed Providers**: [authControllerProvider]
/// **Reactive Behavior**: Shows loading indicator when authenticating and navigates to Home on success.
class AuthScreen extends ConsumerWidget {
  /// Creates an [AuthScreen].
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AuthHeader(),
                  const SizedBox(height: AppSpacing.xl),
                  const WelcomeSection(),
                  const SizedBox(height: AppSpacing.xl),
                  if (authState.isLoading)
                    const PcLoadingOverlay(message: 'Authenticating...')
                  else ...[
                    SignInCard(
                      onSignIn: (email, password) async {
                        await ref.read(authControllerProvider.notifier).signInAsGuest();
                        if (context.mounted) context.go(RoutePaths.home);
                      },
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    GuestModeCard(
                      onContinueAsGuest: () async {
                        await ref.read(authControllerProvider.notifier).signInAsGuest();
                        if (context.mounted) context.go(RoutePaths.home);
                      },
                    ),
                  ],
                  const SizedBox(height: AppSpacing.xl),
                  const TermsSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
