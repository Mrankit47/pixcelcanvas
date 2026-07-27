import 'package:equatable/equatable.dart';
import 'package:pixelcanvas/features/editor/engine/sprite_sheet/models/frame_tag.dart';

/// Metadata definition for a single sprite frame.
///
/// **Purpose**: Maintains frame identification, origin, dimensions, tags, and timing data.
/// **Architecture**: Pure Dart value object with `copyWith` and `Equatable`.
class FrameMetadata extends Equatable {
  /// Creates a [FrameMetadata].
  const FrameMetadata({
    required this.id,
    required this.name,
    required this.width,
    required this.height,
    this.originX = 0,
    this.originY = 0,
    this.durationMs = 100,
    this.tags = const [],
    this.layerIds = const [],
  });

  /// Unique frame identifier.
  final String id;

  /// Human-readable frame label (e.g. `Frame_01`).
  final String name;

  /// Frame width in pixels.
  final int width;

  /// Frame height in pixels.
  final int height;

  /// Origin pivot X offset in pixels.
  final int originX;

  /// Origin pivot Y offset in pixels.
  final int originY;

  /// Target playback duration in milliseconds (default: 100ms).
  final int durationMs;

  /// Associated animation tags (e.g. Idle, Walk).
  final List<FrameTag> tags;

  /// References to source layer IDs if multi-layered.
  final List<String> layerIds;

  /// Creates a copy of [FrameMetadata] with updated parameters.
  FrameMetadata copyWith({
    String? id,
    String? name,
    int? width,
    int? height,
    int? originX,
    int? originY,
    int? durationMs,
    List<FrameTag>? tags,
    List<String>? layerIds,
  }) =>
      FrameMetadata(
        id: id ?? this.id,
        name: name ?? this.name,
        width: width ?? this.width,
        height: height ?? this.height,
        originX: originX ?? this.originX,
        originY: originY ?? this.originY,
        durationMs: durationMs ?? this.durationMs,
        tags: tags ?? this.tags,
        layerIds: layerIds ?? this.layerIds,
      );

  /// Converts to JSON map for export.
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'width': width,
        'height': height,
        'originX': originX,
        'originY': originY,
        'durationMs': durationMs,
        'tags': tags.map((t) => t.name).toList(),
        'layerIds': layerIds,
      };

  @override
  List<Object?> get props => [
        id,
        name,
        width,
        height,
        originX,
        originY,
        durationMs,
        tags,
        layerIds,
      ];
}
