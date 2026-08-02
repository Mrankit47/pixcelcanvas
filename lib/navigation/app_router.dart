import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pixelcanvas/features/editor/presentation/editor_screen.dart';
import 'package:pixelcanvas/features/home/presentation/home_screen.dart';
import 'package:pixelcanvas/features/home/presentation/widgets/bottom_navigation_shell.dart';
import 'package:pixelcanvas/features/onboarding/presentation/onboarding_screen.dart';
import 'package:pixelcanvas/features/projects/presentation/projects_screen.dart';
import 'package:pixelcanvas/features/splash/presentation/splash_screen.dart';
import 'package:pixelcanvas/features/templates/presentation/templates_screen.dart';
import 'package:pixelcanvas/navigation/navigation_observer.dart';
import 'package:pixelcanvas/navigation/route_constants.dart';
import 'package:pixelcanvas/navigation/route_names.dart';
import 'package:pixelcanvas/navigation/route_paths.dart';

/// Centralized declarative [GoRouter] configuration for PixelCanvas per Blueprint §7.1 & §7.3.
///
/// Implements `StatefulShellRoute` for Bottom Navigation tabs with preserved state.
abstract final class AppRouter {
  /// Singleton [GoRouter] instance.
  static final GoRouter router = GoRouter(
    navigatorKey: RouteConstants.rootNavigatorKey,
    initialLocation: RoutePaths.splash,
    observers: [AppNavigationObserver()],
    routes: <RouteBase>[
      // ── 1. Splash Screen Route ──
      GoRoute(
        path: RoutePaths.splash,
        name: RouteNames.splash,
        builder: (context, state) => const SplashScreen(),
      ),

      // ── 2. Onboarding Flow Route ──
      GoRoute(
        path: RoutePaths.onboarding,
        name: RouteNames.onboarding,
        builder: (context, state) => OnboardingScreen(
          onOnboardingComplete: () => context.go(RoutePaths.home),
          onSkipComplete: () => context.go(RoutePaths.home),
        ),
      ),

      // ── 3. Stateful Shell Route (Bottom Navigation Shell §7.1) ──
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => BottomNavigationShell(
          currentIndex: navigationShell.currentIndex,
          onDestinationSelected: (index) {
            navigationShell.goBranch(
              index,
              initialLocation: index == navigationShell.currentIndex,
            );
          },
          child: navigationShell,
        ),
        branches: <StatefulShellBranch>[
          // Tab 0: Home
          StatefulShellBranch(
            navigatorKey: RouteConstants.homeTabNavigatorKey,
            routes: [
              GoRoute(
                path: RoutePaths.home,
                name: RouteNames.home,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),

          // Tab 1: Templates
          StatefulShellBranch(
            navigatorKey: RouteConstants.templatesTabNavigatorKey,
            routes: [
              GoRoute(
                path: RoutePaths.templates,
                name: RouteNames.templates,
                builder: (context, state) => const TemplatesScreen(),
              ),
            ],
          ),
        ],
      ),

      // ── 5. Full-Screen Canvas Editor Route ──
      GoRoute(
        path: RoutePaths.editor,
        name: RouteNames.editor,
        parentNavigatorKey: RouteConstants.rootNavigatorKey,
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? 'new';
          return EditorScreen(projectId: id);
        },
      ),

      // ── 6. Projects List Route ──
      GoRoute(
        path: RoutePaths.projects,
        name: RouteNames.projects,
        builder: (context, state) => const ProjectsScreen(),
      ),

      // ── 7. Notifications Center Route ──
      GoRoute(
        path: RoutePaths.notifications,
        name: RouteNames.notifications,
        builder: (context, state) =>
            const _PlaceholderScreen(title: 'Notification Center'),
      ),

      // ── 8. Settings Route ──
      GoRoute(
        path: RoutePaths.settings,
        name: RouteNames.settings,
        builder: (context, state) =>
            const _PlaceholderScreen(title: 'Settings'),
      ),

      // ── 9. Export Route ──
      GoRoute(
        path: RoutePaths.export,
        name: RouteNames.export,
        builder: (context, state) =>
            const _PlaceholderScreen(title: 'Export Options'),
      ),
    ],
  );
}

/// Placeholder screen widget for route registration.
class _PlaceholderScreen extends StatelessWidget {
  const _PlaceholderScreen({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      );
}
