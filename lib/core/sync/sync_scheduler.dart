/// Background sync scheduler contract per Blueprint §11.5.
///
/// Purpose: Schedules periodic and event-driven background sync tasks.
/// Responsibilities: Registers background sync workers when device is idle and connected to unmetered network.
/// Future Implementation Notes: Wraps platform workmanager / background tasks.
abstract class SyncScheduler {
  /// Schedules periodic background sync task (e.g. every 15 mins).
  Future<void> schedulePeriodicSync({Duration interval = const Duration(minutes: 15)});

  /// Cancels scheduled background sync task.
  Future<void> cancelSync();
}
