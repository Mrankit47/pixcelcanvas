# Core Database

Local NoSQL database abstractions, collection contracts, schema initializer, migrations, and backup pipeline per Blueprint §11 and §12.

## Components

- **`isar_database.dart`**: Core Isar database contract and lifecycle instance manager.
- **`isar_collections.dart`**: Catalog of Isar entity collection schemas (`ProjectSchema`, `PaletteSchema`, `TemplateSchema`, `ProfileSchema`, `SyncQueueSchema`).
- **`database_initializer.dart`**: Database open configuration, inspector setup, and directory resolution.
- **`database_migrations.dart`**: Versioned schema migration runner per Blueprint §37.1 Gap 1.
- **`database_backup.dart`**: 4-tier backup manager (in-memory history, local snapshot, .pxc export, cloud sync).
