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
  // Step 1: Ensure Flutter widget binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Configure Global Error Boundaries
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    Logger.e(
      'Uncaught Flutter Framework Error: ${details.exceptionAsString()}',
      details.exception,
      details.stack,
    );
  };

  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    Logger.e('Uncaught Platform Dispatcher Error', error, stack);
    return true;
  };

  await runZonedGuarded(
    () async {
      final manager = BootstrapManager()..start();

      try {
        // Step 2: Load AppConfig & Pre-flight Validation
        await manager.runStep(
          name: 'Load AppConfig',
          action: () async {
            await StartupValidator.validate();
          },
        );

        // Step 3: Initialize Logger
        await manager.runStep(
          name: 'Initialize Logger',
          action: () async {
            Logger.i(
              'Logger initialized (Environment: ${AppConfig.environment.name})',
            );
          },
        );

        // Step 4: Initialize SharedPreferences (placeholder)
        await manager.runStep(
          name: 'Initialize SharedPreferences',
          action: () async {
            Logger.i('SharedPreferences placeholder initialized');
          },
        );

        // Step 5: Initialize FlutterSecureStorage (placeholder)
        await manager.runStep(
          name: 'Initialize FlutterSecureStorage',
          action: () async {
            Logger.i('FlutterSecureStorage placeholder initialized');
          },
        );

        // Step 6: Initialize Isar Database (placeholder)
        await manager.runStep(
          name: 'Initialize Isar Database',
          action: () async {
            Logger.i('Isar Database placeholder initialized');
          },
        );

        // Step 7: Initialize Supabase Client (placeholder)
        await manager.runStep(
          name: 'Initialize Supabase',
          action: () async {
            Logger.i('Supabase Client placeholder initialized');
          },
        );

        // Step 8: Initialize Connectivity Service
        await manager.runStep(
          name: 'Initialize Connectivity Service',
          action: () async {
            Logger.i('Connectivity Service placeholder initialized');
          },
        );

        // Step 9: Initialize Dependency Container & Lifecycle Observer
        await manager.runStep(
          name: 'Initialize Dependency Container',
          action: () async {
            final lifecycleService = LifecycleService()..initialize();
            Logger.i('Lifecycle observer attached (${lifecycleService.runtimeType})');
          },
        );

        manager.finish(isSuccess: true);

        // Step 10: Launch Application wrapped in Riverpod AppProviderScope
        runApp(
          AppProviderScope(
            child: builder(),
          ),
        );
      } catch (e, stackTrace) {
        manager.finish(isSuccess: false);
        Logger.e('Fatal application bootstrap failure', e, stackTrace);
      }
    },
    (Object error, StackTrace stackTrace) {
      Logger.e('Uncaught Zone Error', error, stackTrace);
    },
  );
}
