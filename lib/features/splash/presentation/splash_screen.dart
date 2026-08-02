import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pixelcanvas/features/splash/presentation/widgets/splash_animation.dart';
import 'package:pixelcanvas/features/splash/presentation/widgets/splash_background.dart';
import 'package:pixelcanvas/features/splash/presentation/widgets/splash_footer.dart';
import 'package:pixelcanvas/features/splash/presentation/widgets/splash_logo.dart';
import 'package:pixelcanvas/navigation/route_paths.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';

/// Production-ready Splash Screen for PixelCanvas per Blueprint §5.1 & §6.3.
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

    Future.microtask(() async {
      await Future.delayed(const Duration(milliseconds: 1500));
      if (!mounted) return;
      context.go(RoutePaths.home);
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
