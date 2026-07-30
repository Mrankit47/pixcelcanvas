import 'package:equatable/equatable.dart';
import 'package:pixelcanvas/features/editor/engine/pixel.dart';

/// Representation of an individual frame on the animation timeline.
///
/// **Purpose**: Defines frame duration, optional FPS override, and pixel data reference.
/// **Architecture**: Pure Dart value object with `copyWith` and `Equatable`.
class AnimationFrame extends Equatable {
  /// Creates an [AnimationFrame].
  AnimationFrame({
    required this.id,
    this.spriteFrameId,
    this.durationMs = 100,
    this.fpsOverride,
    List<Pixel>? pixels,
  }) : pixels = pixels != null ? List<Pixel>.from(pixels) : <Pixel>[];

  /// Unique frame instance identifier.
  final String id;

  /// Optional ID referencing an underlying `SpriteFrame`.
  final String? spriteFrameId;

  /// Frame duration in milliseconds (default: 100ms = 10 FPS).
  final int durationMs;

  /// Optional per-frame FPS override.
  final int? fpsOverride;

  /// Pixel buffer fallback array.
  final List<Pixel> pixels;

  /// Creates a copy of [AnimationFrame] with updated fields.
  AnimationFrame copyWith({
    String? id,
    String? spriteFrameId,
    int? durationMs,
    int? fpsOverride,
    List<Pixel>? pixels,
  }) =>
      AnimationFrame(
        id: id ?? this.id,
        spriteFrameId: spriteFrameId ?? this.spriteFrameId,
        durationMs: (durationMs ?? this.durationMs).clamp(1, 60000),
        fpsOverride: fpsOverride ?? this.fpsOverride,
        pixels: pixels ?? this.pixels,
      );

  /// Converts to JSON map for export.
  Map<String, dynamic> toJson() => {
        'id': id,
        'spriteFrameId': spriteFrameId,
        'durationMs': durationMs,
        'fpsOverride': fpsOverride,
      };

  @override
  List<Object?> get props => [
        id,
        spriteFrameId,
        durationMs,
        fpsOverride,
        pixels,
      ];
}
