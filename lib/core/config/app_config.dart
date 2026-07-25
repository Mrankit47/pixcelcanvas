import 'package:pixelcanvas/core/config/environment.dart';

/// Singleton configuration container for PixelCanvas runtime settings.
///
/// Holds environment state, API keys, and feature flags per Blueprint §8.1.
abstract final class AppConfig {
  /// Current runtime environment.
  static const Environment environment = Environment.dev;

  /// True if running in development mode.
  static bool get isDev => environment == Environment.dev;

  /// True if running in production mode.
  static bool get isProd => environment == Environment.prod;
}
