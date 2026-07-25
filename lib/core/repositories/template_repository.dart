import 'package:pixelcanvas/core/repositories/offline_repository.dart';

/// Template repository interface contract per Blueprint §6.2.
///
/// Purpose: Manages starter template catalog and category filtering.
/// Responsibilities: Serves built-in asset templates and caches remote community templates.
/// Future Implementation Notes: Concrete implementation `TemplateRepositoryImpl` in `features/templates/data/`.
abstract class TemplateRepository implements OfflineRepository<Map<String, dynamic>, String> {
  /// Fetches templates filtered by category slug.
  Future<List<Map<String, dynamic>>> getByCategory(String categorySlug);
}
