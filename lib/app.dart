import 'package:flutter/material.dart';
import 'package:pixelcanvas/navigation/app_router.dart';
import 'package:pixelcanvas/theme/app_theme.dart';

/// The root widget of the PixelCanvas application.
///
/// Configures [MaterialApp.router] with Material 3, light theme only using [AppTheme.lightTheme],
/// and [AppRouter.router] declarative navigation per Blueprint §7.1.
class PixelCanvasApp extends StatelessWidget {
  /// Creates the [PixelCanvasApp] widget.
  const PixelCanvasApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        title: 'PixelCanvas',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        theme: AppTheme.lightTheme,
        routerConfig: AppRouter.router,
      );
}
