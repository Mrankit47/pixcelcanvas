import 'package:pixelcanvas/core/domain/entity.dart';
import 'package:pixelcanvas/core/domain/value_objects/domain_values.dart';
import 'package:pixelcanvas/core/domain/value_objects/identifiers.dart';

/// Template Domain Entity per Blueprint §6.1.
///
/// **Purpose**: Starter template preset for quick project initialization.
class Template extends Entity<TemplateId> {
  /// Creates a [Template] domain entity.
  const Template({
    required TemplateId id,
    required this.name,
    required this.category,
    required this.size,
    required this.difficulty,
    this.description = '',
    this.badgeText,
    this.isFavorite = false,
  }) : super(id);

  /// Template title.
  final String name;

  /// Category label.
  final String category;

  /// Canvas dimensions.
  final CanvasSize size;

  /// Difficulty level.
  final String difficulty;

  /// Description text.
  final String description;

  /// Optional badge text.
  final String? badgeText;

  /// Favorite status.
  final bool isFavorite;

  @override
  List<Object?> get props => [
        id,
        name,
        category,
        size,
        difficulty,
        description,
        badgeText,
        isFavorite,
      ];
}
