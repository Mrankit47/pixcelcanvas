import 'package:equatable/equatable.dart';
import 'package:pixelcanvas/features/editor/engine/animation/models/loop_mode.dart';
import 'package:pixelcanvas/features/editor/engine/import/models/import_settings.dart';
import 'package:pixelcanvas/features/editor/engine/models/brush_settings.dart';
import 'package:pixelcanvas/features/editor/engine/models/eraser_settings.dart';
import 'package:pixelcanvas/features/editor/engine/selection/models/selection_bounds.dart';
import 'package:pixelcanvas/features/editor/engine/selection/models/selection_region.dart';
import 'package:pixelcanvas/features/editor/engine/shapes/models/shape_settings.dart';

/// Active drawing tool options for pixel editor.
enum PixelTool {
  select,
  pencil,
  brush,
  eraser,
  fill,
  line,
  rectangle,
  circle,
  move,
  text,
  eyedropper,
}

/// Serialisable layer info snapshot for presentation state per Blueprint §6.3.
class LayerInfo extends Equatable {
  /// Creates a [LayerInfo].
  const LayerInfo({
    required this.id,
    required this.name,
    this.isVisible = true,
    this.isLocked = false,
    this.opacity = 1.0,
  });

  /// Unique layer identifier.
  final String id;

  /// Display name.
  final String name;

  /// Visibility flag.
  final bool isVisible;

  /// Lock flag.
  final bool isLocked;

  /// Layer opacity.
  final double opacity;

  @override
  List<Object?> get props => [id, name, isVisible, isLocked, opacity];
}

/// Immutable State object for Pixel Editor workspace per Blueprint §6.3 & §8.2.
class EditorState extends Equatable {
  /// Creates an [EditorState].
  const EditorState({
    this.selectedTool = PixelTool.pencil,
    this.selectedLayerIndex = 0,
    this.zoomLevel = 1.0,
    this.showGrid = true,
    this.activeColorHex = '#6C5CE7',
    this.brushSettings = const BrushSettings(),
    this.eraserSettings = const EraserSettings(),
    this.canUndo = false,
    this.canRedo = false,
    this.layers = const [],
    this.isLoading = false,
    this.hasSelection = false,
    this.selectionBounds,
    this.isSelectionVisible = true,
    this.activeSelectionTool = SelectionType.rectangle,
    this.hasClipboard = false,
    this.hasFloatingSelection = false,
    this.isMovingSelection = false,
    this.shapeSettings = const ShapeSettings(),
    this.hasActiveTransform = false,
    this.hasActiveImport = false,
    this.importSettings = const ImportSettings(),
    this.hasSpriteSheet = false,
    this.frameCount = 0,
    this.activeFrameIndex = 0,
    this.isAnimationPlaying = false,
    this.currentAnimationFrameIndex = 0,
    this.activeClipName = 'Idle',
    this.onionSkinEnabled = false,
    this.animationFps = 12,
    this.animationLoopMode = LoopMode.loop,
  });

  /// Active drawing tool.
  final PixelTool selectedTool;

  /// Selected layer index.
  final int selectedLayerIndex;

  /// Zoom level multiplier (0.5x to 8.0x).
  final double zoomLevel;

  /// Canvas pixel grid visibility toggle.
  final bool showGrid;

  /// Primary active color hex string.
  final String activeColorHex;

  /// Brush engine settings configuration.
  final BrushSettings brushSettings;

  /// Eraser engine settings configuration.
  final EraserSettings eraserSettings;

  /// Undo available flag.
  final bool canUndo;

  /// Redo available flag.
  final bool canRedo;

  /// Layer info snapshots for UI rendering.
  final List<LayerInfo> layers;

  /// Loading status flag.
  final bool isLoading;

  /// True if there is an active selection.
  final bool hasSelection;

  /// Current selection bounding geometry.
  final SelectionBounds? selectionBounds;

  /// Whether the selection overlay is visible.
  final bool isSelectionVisible;

  /// Active selection tool type.
  final SelectionType activeSelectionTool;

  /// True if clipboard contains pixel data.
  final bool hasClipboard;

  /// True if a floating selection is active.
  final bool hasFloatingSelection;

  /// True if currently moving a selection.
  final bool isMovingSelection;

  /// Shape engine settings configuration.
  final ShapeSettings shapeSettings;

  /// True if an active transformation session is in progress.
  final bool hasActiveTransform;

  /// True if an image import preview session is currently active.
  final bool hasActiveImport;

  /// Image import configuration settings.
  final ImportSettings importSettings;

  /// True if a sprite sheet with frames is loaded.
  final bool hasSpriteSheet;

  /// Total sprite sheet frame count.
  final int frameCount;

  /// Currently selected sprite frame index.
  final int activeFrameIndex;

  /// True if animation playback is running.
  final bool isAnimationPlaying;

  /// Playhead animation frame index.
  final int currentAnimationFrameIndex;

  /// Active animation clip display name.
  final String activeClipName;

  /// True if onion skin translucent frame overlay is enabled.
  final bool onionSkinEnabled;

  /// Animation playback FPS rate.
  final int animationFps;

  /// Animation playback loop mode.
  final LoopMode animationLoopMode;

  /// Copy with support.
  EditorState copyWith({
    PixelTool? selectedTool,
    int? selectedLayerIndex,
    double? zoomLevel,
    bool? showGrid,
    String? activeColorHex,
    BrushSettings? brushSettings,
    EraserSettings? eraserSettings,
    bool? canUndo,
    bool? canRedo,
    List<LayerInfo>? layers,
    bool? isLoading,
    bool? hasSelection,
    SelectionBounds? selectionBounds,
    bool? isSelectionVisible,
    SelectionType? activeSelectionTool,
    bool? hasClipboard,
    bool? hasFloatingSelection,
    bool? isMovingSelection,
    ShapeSettings? shapeSettings,
    bool? hasActiveTransform,
    bool? hasActiveImport,
    ImportSettings? importSettings,
    bool? hasSpriteSheet,
    int? frameCount,
    int? activeFrameIndex,
    bool? isAnimationPlaying,
    int? currentAnimationFrameIndex,
    String? activeClipName,
    bool? onionSkinEnabled,
    int? animationFps,
    LoopMode? animationLoopMode,
  }) =>
      EditorState(
        selectedTool: selectedTool ?? this.selectedTool,
        selectedLayerIndex: selectedLayerIndex ?? this.selectedLayerIndex,
        zoomLevel: zoomLevel ?? this.zoomLevel,
        showGrid: showGrid ?? this.showGrid,
        activeColorHex: activeColorHex ?? this.activeColorHex,
        brushSettings: brushSettings ?? this.brushSettings,
        eraserSettings: eraserSettings ?? this.eraserSettings,
        canUndo: canUndo ?? this.canUndo,
        canRedo: canRedo ?? this.canRedo,
        layers: layers ?? this.layers,
        isLoading: isLoading ?? this.isLoading,
        hasSelection: hasSelection ?? this.hasSelection,
        selectionBounds: selectionBounds ?? this.selectionBounds,
        isSelectionVisible: isSelectionVisible ?? this.isSelectionVisible,
        activeSelectionTool: activeSelectionTool ?? this.activeSelectionTool,
        hasClipboard: hasClipboard ?? this.hasClipboard,
        hasFloatingSelection:
            hasFloatingSelection ?? this.hasFloatingSelection,
        isMovingSelection: isMovingSelection ?? this.isMovingSelection,
        shapeSettings: shapeSettings ?? this.shapeSettings,
        hasActiveTransform: hasActiveTransform ?? this.hasActiveTransform,
        hasActiveImport: hasActiveImport ?? this.hasActiveImport,
        importSettings: importSettings ?? this.importSettings,
        hasSpriteSheet: hasSpriteSheet ?? this.hasSpriteSheet,
        frameCount: frameCount ?? this.frameCount,
        activeFrameIndex: activeFrameIndex ?? this.activeFrameIndex,
        isAnimationPlaying: isAnimationPlaying ?? this.isAnimationPlaying,
        currentAnimationFrameIndex:
            currentAnimationFrameIndex ?? this.currentAnimationFrameIndex,
        activeClipName: activeClipName ?? this.activeClipName,
        onionSkinEnabled: onionSkinEnabled ?? this.onionSkinEnabled,
        animationFps: animationFps ?? this.animationFps,
        animationLoopMode: animationLoopMode ?? this.animationLoopMode,
      );

  @override
  List<Object?> get props => [
        selectedTool,
        selectedLayerIndex,
        zoomLevel,
        showGrid,
        activeColorHex,
        brushSettings,
        eraserSettings,
        canUndo,
        canRedo,
        layers,
        isLoading,
        hasSelection,
        selectionBounds,
        isSelectionVisible,
        activeSelectionTool,
        hasClipboard,
        hasFloatingSelection,
        isMovingSelection,
        shapeSettings,
        hasActiveTransform,
        hasActiveImport,
        importSettings,
        hasSpriteSheet,
        frameCount,
        activeFrameIndex,
        isAnimationPlaying,
        currentAnimationFrameIndex,
        activeClipName,
        onionSkinEnabled,
        animationFps,
        animationLoopMode,
      ];
}
