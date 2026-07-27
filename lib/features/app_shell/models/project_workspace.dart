import 'package:equatable/equatable.dart';
import 'package:pixelcanvas/features/editor/engine/canvas_engine.dart';

/// Container representing a single open project workspace tab.
///
/// **Purpose**: Pairs a project canvas engine instance with tab state, dirty flag, and viewport settings.
class ProjectWorkspace extends Equatable {
  /// Creates a [ProjectWorkspace].
  ProjectWorkspace({
    required this.id,
    required this.name,
    this.filePath,
    CanvasEngine? engine,
    this.isDirty = false,
    this.zoom = 1.0,
    this.activeTool = 'Brush',
  }) : engine = engine ?? CanvasEngine();

  /// Unique workspace tab identifier.
  final String id;

  /// Display name for workspace tab bar (e.g. `HeroSprite.pixelcanvas`).
  final String name;

  /// Absolute file system path if saved.
  final String? filePath;

  /// Independent CanvasEngine instance per workspace.
  final CanvasEngine engine;

  /// Unsaved changes indicator flag.
  final bool isDirty;

  /// Viewport zoom scale.
  final double zoom;

  /// Active tool label.
  final String activeTool;

  /// Canvas width in pixels.
  int get canvasWidth => engine.width;

  /// Canvas height in pixels.
  int get canvasHeight => engine.height;

  /// Layer count.
  int get layerCount => engine.grid.layers.length;

  /// Animation clip frame count.
  int get frameCount => engine.animationEngine.activeClip?.frameCount ?? 0;

  /// Creates a copy of [ProjectWorkspace] with updated parameters.
  ProjectWorkspace copyWith({
    String? id,
    String? name,
    String? filePath,
    CanvasEngine? engine,
    bool? isDirty,
    double? zoom,
    String? activeTool,
  }) =>
      ProjectWorkspace(
        id: id ?? this.id,
        name: name ?? this.name,
        filePath: filePath ?? this.filePath,
        engine: engine ?? this.engine,
        isDirty: isDirty ?? this.isDirty,
        zoom: zoom ?? this.zoom,
        activeTool: activeTool ?? this.activeTool,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        filePath,
        isDirty,
        zoom,
        activeTool,
      ];
}
