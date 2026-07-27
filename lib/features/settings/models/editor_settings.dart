import 'package:equatable/equatable.dart';

/// Editor preferences defaults.
class EditorSettings extends Equatable {
  /// Creates an [EditorSettings].
  const EditorSettings({
    this.defaultZoom = 1.0,
    this.showGrid = true,
    this.gridSize = 16,
    this.gridColorHex = '#3A3A4D',
    this.selectionColorHex = '#6C5CE7',
    this.snapToGrid = false,
    this.defaultTool = 'Brush',
    this.undoHistoryLimit = 50,
  });

  final double defaultZoom;
  final bool showGrid;
  final int gridSize;
  final String gridColorHex;
  final String selectionColorHex;
  final bool snapToGrid;
  final String defaultTool;
  final int undoHistoryLimit;

  EditorSettings copyWith({
    double? defaultZoom,
    bool? showGrid,
    int? gridSize,
    String? gridColorHex,
    String? selectionColorHex,
    bool? snapToGrid,
    String? defaultTool,
    int? undoHistoryLimit,
  }) =>
      EditorSettings(
        defaultZoom: defaultZoom ?? this.defaultZoom,
        showGrid: showGrid ?? this.showGrid,
        gridSize: gridSize ?? this.gridSize,
        gridColorHex: gridColorHex ?? this.gridColorHex,
        selectionColorHex: selectionColorHex ?? this.selectionColorHex,
        snapToGrid: snapToGrid ?? this.snapToGrid,
        defaultTool: defaultTool ?? this.defaultTool,
        undoHistoryLimit: undoHistoryLimit ?? this.undoHistoryLimit,
      );

  Map<String, dynamic> toJson() => {
        'defaultZoom': defaultZoom,
        'showGrid': showGrid,
        'gridSize': gridSize,
        'gridColorHex': gridColorHex,
        'selectionColorHex': selectionColorHex,
        'snapToGrid': snapToGrid,
        'defaultTool': defaultTool,
        'undoHistoryLimit': undoHistoryLimit,
      };

  factory EditorSettings.fromJson(Map<String, dynamic> json) => EditorSettings(
        defaultZoom: (json['defaultZoom'] as num?)?.toDouble() ?? 1.0,
        showGrid: json['showGrid'] ?? true,
        gridSize: json['gridSize'] ?? 16,
        gridColorHex: json['gridColorHex'] ?? '#3A3A4D',
        selectionColorHex: json['selectionColorHex'] ?? '#6C5CE7',
        snapToGrid: json['snapToGrid'] ?? false,
        defaultTool: json['defaultTool'] ?? 'Brush',
        undoHistoryLimit: json['undoHistoryLimit'] ?? 50,
      );

  @override
  List<Object?> get props => [
        defaultZoom,
        showGrid,
        gridSize,
        gridColorHex,
        selectionColorHex,
        snapToGrid,
        defaultTool,
        undoHistoryLimit,
      ];
}
