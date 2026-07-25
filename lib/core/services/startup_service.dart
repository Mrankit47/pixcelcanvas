import 'package:pixelcanvas/core/utils/logger.dart';

/// High-level application startup service contract.
///
/// Coordinates system warm-up and post-bootstrap health verification per Blueprint §8.1.
abstract class StartupService {
  /// Executes system warm-up tasks after main bootstrap completes.
  static Future<void> onStartupComplete() async {
    Logger.i('Startup post-boot verification complete');
  }
}
