import 'package:equatable/equatable.dart';

/// Canvas size preset model.
class CanvasPreset extends Equatable {
  /// Creates a [CanvasPreset].
  const CanvasPreset({
    required this.name,
    required this.width,
    required this.height,
    required this.category,
  });

  final String name;
  final int width;
  final int height;
  final String category;

  /// Resolution string e.g. `32 × 32`.
  String get resolutionString => '$width × $height';

  /// Standard canvas presets library.
  static const List<CanvasPreset> defaults = [
    CanvasPreset(name: '16×16 Icon', width: 16, height: 16, category: 'Icons'),
    CanvasPreset(name: '32×32 Sprite', width: 32, height: 32, category: 'Sprites'),
    CanvasPreset(name: '48×48 Tile', width: 48, height: 48, category: 'Tiles'),
    CanvasPreset(name: '64×64 Character', width: 64, height: 64, category: 'Characters'),
    CanvasPreset(name: '96×96 Portrait', width: 96, height: 96, category: 'Portraits'),
    CanvasPreset(name: '128×128 Animation', width: 128, height: 128, category: 'Animations'),
    CanvasPreset(name: '256×256 Scene', width: 256, height: 256, category: 'Environment'),
    CanvasPreset(name: '512×512 HD Canvas', width: 512, height: 512, category: 'High-Res'),
  ];

  @override
  List<Object?> get props => [name, width, height, category];
}
