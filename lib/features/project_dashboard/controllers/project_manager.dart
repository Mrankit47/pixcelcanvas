import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/app_shell/controllers/workspace_manager.dart';
import 'package:pixelcanvas/features/project_dashboard/models/project_filter_options.dart';
import 'package:pixelcanvas/features/project_dashboard/models/project_index.dart';
import 'package:pixelcanvas/features/project_dashboard/models/project_metadata.dart';
import 'package:pixelcanvas/features/project_dashboard/services/project_search_engine.dart';
import 'package:pixelcanvas/features/project_dashboard/services/thumbnail_cache.dart';

/// Central controller managing project CRUD lifecycle per Blueprint §7.1.
class ProjectManager extends ChangeNotifier {
  /// Master index catalog.
  final ProjectIndex index = ProjectIndex();

  /// Active filter and sort options.
  ProjectFilterOptions filterOptions = const ProjectFilterOptions();

  /// Filtered and sorted project entries list for display.
  List<ProjectMetadata> get displayedProjects =>
      ProjectSearchEngine.filterAndSort(index.entries, filterOptions);

  /// Creates a new project and opens a workspace tab.
  ProjectMetadata createProject({
    required String name,
    required int width,
    required int height,
    required WorkspaceManager workspaceManager,
    String? backgroundColorHex,
    List<String> tags = const [],
  }) {
    final now = DateTime.now();
    final metadata = ProjectMetadata(
      id: 'proj_${now.millisecondsSinceEpoch}',
      name: name,
      filePath: '/projects/$name.pixelcanvas',
      width: width,
      height: height,
      createdDate: now,
      modifiedDate: now,
      lastOpened: now,
      tags: tags,
      backgroundColorHex: backgroundColorHex ?? '#00000000',
    );

    index.addOrUpdate(metadata);
    workspaceManager.openNewWorkspace('$name.pixelcanvas', width, height);
    notifyListeners();
    return metadata;
  }

  /// Opens an existing project in [workspaceManager].
  void openProject(ProjectMetadata metadata, WorkspaceManager workspaceManager) {
    final updated = metadata.copyWith(lastOpened: DateTime.now());
    index.addOrUpdate(updated);
    workspaceManager.openNewWorkspace(updated.name, updated.width, updated.height);
    notifyListeners();
  }

  /// Renames project [id] to [newName].
  void renameProject(String id, String newName) {
    final match = index.entries.firstWhere((p) => p.id == id, orElse: () => index.entries.first);
    final updated = match.copyWith(
      name: newName,
      filePath: '/projects/$newName.pixelcanvas',
      modifiedDate: DateTime.now(),
    );
    index.addOrUpdate(updated);
    notifyListeners();
  }

  /// Duplicates project [id].
  ProjectMetadata? duplicateProject(String id) {
    final match = index.entries.firstWhere((p) => p.id == id, orElse: () => index.entries.first);
    final now = DateTime.now();
    final duplicate = match.copyWith(
      id: 'proj_${now.millisecondsSinceEpoch}',
      name: '${match.name}_Copy',
      filePath: '/projects/${match.name}_Copy.pixelcanvas',
      createdDate: now,
      modifiedDate: now,
      lastOpened: now,
    );

    index.addOrUpdate(duplicate);
    notifyListeners();
    return duplicate;
  }

  /// Toggles favorite status for project [id].
  void toggleFavorite(String id) {
    final match = index.entries.firstWhere((p) => p.id == id, orElse: () => index.entries.first);
    index.addOrUpdate(match.copyWith(isFavorite: !match.isFavorite));
    notifyListeners();
  }

  /// Toggles pin status for project [id].
  void togglePin(String id) {
    final match = index.entries.firstWhere((p) => p.id == id, orElse: () => index.entries.first);
    index.addOrUpdate(match.copyWith(isPinned: !match.isPinned));
    notifyListeners();
  }

  /// Soft deletes (archives) project [id].
  void archiveProject(String id) {
    final match = index.entries.firstWhere((p) => p.id == id, orElse: () => index.entries.first);
    index.addOrUpdate(match.copyWith(isArchived: true));
    notifyListeners();
  }

  /// Restores archived project [id].
  void restoreProject(String id) {
    final match = index.entries.firstWhere((p) => p.id == id, orElse: () => index.entries.first);
    index.addOrUpdate(match.copyWith(isArchived: false));
    notifyListeners();
  }

  /// Permanently deletes project [id].
  void deletePermanently(String id) {
    index.remove(id);
    ThumbnailCache.invalidate(id);
    notifyListeners();
  }

  /// Updates search and filter options.
  void updateFilter(ProjectFilterOptions options) {
    filterOptions = options;
    notifyListeners();
  }
}
