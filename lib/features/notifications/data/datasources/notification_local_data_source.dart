import 'package:isar/isar.dart';
import 'package:pixelcanvas/core/database/database_service.dart';
import 'package:pixelcanvas/features/notifications/data/models/notification_model.dart';

/// Contract for local notification database operations per Blueprint §6.2.
abstract interface class NotificationLocalDataSource {
  /// Gets all cached notifications.
  Future<List<NotificationModel>> getNotifications();

  /// Saves notification model.
  Future<void> saveNotification(NotificationModel notification);
}

/// Isar Implementation of [NotificationLocalDataSource].
class NotificationLocalDataSourceImpl implements NotificationLocalDataSource {
  /// Creates a [NotificationLocalDataSourceImpl].
  NotificationLocalDataSourceImpl(this._dbService);

  final DatabaseService _dbService;

  @override
  Future<List<NotificationModel>> getNotifications() async {
    return _dbService.isar.notificationModels.where().sortByTimestampDesc().findAll();
  }

  @override
  Future<void> saveNotification(NotificationModel notification) async {
    await _dbService.isar.writeTxn(() async {
      await _dbService.isar.notificationModels.put(notification);
    });
  }
}
