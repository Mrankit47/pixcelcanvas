import 'package:equatable/equatable.dart';

/// Recent project entry descriptor for dashboard and workspace manager.
class RecentProject extends Equatable {
  /// Creates a [RecentProject].
  const RecentProject({
    required this.id,
    required this.name,
    required this.filePath,
    required this.lastOpened,
    this.width = 32,
    this.height = 32,
  });

  /// Unique project identifier.
  final String id;

  /// Project display name.
  final String name;

  /// Absolute file system path (.pixelcanvas).
  final String filePath;

  /// Last opened timestamp.
  final DateTime lastOpened;

  /// Width in pixels.
  final int width;

  /// Height in pixels.
  final int height;

  /// Converts to JSON map.
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'filePath': filePath,
        'lastOpened': lastOpened.toIso8601String(),
        'width': width,
        'height': height,
      };

  /// Factory constructor from JSON map.
  factory RecentProject.fromJson(Map<String, dynamic> json) => RecentProject(
        id: json['id'] ?? '',
        name: json['name'] ?? 'Untitled',
        filePath: json['filePath'] ?? '',
        lastOpened: DateTime.parse(json['lastOpened'] ?? DateTime.now().toIso8601String()),
        width: json['width'] ?? 32,
        height: json['height'] ?? 32,
      );

  @override
  List<Object?> get props => [id, name, filePath, lastOpened, width, height];
}
