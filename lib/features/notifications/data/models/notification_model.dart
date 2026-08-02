/// Local Data Model for NotificationItem Entity.
class NotificationModel {
  /// Creates a [NotificationModel].
  NotificationModel({
    this.uuid = '',
    this.title = '',
    this.body = '',
    required this.timestamp,
    this.isRead = false,
  });

  /// Unique UUID index.
  String uuid;

  /// Notification title.
  String title;

  /// Body message text.
  String body;

  /// Timestamp index.
  DateTime timestamp;

  /// Read status flag.
  bool isRead;
}
