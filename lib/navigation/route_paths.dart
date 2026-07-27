/// URL path constants for PixelCanvas navigation per Blueprint §7.1.
abstract final class RoutePaths {
  /// Splash screen path (initial location).
  static const String splash = '/';

  /// Onboarding flow path.
  static const String onboarding = '/onboarding';

  /// Authentication flow path.
  static const String auth = '/auth';

  /// Bottom Nav Tab 0: Home path.
  static const String home = '/home';

  /// Projects list path.
  static const String projects = '/projects';

  /// Bottom Nav Tab 1: Templates library path.
  static const String templates = '/templates';

  /// Bottom Nav Tab 2: Community gallery path.
  static const String community = '/community';

  /// Artwork detail path.
  static const String artworkDetail = '/community/artwork/:id';

  /// Bottom Nav Tab 3: User profile path.
  static const String profile = '/profile';

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
