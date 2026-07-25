/// Registry of Isar collection names and schema descriptors per Blueprint §12.
///
/// Purpose: Centralized reference for local database collection identifiers.
/// Responsibilities: Maps entity models to Isar collection constants.
/// Future Implementation Notes: Concrete Isar `@collection` schemas will be annotated in feature data layers.
abstract final class IsarCollections {
  /// Local projects collection.
  static const String projects = 'projects';

  /// Local custom palettes collection.
  static const String palettes = 'palettes';

  /// Cached starter templates collection.
  static const String templates = 'templates';

  /// Cached user profile collection.
  static const String profile = 'profile';

  /// Offline background sync queue collection.
  static const String syncQueue = 'sync_queue';
}
