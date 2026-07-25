import 'package:pixelcanvas/features/notifications/data/models/notification_model.dart';
import 'package:pixelcanvas/features/notifications/domain/entities/notification.dart';

/// Bidirectional Mapper between [NotificationItem] domain entity and [NotificationModel] Isar collection.
abstract final class NotificationMapper {
  /// Converts [NotificationModel] to [NotificationItem] domain entity.
  static NotificationItem toDomain(NotificationModel model) => NotificationItem(
        id: model.uuid,
        title: model.title,
        body: model.body,
        timestamp: model.timestamp,
        isRead: model.isRead,
      );

  /// Converts [NotificationItem] domain entity to [NotificationModel].
  static NotificationModel fromDomain(NotificationItem entity) => NotificationModel(
        uuid: entity.id,
        title: entity.title,
        body: entity.body,
        timestamp: entity.timestamp,
        isRead: entity.isRead,
      );
}
