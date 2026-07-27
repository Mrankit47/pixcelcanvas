import 'package:equatable/equatable.dart';

/// Configuration settings for automatic grid slicing of sprite sheets.
///
/// **Purpose**: Defines cell dimensions, padding, margins, and offsets for frame slicing.
/// **Architecture**: Pure Dart value object with `copyWith` and `Equatable`.
class SpriteSheetSettings extends Equatable {
  /// Creates a [SpriteSheetSettings].
  const SpriteSheetSettings({
    this.cellWidth = 32,
    this.cellHeight = 32,
    this.paddingX = 0,
    this.paddingY = 0,
    this.marginX = 0,
    this.marginY = 0,
    this.offsetX = 0,
    this.offsetY = 0,
  });

  /// Width of each grid frame cell in pixels.
  final int cellWidth;

  /// Height of each grid frame cell in pixels.
  final int cellHeight;

  /// Horizontal padding between adjacent cells in pixels.
  final int paddingX;

  /// Vertical padding between adjacent cells in pixels.
  final int paddingY;

  /// Outer horizontal margin in pixels.
  final int marginX;

  /// Outer vertical margin in pixels.
  final int marginY;

  /// Initial horizontal offset in pixels.
  final int offsetX;

  /// Initial vertical offset in pixels.
  final int offsetY;

  /// Creates a copy of [SpriteSheetSettings] with updated parameters.
  SpriteSheetSettings copyWith({
    int? cellWidth,
    int? cellHeight,
    int? paddingX,
    int? paddingY,
    int? marginX,
    int? marginY,
    int? offsetX,
    int? offsetY,
  }) =>
      SpriteSheetSettings(
        cellWidth: (cellWidth ?? this.cellWidth).clamp(1, 4096),
        cellHeight: (cellHeight ?? this.cellHeight).clamp(1, 4096),
        paddingX: (paddingX ?? this.paddingX).clamp(0, 1024),
        paddingY: (paddingY ?? this.paddingY).clamp(0, 1024),
        marginX: (marginX ?? this.marginX).clamp(0, 1024),
        marginY: (marginY ?? this.marginY).clamp(0, 1024),
        offsetX: (offsetX ?? this.offsetX).clamp(0, 4096),
        offsetY: (offsetY ?? this.offsetY).clamp(0, 4096),
      );

  @override
  List<Object?> get props => [
        cellWidth,
        cellHeight,
        paddingX,
        paddingY,
        marginX,
        marginY,
        offsetX,
        offsetY,
      ];
}
