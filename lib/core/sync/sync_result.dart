/// Result metrics container for sync pipeline executions per Blueprint §11.5.
class SyncResult {
  /// Creates a [SyncResult] instance.
  const SyncResult({
    required this.syncedCount,
    required this.conflictCount,
    required this.errorCount,
    required this.duration,
    required this.isSuccess,
  });

  /// Number of records successfully synchronized.
  final int syncedCount;

  /// Number of conflicts resolved.
  final int conflictCount;

  /// Number of errors encountered.
  final int errorCount;

  /// Duration taken to complete sync cycle.
  final Duration duration;

  /// True if sync cycle completed without unhandled fatal errors.
  final bool isSuccess;

  @override
  String toString() =>
      'SyncResult(success: $isSuccess, synced: $syncedCount, conflicts: $conflictCount, errors: $errorCount, duration: ${duration.inMilliseconds}ms)';
}
