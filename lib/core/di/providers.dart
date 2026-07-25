import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixelcanvas/core/config/app_config.dart';
import 'package:pixelcanvas/core/network/connectivity_service.dart';
import 'package:pixelcanvas/core/network/supabase_client.dart';
import 'package:pixelcanvas/core/storage/local_database.dart';
import 'package:pixelcanvas/core/storage/preferences_service.dart';
import 'package:pixelcanvas/core/storage/secure_storage.dart';
import 'package:pixelcanvas/core/utils/logger.dart';
import 'package:uuid/uuid.dart';

// ── 1. AppConfig Provider ──
/// Purpose: Provides access to [AppConfig] environment settings.
/// Lifecycle: Never auto-dispose (App lifetime per Blueprint §10.2).
/// Dependencies: None.
/// Future usage: Consumed by API, database, and sync services to inspect environment.
final Provider<Type> appConfigProvider = Provider<Type>(
  (ref) => AppConfig,
  name: 'appConfigProvider',
);

// ── 2. Logger Provider ──
/// Purpose: Provides access to structured [Logger] interface.
/// Lifecycle: Never auto-dispose (App lifetime per Blueprint §10.2).
/// Dependencies: None.
/// Future usage: Injected into repositories, network clients, and state notifiers for telemetry logging.
final Provider<Type> loggerProvider = Provider<Type>(
  (ref) => Logger,
  name: 'loggerProvider',
);

// ── 3. PreferencesService Provider (Placeholder) ──
/// Purpose: Provides access to [PreferencesService] for non-sensitive local settings.
/// Lifecycle: Never auto-dispose (App lifetime per Blueprint §10.2).
/// Dependencies: Requires SharedPreferences instance initialized in bootstrap.
/// Future usage: Injected into SettingsRepository and user preferences providers.
final Provider<PreferencesService?> preferencesServiceProvider =
    Provider<PreferencesService?>(
  (ref) => null, // Placeholder — overridden in bootstrap/ProviderScope
  name: 'preferencesServiceProvider',
);

// ── 4. SecureStorage Provider (Placeholder) ──
/// Purpose: Provides access to [SecureStorage] for encrypted credentials.
/// Lifecycle: Never auto-dispose (App lifetime per Blueprint §10.2).
/// Dependencies: Requires FlutterSecureStorage instance.
/// Future usage: Injected into AuthRepository to read/write JWT tokens securely.
final Provider<SecureStorage?> secureStorageProvider =
    Provider<SecureStorage?>(
  (ref) => null, // Placeholder — overridden in ProviderScope
  name: 'secureStorageProvider',
);

// ── 5. ConnectivityService Provider (Placeholder) ──
/// Purpose: Provides access to [ConnectivityService] for online/offline monitoring.
/// Lifecycle: Never auto-dispose (App lifetime per Blueprint §10.2).
/// Dependencies: None.
/// Future usage: Consumed by SyncService to trigger background upload when connectivity restores.
final Provider<ConnectivityService?> connectivityServiceProvider =
    Provider<ConnectivityService?>(
  (ref) => null, // Placeholder — overridden in ProviderScope
  name: 'connectivityServiceProvider',
);

// ── 6. SupabaseClientWrapper Provider (Placeholder) ──
/// Purpose: Provides access to [SupabaseClientWrapper] for cloud API requests.
/// Lifecycle: Never auto-dispose (App lifetime per Blueprint §10.2).
/// Dependencies: Requires initialized Supabase client.
/// Future usage: Injected into RemoteDataSources for cloud sync and community gallery queries.
final Provider<SupabaseClientWrapper?> supabaseClientWrapperProvider =
    Provider<SupabaseClientWrapper?>(
  (ref) => null, // Placeholder — overridden in ProviderScope
  name: 'supabaseClientWrapperProvider',
);

// ── 7. LocalDatabase Provider (Placeholder) ──
/// Purpose: Provides access to [LocalDatabase] (Isar) instance.
/// Lifecycle: Never auto-dispose (App lifetime per Blueprint §10.2).
/// Dependencies: Requires open Isar database instance.
/// Future usage: Injected into LocalDataSources for project CRUD, custom palettes, and sync queue.
final Provider<LocalDatabase?> localDatabaseProvider =
    Provider<LocalDatabase?>(
  (ref) => null, // Placeholder — overridden in ProviderScope
  name: 'localDatabaseProvider',
);

// ── 8. UuidGenerator Provider ──
/// Purpose: Provides access to client-side [Uuid] generator.
/// Lifecycle: Never auto-dispose (App lifetime per Blueprint §10.2).
/// Dependencies: None.
/// Future usage: Consumed by ProjectRepository to generate offline-first UUID v4 identifiers.
final Provider<Uuid> uuidGeneratorProvider = Provider<Uuid>(
  (ref) => const Uuid(),
  name: 'uuidGeneratorProvider',
);

// ── 9. Clock Provider ──
/// Purpose: Provides system current timestamp factory.
/// Lifecycle: Never auto-dispose (App lifetime per Blueprint §10.2).
/// Dependencies: None.
/// Future usage: Consumed by repositories for deterministic time calculations in testing.
final Provider<DateTime Function()> clockProvider =
    Provider<DateTime Function()>(
  (ref) => DateTime.now,
  name: 'clockProvider',
);

// ── 10. PackageInfo Provider (Placeholder) ──
/// Purpose: Provides access to app version and build number metadata.
/// Lifecycle: Never auto-dispose (App lifetime per Blueprint §10.2).
/// Dependencies: Requires PackageInfo initialized during startup.
/// Future usage: Included in `.pxc` project generator string and settings screen.
final Provider<Map<String, String>> packageInfoProvider =
    Provider<Map<String, String>>(
  (ref) => const {'version': '1.0.0', 'buildNumber': '1'},
  name: 'packageInfoProvider',
);

// ── 11. DeviceInfo Provider (Placeholder) ──
/// Purpose: Provides access to device hardware tier and OS version metadata.
/// Lifecycle: Never auto-dispose (App lifetime per Blueprint §10.2).
/// Dependencies: Requires DeviceInfo initialized during startup.
/// Future usage: Used for device-tier detection (low/mid/high RAM) to set canvas memory budgets.
final Provider<Map<String, dynamic>> deviceInfoProvider =
    Provider<Map<String, dynamic>>(
  (ref) => const {'platform': 'unknown'},
  name: 'deviceInfoProvider',
);
