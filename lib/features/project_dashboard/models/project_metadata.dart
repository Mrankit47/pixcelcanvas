import 'package:equatable/equatable.dart';

/// Full metadata descriptor for a PixelCanvas project asset per Blueprint §7.2.
class ProjectMetadata extends Equatable {
  /// Creates a [ProjectMetadata].
  const ProjectMetadata({
    required this.id,
    required this.name,
    required this.filePath,
    this.width = 32,
    this.height = 32,
    required this.createdDate,
    required this.modifiedDate,
    required this.lastOpened,
    this.tags = const [],
    this.isFavorite = false,
    this.isArchived = false,
    this.isPinned = false,
    this.backgroundColorHex = '#00000000',
    this.previewPngBase64,
  });

  /// Unique project identifier.
  final String id;

  /// Display name.
  final String name;

  /// File path (.pixelcanvas).
  final String filePath;

  /// Width in pixels.
  final int width;

  /// Height in pixels.
  final int height;

  /// Date created.
  final DateTime createdDate;

  /// Date last modified.
  final DateTime modifiedDate;

  /// Date last opened.
  final DateTime lastOpened;

  /// Custom project tags.
  final List<String> tags;

  /// Favorited flag.
  final bool isFavorite;

  /// Archived / soft-deleted flag.
  final bool isArchived;

  /// Pinned to top flag.
  final bool isPinned;

  /// Background color hex string.
  final String backgroundColorHex;

  /// Optional base64 encoded PNG thumbnail preview.
  final String? previewPngBase64;

  /// Formatted resolution string (e.g. `32 × 32`).
  String get resolutionString => '$width × $height';

  /// Creates a copy of [ProjectMetadata] with updated fields.
  ProjectMetadata copyWith({
    String? id,
    String? name,
    String? filePath,
    int? width,
    int? height,
    DateTime? createdDate,
    DateTime? modifiedDate,
    DateTime? lastOpened,
    List<String>? tags,
    bool? isFavorite,
    bool? isArchived,
    bool? isPinned,
    String? backgroundColorHex,
    String? previewPngBase64,
  }) =>
      ProjectMetadata(
        id: id ?? this.id,
        name: name ?? this.name,
        filePath: filePath ?? this.filePath,
        width: width ?? this.width,
        height: height ?? this.height,
        createdDate: createdDate ?? this.createdDate,
        modifiedDate: modifiedDate ?? this.modifiedDate,
        lastOpened: lastOpened ?? this.lastOpened,
        tags: tags ?? this.tags,
        isFavorite: isFavorite ?? this.isFavorite,
        isArchived: isArchived ?? this.isArchived,
        isPinned: isPinned ?? this.isPinned,
        backgroundColorHex: backgroundColorHex ?? this.backgroundColorHex,
        previewPngBase64: previewPngBase64 ?? this.previewPngBase64,
      );

  /// Converts to JSON map.
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'filePath': filePath,
        'width': width,
        'height': height,
        'createdDate': createdDate.toIso8601String(),
        'modifiedDate': modifiedDate.toIso8601String(),
        'lastOpened': lastOpened.toIso8601String(),
        'tags': tags,
        'isFavorite': isFavorite,
        'isArchived': isArchived,
        'isPinned': isPinned,
        'backgroundColorHex': backgroundColorHex,
        'previewPngBase64': previewPngBase64,
      };

  /// Factory constructor from JSON map.
  factory ProjectMetadata.fromJson(Map<String, dynamic> json) => ProjectMetadata(
        id: json['id'] ?? '',
        name: json['name'] ?? 'Untitled',
        filePath: json['filePath'] ?? '',
        width: json['width'] ?? 32,
        height: json['height'] ?? 32,
        createdDate: DateTime.parse(json['createdDate'] ?? DateTime.now().toIso8601String()),
        modifiedDate: DateTime.parse(json['modifiedDate'] ?? DateTime.now().toIso8601String()),
        lastOpened: DateTime.parse(json['lastOpened'] ?? DateTime.now().toIso8601String()),
        tags: (json['tags'] as List?)?.cast<String>() ?? const [],
        isFavorite: json['isFavorite'] ?? false,
        isArchived: json['isArchived'] ?? false,
        isPinned: json['isPinned'] ?? false,
        backgroundColorHex: json['backgroundColorHex'] ?? '#00000000',
        previewPngBase64: json['previewPngBase64'],
      );

  @override
  List<Object?> get props => [
        id,
        name,
        filePath,
        width,
        height,
        createdDate,
        modifiedDate,
        lastOpened,
        tags,
        isFavorite,
        isArchived,
        isPinned,
        backgroundColorHex,
        previewPngBase64,
      ];
}
