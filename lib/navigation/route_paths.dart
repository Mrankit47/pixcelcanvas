/// URL path constants for PixelCanvas navigation per Blueprint §7.1.
abstract final class RoutePaths {
  /// Splash screen path (initial location).
  static const String splash = '/';

  /// Onboarding flow path.
  static const String onboarding = '/onboarding';

  /// Bottom Nav Tab 0: Home path.
  static const String home = '/home';

  /// Projects list path.
  static const String projects = '/projects';

  /// Bottom Nav Tab 1: Templates library path.
  static const String templates = '/templates';

  /// Canvas editor path.
  static const String editor = '/editor/:id';

  /// Helper generating editor path for a specific project ID.
  static String editorPath(String id) => '/editor/$id';

  /// Notifications center path.
  static const String notifications = '/notifications';

  /// Application settings path.
  static const String settings = '/settings';

  /// Export options bottom sheet / path.
  static const String export = '/export';
}
