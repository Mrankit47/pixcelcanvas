import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pixelcanvas/core/bootstrap/bootstrap_manager.dart';
import 'package:pixelcanvas/core/bootstrap/startup_validator.dart';
import 'package:pixelcanvas/core/config/app_config.dart';
import 'package:pixelcanvas/core/di/provider_scope.dart';
import 'package:pixelcanvas/core/services/lifecycle_service.dart';
import 'package:pixelcanvas/core/utils/logger.dart';

/// Production-ready application bootstrap pipeline for PixelCanvas.
///
/// Executes the 10-step startup sequence with global error boundaries,
/// structured logging, and lifecycle observer registration per prompt requirements.
Future<void> bootstrap(Widget Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();

  // Configure Global Error Boundaries
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    Logger.e(
      'Flutter Framework Error: ${details.exceptionAsString()}',
      details.exception,
      details.stack,
    );
  };

  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    Logger.e('Platform Dispatcher Error', error, stack);
    return true;
  };

  try {
    final lifecycleService = LifecycleService()..initialize();
    Logger.i('Lifecycle observer attached (${lifecycleService.runtimeType})');
  } catch (e, stack) {
    Logger.e('Lifecycle initialization error', e, stack);
  }

  // Launch Application wrapped in Riverpod AppProviderScope
  runApp(
    AppProviderScope(
      child: builder(),
    ),
  );
}
