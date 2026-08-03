import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pixelcanvas/core/di/provider_scope.dart';

/// Minimal, crash-proof application bootstrap for PixelCanvas.
Future<void> bootstrap(Widget Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();

  // Global error boundaries — catch and log, never crash
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    if (kDebugMode) {
      debugPrint('FlutterError: ${details.exceptionAsString()}');
    }
  };

  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    if (kDebugMode) {
      debugPrint('PlatformError: $error');
    }
    return true;
  };

  // Launch Application wrapped in Riverpod AppProviderScope
  runApp(
    AppProviderScope(
      child: builder(),
    ),
  );
}
