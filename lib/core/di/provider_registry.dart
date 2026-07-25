import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixelcanvas/core/di/providers.dart';

/// Central registry of infrastructure providers for PixelCanvas per Blueprint §10.2.
///
/// Registers base infrastructure providers only (no feature providers).
abstract final class ProviderRegistry {
  /// Returns list of all infrastructure provider references for diagnostic logging.
  static List<ProviderBase<Object?>> get infrastructureProviders => [
        appConfigProvider,
        loggerProvider,
        preferencesServiceProvider,
        secureStorageProvider,
        connectivityServiceProvider,
        supabaseClientWrapperProvider,
        localDatabaseProvider,
        uuidGeneratorProvider,
        clockProvider,
        packageInfoProvider,
        deviceInfoProvider,
      ];
}
