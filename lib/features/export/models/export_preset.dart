import 'package:equatable/equatable.dart';
import 'package:pixelcanvas/features/export/models/export_format.dart';

/// Reusable export configuration preset descriptor.
class ExportPreset extends Equatable {
  /// Creates an [ExportPreset].
  const ExportPreset({
    required this.id,
    required this.name,
    required this.format,
    this.scaleFactor = 1,
    this.quality = 100,
    this.isAnimated = false,
    this.isBuiltIn = true,
    this.isFavorite = false,
  });

  final String id;
  final String name;
  final ExportFormat format;
  final int scaleFactor;
  final int quality;
  final bool isAnimated;
  final bool isBuiltIn;
  final bool isFavorite;

  ExportPreset copyWith({
    String? id,
    String? name,
    ExportFormat? format,
    int? scaleFactor,
    int? quality,
    bool? isAnimated,
    bool? isBuiltIn,
    bool? isFavorite,
  }) =>
      ExportPreset(
        id: id ?? this.id,
        name: name ?? this.name,
        format: format ?? this.format,
        scaleFactor: scaleFactor ?? this.scaleFactor,
        quality: quality ?? this.quality,
        isAnimated: isAnimated ?? this.isAnimated,
        isBuiltIn: isBuiltIn ?? this.isBuiltIn,
        isFavorite: isFavorite ?? this.isFavorite,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        format,
        scaleFactor,
        quality,
        isAnimated,
        isBuiltIn,
        isFavorite,
      ];
}
