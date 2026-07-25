/// Abstract contract for persistent sync queue management.
///
/// Stores pending cloud sync operations locally per Blueprint §11.4.
abstract class SyncQueue {
  /// Enqueues an operation.
  Future<void> enqueue(Map<String, dynamic> operationData);

  /// Fetches next batch of pending items.
  Future<List<Map<String, dynamic>>> getPendingBatch({int limit = 10});

  /// Removes completed item from queue.
  Future<void> remove(String queueId);
}
