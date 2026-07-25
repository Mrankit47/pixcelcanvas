/// Local storage constants for Isar database, SharedPreferences, and secure storage keys.
///
/// Derived directly from Blueprint §11 and §17.
abstract final class StorageConstants {
  /// Isar database instance name.
  static const String isarDatabaseName = 'pixelcanvas_db';

  // ── SharedPreferences Keys ──
  static const String keyIsFirstLaunch = 'is_first_launch';
  static const String keyDefaultGridSize = 'default_grid_size';
  static const String keyHapticEnabled = 'haptic_enabled';
  static const String keyAutoSaveInterval = 'auto_save_interval';
  static const String keyNotificationPrefs = 'notification_prefs';

  // ── Secure Storage Keys ──
  static const String keyAuthAccessToken = 'auth_access_token';
  static const String keyAuthRefreshToken = 'auth_refresh_token';
  static const String keyUserId = 'user_id';
}
