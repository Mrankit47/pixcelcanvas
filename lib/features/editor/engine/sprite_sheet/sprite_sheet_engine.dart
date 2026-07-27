import 'dart:typed_data';

import 'package:pixelcanvas/features/editor/engine/pixel.dart';
import 'package:pixelcanvas/features/editor/engine/selection/models/selection_bounds.dart';
import 'package:pixelcanvas/features/editor/engine/sprite_sheet/models/frame_tag.dart';
import 'package:pixelcanvas/features/editor/engine/sprite_sheet/models/sprite_frame.dart';
import 'package:pixelcanvas/features/editor/engine/sprite_sheet/models/sprite_sheet.dart';
import 'package:pixelcanvas/features/editor/engine/sprite_sheet/models/sprite_sheet_settings.dart';
import 'package:pixelcanvas/features/editor/engine/sprite_sheet/tools/frame_exporter.dart';
import 'package:pixelcanvas/features/editor/engine/sprite_sheet/tools/frame_grid_slicer.dart';
import 'package:pixelcanvas/features/editor/engine/sprite_sheet/tools/frame_importer.dart';
import 'package:pixelcanvas/features/editor/engine/sprite_sheet/tools/frame_manual_slicer.dart';

/// Central stateful manager coordinating sprite sheet frames and slicing operations.
///
/// **Purpose**: Orchestrates sprite sheet import, slicing, frame CRUD, tags, reordering, and export.
/// **Architecture**: Pure Dart — no Riverpod, Widgets, or framework dependencies.
class SpriteSheetEngine {
  /// Active sprite sheet asset container, or null if idle.
  SpriteSheet? _sheet;

  /// Active sprite sheet asset container getter.
  SpriteSheet? get sheet => _sheet;

  /// True if a sprite sheet with frames is currently active.
  bool get hasSpriteSheet => _sheet != null && _sheet!.frames.isNotEmpty;

  /// Total frame count.
  int get frameCount => _sheet?.frameCount ?? 0;

  /// Currently active selected frame index.
  int get activeFrameIndex => _sheet?.activeFrameIndex ?? 0;

  /// Currently active selected frame object, or null.
  SpriteFrame? get activeFrame => _sheet?.activeFrame;

  /// Imports sprite sheet PNG bytes and slices grid automatically.
  SpriteSheet? importSpriteSheet({
    required Uint8List bytes,
    required String id,
    required String name,
    SpriteSheetSettings settings = const SpriteSheetSettings(),
  }) {
    _sheet = FrameImporter.importFromPngBytes(
      imageBytes: bytes,
      id: id,
      name: name,
      settings: settings,
    );
    return _sheet;
  }

  /// Slices [canvasPixels] grid automatically into frames using [settings].
  List<SpriteFrame> sliceGrid({
    required List<Pixel> canvasPixels,
    required int canvasWidth,
    required int canvasHeight,
    required SpriteSheetSettings settings,
  }) {
    _ensureSheet(canvasWidth, canvasHeight);
    _sheet!.settings = settings;
    _sheet!.frames.clear();

    final sliced = FrameGridSlicer.sliceGrid(
      sheetPixels: canvasPixels,
      sheetWidth: canvasWidth,
      sheetHeight: canvasHeight,
      settings: settings,
    );

    _sheet!.frames.addAll(sliced);
    _sheet!.activeFrameIndex = 0;
    return sliced;
  }

  /// Manually creates a new frame from selection [bounds].
  SpriteFrame createFrame({
    required List<Pixel> canvasPixels,
    required int canvasWidth,
    required int canvasHeight,
    required SelectionBounds bounds,
    String? name,
  }) {
    _ensureSheet(canvasWidth, canvasHeight);
    final index = _sheet!.frames.length;
    final frameName = name ?? 'Frame_$index';

    final frame = FrameManualSlicer.sliceManual(
      canvasPixels: canvasPixels,
      canvasWidth: canvasWidth,
      canvasHeight: canvasHeight,
      bounds: bounds,
      frameId: 'frame_$index',
      frameName: frameName,
    );

    _sheet!.frames.add(frame);
    _sheet!.activeFrameIndex = _sheet!.frames.length - 1;
    return frame;
  }

  /// Duplicates frame at [index].
  SpriteFrame? duplicateFrame(int index) {
    if (_sheet == null || index < 0 || index >= _sheet!.frames.length) {
      return null;
    }

    final target = _sheet!.frames[index];
    final copyIndex = _sheet!.frames.length;
    final duplicate = target.clone(
      newId: 'frame_$copyIndex',
      newName: '${target.metadata.name}_Copy',
    );

    _sheet!.frames.insert(index + 1, duplicate);
    _sheet!.activeFrameIndex = index + 1;
    return duplicate;
  }

  /// Deletes frame at [index].
  SpriteFrame? deleteFrame(int index) {
    if (_sheet == null || index < 0 || index >= _sheet!.frames.length) {
      return null;
    }

    final removed = _sheet!.frames.removeAt(index);
    if (_sheet!.activeFrameIndex >= _sheet!.frames.length) {
      _sheet!.activeFrameIndex = (_sheet!.frames.length - 1).clamp(0, 4096);
    }
    return removed;
  }

  /// Renames frame at [index].
  void renameFrame(int index, String newName) {
    if (_sheet == null || index < 0 || index >= _sheet!.frames.length) return;
    final frame = _sheet!.frames[index];
    frame.metadata = frame.metadata.copyWith(name: newName);
  }

  /// Reorders frame from [oldIndex] to [newIndex].
  void reorderFrame(int oldIndex, int newIndex) {
    if (_sheet == null) return;
    if (oldIndex < 0 || oldIndex >= _sheet!.frames.length) return;
    if (newIndex < 0 || newIndex >= _sheet!.frames.length) return;

    final frame = _sheet!.frames.removeAt(oldIndex);
    _sheet!.frames.insert(newIndex, frame);
    _sheet!.activeFrameIndex = newIndex;
  }

  /// Adds [tag] to frame at [index].
  void addTagToFrame(int index, FrameTag tag) {
    if (_sheet == null || index < 0 || index >= _sheet!.frames.length) return;
    final frame = _sheet!.frames[index];
    if (!frame.metadata.tags.contains(tag)) {
      final updatedTags = List<FrameTag>.from(frame.metadata.tags)..add(tag);
      frame.metadata = frame.metadata.copyWith(tags: updatedTags);
    }
  }

  /// Removes [tag] from frame at [index].
  void removeTagFromFrame(int index, FrameTag tag) {
    if (_sheet == null || index < 0 || index >= _sheet!.frames.length) return;
    final frame = _sheet!.frames[index];
    final updatedTags = List<FrameTag>.from(frame.metadata.tags)..remove(tag);
    frame.metadata = frame.metadata.copyWith(tags: updatedTags);
  }

  /// Exports current sprite sheet to packed PNG binary data.
  Uint8List? exportSpriteSheetPng() {
    if (_sheet == null || _sheet!.frames.isEmpty) return null;
    return FrameExporter.exportSpriteSheetPng(_sheet!);
  }

  /// Exports current sprite sheet metadata to JSON string.
  String? exportJsonMetadata() {
    if (_sheet == null || _sheet!.frames.isEmpty) return null;
    return FrameExporter.exportJsonMetadata(_sheet!);
  }

  void _ensureSheet(int width, int height) {
    _sheet ??= SpriteSheet(
      id: 'sheet_0',
      name: 'SpriteSheet_0',
      width: width,
      height: height,
    );
    _sheet!.width = width;
    _sheet!.height = height;
  }
}
