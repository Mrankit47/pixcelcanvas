import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/project_dashboard/models/project_metadata.dart';

/// Manager coordinating soft-deleted archived projects in Trash Bin.
class ArchivedProjectsManager extends ChangeNotifier {
  final List<ProjectMetadata> _archived = [];

  /// Archived projects list getter.
  List<ProjectMetadata> get archived => List<ProjectMetadata>.from(_archived);

  /// Archives [project] (soft delete).
  void archive(ProjectMetadata project) {
    _archived.removeWhere((p) => p.id == project.id);
    _archived.insert(0, project.copyWith(isArchived: true));
    notifyListeners();
  }

  /// Restores [project] from archive.
  void restore(ProjectMetadata project) {
    _archived.removeWhere((p) => p.id == project.id);
    notifyListeners();
  }

  /// Permanently deletes [projectId] from trash bin.
  void deletePermanently(String projectId) {
    _archived.removeWhere((p) => p.id == projectId);
    notifyListeners();
  }

  /// Clears trash bin.
  void emptyTrash() {
    _archived.clear();
    notifyListeners();
  }
}
