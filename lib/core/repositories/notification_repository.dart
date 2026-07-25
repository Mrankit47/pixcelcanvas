import 'package:pixelcanvas/core/repositories/offline_repository.dart';

/// Notification repository interface contract per Blueprint §6.2 and §16.
///
/// Purpose: Manages user notifications and preference settings.
/// Responsibilities: Notification persistence, mark as read, and unread count tracking.
/// Future Implementation Notes: Concrete implementation `NotificationRepositoryImpl` in `features/notifications/data/`.
abstract class NotificationRepository implements OfflineRepository<Map<String, dynamic>, String> {
  /// Fetches unread notifications count.
  Future<int> getUnreadCount();

  /// Marks notification as read.
  Future<void> markAsRead(String notificationId);
}
