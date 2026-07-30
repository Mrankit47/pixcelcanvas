import 'package:pixelcanvas/features/editor/engine/sprite_sheet/models/sprite_frame.dart';
import 'package:pixelcanvas/features/editor/engine/sprite_sheet/models/sprite_sheet_settings.dart';

/// Container model representing a complete Sprite Sheet asset with frames.
///
/// **Purpose**: Groups extracted frames, sheet dimensions, active selection, and slice settings.
/// **Architecture**: Pure Dart container — no framework dependencies.
class SpriteSheet {
  /// Creates a [SpriteSheet].
  SpriteSheet({
    required this.id,
    required this.name,
    required this.width,
    required this.height,
    List<SpriteFrame>? frames,
    this.activeFrameIndex = 0,
    this.settings = const SpriteSheetSettings(),
  }) : frames = frames != null ? List<SpriteFrame>.from(frames) : <SpriteFrame>[];

  /// Unique sprite sheet identifier.
  final String id;

  /// Display name.
  String name;

  /// Total sheet width in pixels.
  int width;

  /// Total sheet height in pixels.
  int height;

  /// Ordered list of sprite frames.
  final List<SpriteFrame> frames;

  /// Currently active selected frame index.
  int activeFrameIndex;

  /// Active grid slicing settings.
  SpriteSheetSettings settings;

  /// Returns the currently active frame, or null if list is empty.
  SpriteFrame? get activeFrame {
    if (frames.isEmpty || activeFrameIndex < 0 || activeFrameIndex >= frames.length) {
      return null;
    }
    return frames[activeFrameIndex];
  }

  /// Total frame count.
  int get frameCount => frames.length;
}
