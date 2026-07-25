import 'package:flutter/material.dart';

/// Navigation constants, GlobalKey references, and shell keys per Blueprint §7.1.
abstract final class RouteConstants {
  /// Root navigator key for full-screen routes (Splash, Auth, Editor).
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');

  /// Shell navigator key for Bottom Navigation tabs.
  static final GlobalKey<NavigatorState> shellNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'shell');

  /// Home tab navigator key.
  static final GlobalKey<NavigatorState> homeTabNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'homeTab');

  /// Templates tab navigator key.
  static final GlobalKey<NavigatorState> templatesTabNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'templatesTab');

  /// Community tab navigator key.
  static final GlobalKey<NavigatorState> communityTabNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'communityTab');

  /// Profile tab navigator key.
  static final GlobalKey<NavigatorState> profileTabNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'profileTab');
}
