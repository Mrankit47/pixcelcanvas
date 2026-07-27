import 'package:pixelcanvas/features/project_dashboard/models/project_filter_options.dart';
import 'package:pixelcanvas/features/project_dashboard/models/project_metadata.dart';

/// Service sorting project metadata lists.
class ProjectSorter {
  /// Sorts [projects] list according to [mode] and [ascending] direction.
  static List<ProjectMetadata> sort(
    List<ProjectMetadata> projects, {
    required ProjectSortMode mode,
    bool ascending = false,
  }) {
    final list = List<ProjectMetadata>.from(projects);

    list.sort((a, b) {
      int result;
      switch (mode) {
        case ProjectSortMode.name:
          result = a.name.toLowerCase().compareTo(b.name.toLowerCase());
          break;
        case ProjectSortMode.modifiedDate:
          result = a.modifiedDate.compareTo(b.modifiedDate);
          break;
        case ProjectSortMode.createdDate:
          result = a.createdDate.compareTo(b.createdDate);
          break;
        case ProjectSortMode.canvasSize:
          result = (a.width * a.height).compareTo(b.width * b.height);
          break;
        case ProjectSortMode.lastOpened:
          result = a.lastOpened.compareTo(b.lastOpened);
          break;
      }
      return ascending ? result : -result;
    });

    return list;
  }
}
