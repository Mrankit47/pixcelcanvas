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
  final List<NotificationModel> _inMemoryNotifications = [];

  @override
  Future<List<NotificationModel>> getNotifications() async {
    final isar = _dbService.isar;
    if (isar != null) {
      final list = await isar.collection<NotificationModel>().where().findAll();
      list.sort((a, b) => b.timestamp.compareTo(a.timestamp));
      return list;
    }
    final list = List<NotificationModel>.from(_inMemoryNotifications);
    list.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return list;
  }

  @override
  Future<void> saveNotification(NotificationModel notification) async {
    final isar = _dbService.isar;
    if (isar != null) {
      await isar.writeTxn(() async {
        await isar.collection<NotificationModel>().put(notification);
      });
    } else {
      _inMemoryNotifications.add(notification);
    }
  }
}
