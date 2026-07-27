import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/app_shell/models/recent_project.dart';

/// Manager maintaining recent projects history.
class RecentProjectManager extends ChangeNotifier {
  final List<RecentProject> _recentProjects = [];

  /// Unmodifiable recent project entries list.
  List<RecentProject> get recentProjects => List.unmodifiable(_recentProjects);

  /// Adds or updates [project] entry in recent list.
  void addRecentProject(RecentProject project) {
    _recentProjects.removeWhere((p) => p.filePath == project.filePath);
    _recentProjects.insert(0, project);
    if (_recentProjects.length > 20) {
      _recentProjects.removeLast();
    }
    notifyListeners();
  }

  /// Removes project at [index].
  void removeRecentProject(int index) {
    if (index >= 0 && index < _recentProjects.length) {
      _recentProjects.removeAt(index);
      notifyListeners();
    }
  }

  /// Clears recent history list.
  void clearRecent() {
    _recentProjects.clear();
    notifyListeners();
  }
}
