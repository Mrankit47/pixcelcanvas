import 'package:pixelcanvas/features/project_dashboard/models/project_metadata.dart';

/// Catalog index maintaining all known project metadata entries.
class ProjectIndex {
  final List<ProjectMetadata> _entries = [];

  /// Unmodifiable list of project metadata entries.
  List<ProjectMetadata> get entries => List.unmodifiable(_entries);

  /// Active non-archived projects list.
  List<ProjectMetadata> get activeProjects =>
      _entries.where((p) => !p.isArchived).toList();

  /// Favorited projects list.
  List<ProjectMetadata> get favoriteProjects =>
      _entries.where((p) => p.isFavorite && !p.isArchived).toList();

  /// Pinned projects list.
  List<ProjectMetadata> get pinnedProjects =>
      _entries.where((p) => p.isPinned && !p.isArchived).toList();

  /// Soft-deleted archived projects list in Trash Bin.
  List<ProjectMetadata> get archivedProjects =>
      _entries.where((p) => p.isArchived).toList();

  /// Adds or updates [metadata] in index.
  void addOrUpdate(ProjectMetadata metadata) {
    final idx = _entries.indexWhere((p) => p.id == metadata.id);
    if (idx >= 0) {
      _entries[idx] = metadata;
    } else {
      _entries.insert(0, metadata);
    }
  }

  /// Removes project metadata by [id].
  void remove(String id) {
    _entries.removeWhere((p) => p.id == id);
  }

  /// Clears catalog index.
  void clear() {
    _entries.clear();
  }
}
