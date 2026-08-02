/// Local Data Model for Template Entity.
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

  /// Unique UUID index.
  String uuid;

  /// Template title.
  String name;

  /// Category index.
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
