/// API endpoints, table identifiers, and cloud storage bucket names for Supabase backend.
///
/// Derived directly from Blueprint §14.
abstract final class ApiConstants {
  /// Supabase project URL (loaded from environment or secure config).
  static const String supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://placeholder.supabase.co',
  );

  /// Supabase anon key (loaded from environment or secure config).
  static const String supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: 'placeholder_key',
  );

  // ── Database Table Identifiers ──
  static const String tableProfiles = 'profiles';
  static const String tableProjects = 'projects';
  static const String tablePublishedArtworks = 'published_artworks';
  static const String tableLikes = 'likes';
  static const String tableNotifications = 'notifications';
  static const String tableTemplates = 'templates';
  static const String tableTemplateCategories = 'template_categories';

  // ── Storage Bucket Identifiers ──
  static const String bucketAvatars = 'avatars';
  static const String bucketGallery = 'gallery';
  static const String bucketGalleryThumbnails = 'gallery-thumbnails';
  static const String bucketTemplates = 'templates';
}
