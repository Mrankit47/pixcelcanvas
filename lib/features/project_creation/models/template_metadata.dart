import 'package:equatable/equatable.dart';
import 'package:pixelcanvas/features/project_creation/models/template_category.dart';

/// Metadata descriptor for template items per Blueprint §7.3.
class TemplateMetadata extends Equatable {
  /// Creates a [TemplateMetadata].
  const TemplateMetadata({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    this.author = 'PixelCanvas Team',
    this.version = '1.0.0',
    this.width = 32,
    this.height = 32,
    this.layerCount = 2,
    this.hasAnimation = false,
    this.tags = const [],
    this.isFavorite = false,
    this.isBuiltIn = true,
    required this.createdDate,
    required this.modifiedDate,
    this.previewPngBase64,
  });

  final String id;
  final String name;
  final String description;
  final TemplateCategory category;
  final String author;
  final String version;
  final int width;
  final int height;
  final int layerCount;
  final bool hasAnimation;
  final List<String> tags;
  final bool isFavorite;
  final bool isBuiltIn;
  final DateTime createdDate;
  final DateTime modifiedDate;
  final String? previewPngBase64;

  /// Resolution string e.g. `32 × 32`.
  String get resolutionString => '$width × $height';

  /// Creates a copy of [TemplateMetadata] with updated fields.
  TemplateMetadata copyWith({
    String? id,
    String? name,
    String? description,
    TemplateCategory? category,
    String? author,
    String? version,
    int? width,
    int? height,
    int? layerCount,
    bool? hasAnimation,
    List<String>? tags,
    bool? isFavorite,
    bool? isBuiltIn,
    DateTime? createdDate,
    DateTime? modifiedDate,
    String? previewPngBase64,
  }) =>
      TemplateMetadata(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        category: category ?? this.category,
        author: author ?? this.author,
        version: version ?? this.version,
        width: width ?? this.width,
        height: height ?? this.height,
        layerCount: layerCount ?? this.layerCount,
        hasAnimation: hasAnimation ?? this.hasAnimation,
        tags: tags ?? this.tags,
        isFavorite: isFavorite ?? this.isFavorite,
        isBuiltIn: isBuiltIn ?? this.isBuiltIn,
        createdDate: createdDate ?? this.createdDate,
        modifiedDate: modifiedDate ?? this.modifiedDate,
        previewPngBase64: previewPngBase64 ?? this.previewPngBase64,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        category,
        author,
        version,
        width,
        height,
        layerCount,
        hasAnimation,
        tags,
        isFavorite,
        isBuiltIn,
        createdDate,
        modifiedDate,
        previewPngBase64,
      ];
}
