import 'package:flutter/material.dart';

/// Extension on [Color] providing HEX serialization and brightness helpers.
extension ColorExtensions on Color {
  /// Converts [Color] to 8-character ARGB HEX string (e.g., `FF6C5CE7`).
  String toHexArgb() =>
      // ignore: deprecated_member_use
      value.toRadixString(16).padLeft(8, '0').toUpperCase();

  /// Converts [Color] to 6-character RGB HEX string (e.g., `6C5CE7`).
  String toHexRgb() =>
      // ignore: deprecated_member_use
      (value & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase();
}
