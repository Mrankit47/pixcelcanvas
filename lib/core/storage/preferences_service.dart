/// Abstract contract for non-sensitive local user settings and preferences.
///
/// Wraps SharedPreferences per Blueprint §17.4.
abstract class PreferencesService {
  /// Reads boolean setting.
  bool? getBool(String key);

  /// Writes boolean setting.
  Future<bool> setBool({required String key, required bool value});

  /// Reads integer setting.
  int? getInt(String key);

  /// Writes integer setting.
  Future<bool> setInt({required String key, required int value});

  /// Reads string setting.
  String? getString(String key);

  /// Writes string setting.
  Future<bool> setString({required String key, required String value});

  /// Clears all preferences.
  Future<bool> clear();
}
