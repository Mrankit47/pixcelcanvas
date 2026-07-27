import 'package:pixelcanvas/features/project_dashboard/models/project_filter_options.dart';
import 'package:pixelcanvas/features/project_dashboard/models/project_metadata.dart';
import 'package:pixelcanvas/features/project_dashboard/services/project_sorter.dart';

/// Search engine filtering projects by search query, category, and tags.
class ProjectSearchEngine {
  /// Filters and sorts [projects] list based on [options].
  static List<ProjectMetadata> filterAndSort(
    List<ProjectMetadata> projects,
    ProjectFilterOptions options,
  ) {
    var result = projects.where((p) {
      // 1. Filter by category
      switch (options.category) {
        case ProjectFilterCategory.all:
          if (p.isArchived) return false;
          break;
        case ProjectFilterCategory.favorites:
          if (!p.isFavorite || p.isArchived) return false;
          break;
        case ProjectFilterCategory.archived:
          if (!p.isArchived) return false;
          break;
        case ProjectFilterCategory.templates:
          if (!p.tags.contains('Template') || p.isArchived) return false;
          break;
      }

      // 2. Filter by search query
      if (options.searchQuery.isNotEmpty) {
        final q = options.searchQuery.toLowerCase();
        final matchName = p.name.toLowerCase().contains(q);
        final matchRes = p.resolutionString.contains(q);
        final matchTags = p.tags.any((t) => t.toLowerCase().contains(q));
        if (!matchName && !matchRes && !matchTags) return false;
      }

      // 3. Filter by selected tag
      if (options.selectedTag != null && options.selectedTag!.isNotEmpty) {
        if (!p.tags.contains(options.selectedTag)) return false;
      }

      return true;
    }).toList();

    // 4. Sort results
    return ProjectSorter.sort(
      result,
      mode: options.sortMode,
      ascending: options.ascending,
    );
  }
}
