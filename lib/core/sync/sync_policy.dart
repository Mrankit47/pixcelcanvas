/// Background sync policy strategy enum per Blueprint §11.5.
enum SyncPolicy {
  /// Automatic sync on network restoration and periodic interval.
  auto,

  /// Immediate sync for high-priority write operations.
  immediate,

  /// Manual user-initiated sync (pull-to-refresh).
  manual,

  /// Wi-Fi only background sync to save mobile data.
  wifiOnly,
}
