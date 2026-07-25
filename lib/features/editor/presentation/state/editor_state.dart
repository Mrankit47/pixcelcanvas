import 'package:equatable/equatable.dart';
import 'package:pixelcanvas/features/editor/engine/models/brush_settings.dart';
import 'package:pixelcanvas/features/editor/engine/models/eraser_settings.dart';

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
      ];
}
