# Core Module

The `core` directory contains application-wide, non-feature-specific infrastructure, services, utilities, and constants.

## Subdirectories

- **`constants/`**: Global application, API, and storage constants.
- **`errors/`**: Exception hierarchy and error domain definitions.
- **`extensions/`**: Dart and Flutter type extensions (BuildContext, Color, String, Date).
- **`network/`**: Connectivity monitors, Supabase client initialization, API interceptors.
- **`storage/`**: Local database (Isar), secure storage, and shared preferences abstractions.
- **`sync/`**: Offline-first synchronization engine, queue management, conflict resolution.
- **`utils/`**: Utility classes (Logger, Debouncer, ColorUtils, ImageUtils).
