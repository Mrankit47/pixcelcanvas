# Core Repositories

Repository interface contracts and offline-first data access patterns per Blueprint §8.1 and §11.

## Architecture & Data Flow

All repository operations follow the mandatory **Offline-First Data Flow**:

```
READ ORDER:
  Memory Cache (LRU)
        ↓ (miss)
  Local Database (Isar)
        ↓ (miss / stale)
  Remote Backend (Supabase)

WRITE ORDER:
  Local Database (Isar)
        ↓ (immediate save < 5ms)
  Sync Queue (Isar Queue)
        ↓ (background process)
  Remote Backend (Supabase)
```

## Contracts

- **`repository.dart`**: Base generic `Repository<T, ID>` contract.
- **`offline_repository.dart`**: Extension for offline-first local-first persistence.
- **`sync_repository.dart`**: Extension for cloud synchronizable entities.
- **Feature Contracts**: `ProjectRepository`, `TemplateRepository`, `PaletteRepository`, `ProfileRepository`, `NotificationRepository`, `CommunityRepository`.
