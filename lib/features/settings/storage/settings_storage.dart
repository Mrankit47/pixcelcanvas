import 'dart:convert';
import 'package:pixelcanvas/features/settings/models/settings_profile.dart';

/// Persistence storage manager for settings profiles.
class SettingsStorage {
  static String? _persistedJson;

  /// Saves active [profile] to storage.
  static Future<bool> saveProfile(SettingsProfile profile) async {
    try {
      _persistedJson = const JsonEncoder.withIndent('  ').convert(profile.toJson());
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Loads saved profile from storage, or default fallback.
  static Future<SettingsProfile> loadProfile() async {
    if (_persistedJson != null && _persistedJson!.isNotEmpty) {
      try {
        final map = json.decode(_persistedJson!);
        return SettingsProfile.fromJson(map);
      } catch (_) {}
    }
    return const SettingsProfile(id: 'default', name: 'Default Profile');
  }
}
