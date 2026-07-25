import 'package:flutter/material.dart';

/// Extension on [BuildContext] providing ergonomic shortcuts for common theme and layout lookups.
extension ContextExtensions on BuildContext {
  /// Quick access to current [ThemeData].
  ThemeData get theme => Theme.of(this);

  /// Quick access to current [TextTheme].
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Quick access to current [ColorScheme].
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Quick access to current [MediaQueryData].
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Screen width in logical pixels.
  double get screenWidth => mediaQuery.size.width;

  /// Screen height in logical pixels.
  double get screenHeight => mediaQuery.size.height;
}
