/// Data model describing a sync conflict between local and remote entities per Blueprint §11.6.
class SyncConflict<T> {
  /// Creates a [SyncConflict] instance.
  const SyncConflict({
    required this.entityId,
    required this.localVersion,
    required this.remoteVersion,
    required this.localTimestamp,
    required this.remoteTimestamp,
  });

  /// Identifier of conflicting entity.
  final String entityId;

  /// Local entity version.
  final T localVersion;

  /// Remote entity version.
  final T remoteVersion;

  /// Local modification timestamp.
  final DateTime localTimestamp;

  /// Remote modification timestamp.
  final DateTime remoteTimestamp;
}
