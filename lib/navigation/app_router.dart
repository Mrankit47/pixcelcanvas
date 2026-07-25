import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
        builder: (context, state) => const _PlaceholderScreen(title: 'Splash'),
      ),

      // ── 2. Onboarding Flow Route ──
      GoRoute(
        path: RoutePaths.onboarding,
        name: RouteNames.onboarding,
        builder: (context, state) =>
            const _PlaceholderScreen(title: 'Onboarding'),
      ),

      // ── 3. Authentication Screen Route ──
      GoRoute(
        path: RoutePaths.auth,
        name: RouteNames.auth,
        builder: (context, state) =>
            const _PlaceholderScreen(title: 'Authentication'),
      ),

      // ── 4. Stateful Shell Route (Bottom Navigation Shell §7.1) ──
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => _BottomNavShellPlaceholder(
          navigationShell: navigationShell,
        ),
        branches: <StatefulShellBranch>[
          // Tab 0: Home
          StatefulShellBranch(
            navigatorKey: RouteConstants.homeTabNavigatorKey,
            routes: [
              GoRoute(
                path: RoutePaths.home,
                name: RouteNames.home,
                builder: (context, state) =>
                    const _PlaceholderScreen(title: 'Home Screen'),
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
                builder: (context, state) =>
                    const _PlaceholderScreen(title: 'Templates Library'),
              ),
            ],
          ),

          // Tab 2: Community
          StatefulShellBranch(
            navigatorKey: RouteConstants.communityTabNavigatorKey,
            routes: [
              GoRoute(
                path: RoutePaths.community,
                name: RouteNames.community,
                builder: (context, state) =>
                    const _PlaceholderScreen(title: 'Community Gallery'),
              ),
            ],
          ),

          // Tab 3: Profile
          StatefulShellBranch(
            navigatorKey: RouteConstants.profileTabNavigatorKey,
            routes: [
              GoRoute(
                path: RoutePaths.profile,
                name: RouteNames.profile,
                builder: (context, state) =>
                    const _PlaceholderScreen(title: 'User Profile'),
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
          return _PlaceholderScreen(title: 'Pixel Canvas Editor (ID: $id)');
        },
      ),

      // ── 6. Projects List Route ──
      GoRoute(
        path: RoutePaths.projects,
        name: RouteNames.projects,
        builder: (context, state) =>
            const _PlaceholderScreen(title: 'Projects List'),
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

/// Placeholder bottom navigation shell widget for [StatefulShellRoute].
class _BottomNavShellPlaceholder extends StatelessWidget {
  const _BottomNavShellPlaceholder({required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: navigationShell,
        bottomNavigationBar: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: (index) {
            navigationShell.goBranch(
              index,
              initialLocation: index == navigationShell.currentIndex,
            );
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.grid_view_outlined),
              selectedIcon: Icon(Icons.grid_view_rounded),
              label: 'Templates',
            ),
            NavigationDestination(
              icon: Icon(Icons.explore_outlined),
              selectedIcon: Icon(Icons.explore_rounded),
              label: 'Community',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outlined),
              selectedIcon: Icon(Icons.person_rounded),
              label: 'Profile',
            ),
          ],
        ),
      );
}
