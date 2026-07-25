import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixelcanvas/core/di/provider_observer.dart';

/// Root Application [ProviderScope] builder widget for PixelCanvas per Blueprint §10.2.
///
/// Wraps application widget tree with configured [AppProviderObserver] and optional overrides.
class AppProviderScope extends StatelessWidget {
  /// Creates an [AppProviderScope].
  const AppProviderScope({
    required this.child,
    this.overrides = const [],
    super.key,
  });

  /// Root application widget.
  final Widget child;

  /// Optional provider overrides (used in bootstrap or tests).
  final List<Override> overrides;

  @override
  Widget build(BuildContext context) => ProviderScope(
        observers: const [AppProviderObserver()],
        overrides: overrides,
        child: child,
      );
}
