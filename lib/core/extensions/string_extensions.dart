import 'package:flutter/material.dart';

/// Extension on [String] for HEX parsing and validation.
extension StringExtensions on String {
  /// Parses a HEX string into a Flutter [Color].
  Color toColor() {
    final hex = replaceAll('#', '');
    if (hex.length == 6) {
      return Color(int.parse('FF$hex', radix: 16));
    } else if (hex.length == 8) {
      return Color(int.parse(hex, radix: 16));
    }
    return Colors.black;
  }
}
