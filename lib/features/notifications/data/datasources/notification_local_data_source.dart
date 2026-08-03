import 'package:pixelcanvas/features/notifications/data/models/notification_model.dart';

/// Contract for local notification database operations.
abstract interface class NotificationLocalDataSource {
  /// Gets all cached notifications.
  Future<List<NotificationModel>> getNotifications();

  /// Saves notification model.
  Future<void> saveNotification(NotificationModel notification);
}

/// Pure in-memory implementation of [NotificationLocalDataSource].
class NotificationLocalDataSourceImpl implements NotificationLocalDataSource {
  /// Creates a [NotificationLocalDataSourceImpl].
  NotificationLocalDataSourceImpl(dynamic dbService);

  final List<NotificationModel> _notifications = [];

  @override
  Future<List<NotificationModel>> getNotifications() async {
    final list = List<NotificationModel>.from(_notifications);
    list.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return list;
  }

  @override
  Future<void> saveNotification(NotificationModel notification) async {
    _notifications.add(notification);
  }
}
