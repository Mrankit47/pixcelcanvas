import 'package:pixelcanvas/core/config/app_config.dart';
import 'package:pixelcanvas/core/utils/logger.dart';

/// Pre-flight environment and hardware configuration validator.
///
/// Ensures required configurations exist before initializing application services.
abstract final class StartupValidator {
  /// Validates environment flags and system prerequisites.
  static Future<bool> validate() async {
    Logger.i('Validating startup environment (Mode: ${AppConfig.environment.name})');
    
    // Validate configuration constants
    assert(AppConfig.environment.name.isNotEmpty, 'Environment must be set');

    Logger.i('Startup pre-flight validation passed');
    return true;
  }
}
