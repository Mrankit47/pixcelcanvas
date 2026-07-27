import 'package:equatable/equatable.dart';
import 'package:pixelcanvas/features/project_creation/models/palette_preset.dart';
import 'package:pixelcanvas/features/project_creation/models/template_metadata.dart';

/// Container pairing [TemplateMetadata] with editor configuration presets.
class TemplatePreset extends Equatable {
  /// Creates a [TemplatePreset].
  const TemplatePreset({
    required this.metadata,
    required this.palette,
    this.layerNames = const ['Background', 'Main Art'],
    this.showGrid = true,
    this.gridSize = 16,
    this.defaultZoom = 1.0,
    this.enableAnimation = false,
    this.defaultFps = 12,
    this.initialFrameCount = 4,
  });

  final TemplateMetadata metadata;
  final PalettePreset palette;
  final List<String> layerNames;
  final bool showGrid;
  final int gridSize;
  final double defaultZoom;
  final bool enableAnimation;
  final int defaultFps;
  final int initialFrameCount;

  @override
  List<Object?> get props => [
        metadata,
        palette,
        layerNames,
        showGrid,
        gridSize,
        defaultZoom,
        enableAnimation,
        defaultFps,
        initialFrameCount,
      ];
}
