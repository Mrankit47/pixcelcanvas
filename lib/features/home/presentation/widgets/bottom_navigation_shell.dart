import 'package:flutter/material.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_shadows.dart';
import 'package:pixelcanvas/theme/app_typography.dart';

/// Bottom navigation shell wrapper component per Blueprint §7.1 & §7.3.
///
/// **Purpose**: Material 3 NavigationBar for the 4 primary application tabs.
/// **Parameters**:
/// - [currentIndex]: Active tab index (0 = Home, 1 = Templates, 2 = Community, 3 = Profile).
/// - [onDestinationSelected]: Callback when tab is selected.
/// - [child]: Body content widget for current branch.
///
/// **Future Extension Notes**: Integrates with GoRouter `StatefulShellRoute` in `app_router.dart`.
class BottomNavigationShell extends StatelessWidget {
  /// Creates a [BottomNavigationShell].
  const BottomNavigationShell({
    required this.currentIndex,
    required this.onDestinationSelected,
    required this.child,
    super.key,
  });

  /// Current active tab index.
  final int currentIndex;

  /// Tab selection callback.
  final ValueChanged<int> onDestinationSelected;

  /// Body widget for active branch.
  final Widget child;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: child,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: AppShadows.sm,
          ),
          child: NavigationBar(
            height: 64,
            elevation: AppShadows.elevationSm,
            backgroundColor: AppColors.surface,
            indicatorColor: AppColors.primary100,
            selectedIndex: currentIndex,
            onDestinationSelected: onDestinationSelected,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined, color: AppColors.neutral300),
                selectedIcon: Icon(Icons.home_rounded, color: AppColors.primary500),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.grid_view_outlined, color: AppColors.neutral300),
                selectedIcon: Icon(Icons.grid_view_rounded, color: AppColors.primary500),
                label: 'Templates',
              ),
            ],
          ),
        ),
      );
}
