/// Built-in and user template categories per Blueprint §7.3.
enum TemplateCategory {
  icons,
  sprites,
  tilesets,
  uiAssets,
  gameObjects,
  characters,
  animations,
  environment,
  socialMedia,
  pixelPortraits,
  custom,
}

/// Helper extension on [TemplateCategory].
extension TemplateCategoryExtension on TemplateCategory {
  /// User-facing display label.
  String get label {
    switch (this) {
      case TemplateCategory.icons:
        return 'Icons';
      case TemplateCategory.sprites:
        return 'Sprites';
      case TemplateCategory.tilesets:
        return 'Tilesets';
      case TemplateCategory.uiAssets:
        return 'UI Assets';
      case TemplateCategory.gameObjects:
        return 'Game Objects';
      case TemplateCategory.characters:
        return 'Characters';
      case TemplateCategory.animations:
        return 'Animations';
      case TemplateCategory.environment:
        return 'Environment';
      case TemplateCategory.socialMedia:
        return 'Social Media';
      case TemplateCategory.pixelPortraits:
        return 'Pixel Portraits';
      case TemplateCategory.custom:
        return 'Custom';
    }
  }
}
