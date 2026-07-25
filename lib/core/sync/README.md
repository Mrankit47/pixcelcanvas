# Core Sync

Offline-first synchronization architecture, background sync queue, scheduler, policy engine, and Last-Write-Wins (LWW) conflict resolution per Blueprint §11.

## Architecture & Responsibilities

- **`sync_service.dart`**: Background sync orchestrator and queue processor.
- **`sync_queue.dart`**: Persistent queue data structure for pending cloud operations.
- **`sync_status.dart`**: Sync state enumeration (`synced`, `pending_sync`, `conflict`, `local_only`).
- **`conflict_resolver.dart`**: Last-Write-Wins (LWW) resolution engine.
- **`sync_manager.dart`**: High-level sync controller interface.
- **`sync_scheduler.dart`**: Periodic background work scheduler.
- **`sync_policy.dart`**: Execution policy enum (`auto`, `immediate`, `manual`, `wifiOnly`).
- **`sync_conflict.dart`**: Conflict data model tracking local and remote version timestamps.
- **`sync_result.dart`**: Metrics container reporting sync execution results.
