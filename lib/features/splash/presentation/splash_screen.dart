import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pixelcanvas/features/auth/presentation/controllers/auth_controller.dart';
import 'package:pixelcanvas/features/splash/presentation/widgets/splash_animation.dart';
import 'package:pixelcanvas/features/splash/presentation/widgets/splash_background.dart';
import 'package:pixelcanvas/features/splash/presentation/widgets/splash_footer.dart';
import 'package:pixelcanvas/features/splash/presentation/widgets/splash_logo.dart';
import 'package:pixelcanvas/navigation/route_paths.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';

/// Production-ready Splash Screen for PixelCanvas per Blueprint §5.1 & §6.3.
///
/// **Purpose**: Initial splash screen checking session state via [AuthController] before navigation.
/// **Consumed Providers**: [authControllerProvider]
/// **Reactive Behavior**: Checks auth state; if authenticated redirects to Home, otherwise Onboarding.
class SplashScreen extends ConsumerStatefulWidget {
  /// Creates a [SplashScreen].
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..forward();

    // Trigger auth state initialization and handle splash navigation
    Future.microtask(() async {
      bool isAuthed = false;
      try {
        await ref.read(authControllerProvider.notifier).loadCurrentUser();
        isAuthed = ref.read(authControllerProvider).isAuthenticated;
      } catch (_) {
        isAuthed = false;
      }

      // Ensure minimum splash animation delay (1.5s) for smooth UX
      await Future.delayed(const Duration(milliseconds: 1500));

      if (!mounted) return;

      if (isAuthed) {
        context.go(RoutePaths.home);
      } else {
        context.go(RoutePaths.onboarding);
      }
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SizedBox.expand(
          child: SplashBackground(
            animation: _animController,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Spacer(),
                    Center(
                      child: SplashAnimation(
                        controller: _animController,
                        child: const SplashLogo(),
                      ),
                    ),
                    const Spacer(),
                    const SplashFooter(),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
