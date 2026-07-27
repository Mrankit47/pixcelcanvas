import 'package:isar/isar.dart';
import 'package:pixelcanvas/core/database/isar_id_generator.dart';


/// Isar Local NoSQL Collection for NotificationItem Entity per Blueprint §6.2.
@collection
class NotificationModel {
  /// Creates a [NotificationModel].
  NotificationModel({
    this.uuid = '',
    this.title = '',
    this.body = '',
    required this.timestamp,
    this.isRead = false,
  });

  /// Isar primary key.
  Id get id => fastHash(uuid);

  /// Unique UUID index.
  @Index(unique: true, replace: true)
  String uuid;

  /// Notification title.
  String title;

  /// Body message text.
  String body;

  /// Timestamp index.
  @Index()
  DateTime timestamp;

  /// Read status flag.
  bool isRead;
}
