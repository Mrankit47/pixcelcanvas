import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixelcanvas/core/utils/logger.dart';

/// Global [ProviderObserver] logging Riverpod provider lifecycle events in debug mode.
///
/// Derived directly from Blueprint §10.2 and §35.1.
class AppProviderObserver extends ProviderObserver {
  /// Creates an [AppProviderObserver].
  const AppProviderObserver();

  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    if (kDebugMode) {
      Logger.d(
        'Provider Created: ${provider.name ?? provider.runtimeType} | Initial Value: $value',
      );
    }
  }

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    if (kDebugMode) {
      Logger.d(
        'Provider Updated: ${provider.name ?? provider.runtimeType} | Prev: $previousValue -> New: $newValue',
      );
    }
  }

  @override
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) {
    if (kDebugMode) {
      Logger.d(
        'Provider Disposed: ${provider.name ?? provider.runtimeType}',
      );
    }
  }

  @override
  void providerDidFail(
    ProviderBase<Object?> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    if (kDebugMode) {
      Logger.e(
        'Provider Failed: ${provider.name ?? provider.runtimeType}',
        error,
        stackTrace,
      );
    }
  }
}
