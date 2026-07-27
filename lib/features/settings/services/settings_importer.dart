import 'dart:convert';
import 'package:pixelcanvas/features/settings/models/settings_profile.dart';

/// Importer service deserializing settings profiles from JSON string format.
class SettingsImporter {
  /// Deserializes [jsonString] into a [SettingsProfile].
  static SettingsProfile? importJson(String jsonString) {
    try {
      final map = json.decode(jsonString);
      if (map is Map<String, dynamic>) {
        return SettingsProfile.fromJson(map);
      }
    } catch (_) {}
    return null;
  }
}
