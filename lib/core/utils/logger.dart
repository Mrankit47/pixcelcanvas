import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart' as log_pkg;

/// Centralized structured logger for PixelCanvas per Blueprint §35.1.
///
/// Wraps `package:logger` providing pretty logging in debug mode
/// and simple/clean logging in release mode.
abstract final class Logger {
  static final log_pkg.Logger _internalLogger = log_pkg.Logger(
    printer: kDebugMode
        ? log_pkg.PrettyPrinter(
            methodCount: 1,
            errorMethodCount: 5,
            lineLength: 80,
            colors: true,
            printEmojis: true,
          )
        : log_pkg.SimplePrinter(colors: false),
  );

  /// Logs a debug message (`PC-LOG-DEBUG`).
  static void d(String message, [Object? error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      _internalLogger.d(message, error: error, stackTrace: stackTrace);
    }
  }

  /// Logs an informational milestone message (`PC-LOG-INFO`).
  static void i(String message) {
    _internalLogger.i(message);
  }

  /// Logs a warning message (`PC-LOG-WARN`).
  static void w(String message, [Object? error, StackTrace? stackTrace]) {
    _internalLogger.w(message, error: error, stackTrace: stackTrace);
  }

  /// Logs an error message (`PC-LOG-ERROR`).
  static void e(String message, [Object? error, StackTrace? stackTrace]) {
    _internalLogger.e(message, error: error, stackTrace: stackTrace);
  }
}
