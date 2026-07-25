import 'package:pixelcanvas/core/domain/value_object.dart';

/// Validated email address value object.
final class Email extends ValueObject<String> {
  /// Creates an [Email].
  const Email(super.value);
}

/// Validated user handle value object.
final class Username extends ValueObject<String> {
  /// Creates a [Username].
  const Username(super.value);
}

/// Display name value object.
final class DisplayName extends ValueObject<String> {
  /// Creates a [DisplayName].
  const DisplayName(super.value);
}

/// Hexadecimal color string value object (e.g. "#6C5CE7").
final class HexColor extends ValueObject<String> {
  /// Creates a [HexColor].
  const HexColor(super.value);
}

/// Canvas dimensions value object (width × height).
final class CanvasSize extends ValueObject<(int width, int height)> {
  /// Creates a [CanvasSize].
  const CanvasSize(int width, int height) : super((width, height));

  /// Width in pixels.
  int get width => value.$1;

  /// Height in pixels.
  int get height => value.$2;
}

/// Pixel coordinate value object on 2D canvas grid.
final class PixelCoordinate extends ValueObject<(int x, int y)> {
  /// Creates a [PixelCoordinate].
  const PixelCoordinate(int x, int y) : super((x, y));

  /// X coordinate.
  int get x => value.$1;

  /// Y coordinate.
  int get y => value.$2;
}

/// Application or document semver version value object.
final class Version extends ValueObject<String> {
  /// Creates a [Version].
  const Version(super.value);
}
