import 'dart:convert';
import 'package:pixelcanvas/features/settings/models/settings_profile.dart';

/// Exporter service serializing settings profiles to JSON string format.
class SettingsExporter {
  /// Serializes [profile] to formatted JSON string.
  static String exportJson(SettingsProfile profile) {
    return const JsonEncoder.withIndent('  ').convert(profile.toJson());
  }
}
