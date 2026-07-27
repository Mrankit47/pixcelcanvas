import 'package:isar/isar.dart';
import 'package:pixelcanvas/core/database/isar_id_generator.dart';


/// Isar Local NoSQL Collection for Template Entity per Blueprint §6.2.
@collection
class TemplateModel {
  /// Creates a [TemplateModel].
  TemplateModel({
    this.uuid = '',
    this.name = '',
    this.category = '',
    this.width = 32,
    this.height = 32,
    this.difficulty = '',
    this.description = '',
    this.badgeText,
    this.isFavorite = false,
  });

  /// Isar primary key.
  Id get id => fastHash(uuid);

  /// Unique UUID index.
  @Index(unique: true, replace: true)
  String uuid;

  /// Template title.
  String name;

  /// Category index.
  @Index()
  String category;

  /// Width pixels.
  int width;

  /// Height pixels.
  int height;

  /// Difficulty level.
  String difficulty;

  /// Description.
  String description;

  /// Badge text.
  String? badgeText;

  /// Favorite flag.
  bool isFavorite;
}
