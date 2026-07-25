import 'package:pixelcanvas/core/domain/entity.dart';

/// Notification Domain Entity per Blueprint §6.1.
class NotificationItem extends Entity<String> {
  /// Creates a [NotificationItem].
  const NotificationItem({
    required String id,
    required this.title,
    required this.body,
    required this.timestamp,
    this.isRead = false,
  }) : super(id);

  /// Notification title.
  final String title;

  /// Message body text.
  final String body;

  /// Timestamp.
  final DateTime timestamp;

  /// Read status.
  final bool isRead;

  @override
  List<Object?> get props => [id, title, body, timestamp, isRead];
}
