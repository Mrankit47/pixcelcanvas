import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/app_shell/models/project_workspace.dart';
import 'package:pixelcanvas/features/editor/engine/canvas_engine.dart';

/// Workspace Manager orchestrating multiple open project tabs per Blueprint §6.1.
///
/// **Responsibilities**: Opening workspaces, closing workspaces, switching active tabs, reordering tabs, session restoration.
class WorkspaceManager extends ChangeNotifier {
  /// Creates a [WorkspaceManager].
  WorkspaceManager() {
    // Open default initial workspace
    openNewWorkspace('Untitled.pixelcanvas');
  }

  /// List of currently open project workspace tabs.
  final List<ProjectWorkspace> _workspaces = [];

  /// List getter.
  List<ProjectWorkspace> get workspaces => List.unmodifiable(_workspaces);

  /// Currently active workspace index.
  int _activeWorkspaceIndex = 0;

  /// Active workspace index getter.
  int get activeWorkspaceIndex => _activeWorkspaceIndex;

  /// Currently active [ProjectWorkspace], or null if empty.
  ProjectWorkspace? get activeWorkspace {
    if (_workspaces.isEmpty ||
        _activeWorkspaceIndex < 0 ||
        _activeWorkspaceIndex >= _workspaces.length) {
      return null;
    }
    return _workspaces[_activeWorkspaceIndex];
  }

  /// Opens a new empty project workspace tab.
  ProjectWorkspace openNewWorkspace([String? name, int width = 32, int height = 32]) {
    final index = _workspaces.length;
    final workspaceName = name ?? 'Untitled_${index + 1}.pixelcanvas';

    final workspace = ProjectWorkspace(
      id: 'ws_${DateTime.now().millisecondsSinceEpoch}',
      name: workspaceName,
      engine: CanvasEngine(width: width, height: height),
    );

    _workspaces.add(workspace);
    _activeWorkspaceIndex = _workspaces.length - 1;
    notifyListeners();
    return workspace;
  }

  /// Opens an existing project workspace tab.
  void openWorkspace(ProjectWorkspace workspace) {
    _workspaces.add(workspace);
    _activeWorkspaceIndex = _workspaces.length - 1;
    notifyListeners();
  }

  /// Switches active workspace tab to [index].
  void switchWorkspace(int index) {
    if (index >= 0 && index < _workspaces.length) {
      _activeWorkspaceIndex = index;
      notifyListeners();
    }
  }

  /// Closes workspace tab at [index].
  bool closeWorkspace(int index) {
    if (index < 0 || index >= _workspaces.length) return false;

    _workspaces.removeAt(index);
    if (_activeWorkspaceIndex >= _workspaces.length) {
      _activeWorkspaceIndex = (_workspaces.length - 1).clamp(0, 4096);
    }

    if (_workspaces.isEmpty) {
      openNewWorkspace();
    }

    notifyListeners();
    return true;
  }

  /// Reorders workspace tab from [oldIndex] to [newIndex].
  void reorderTabs(int oldIndex, int newIndex) {
    if (oldIndex < 0 || oldIndex >= _workspaces.length) return;
    if (newIndex < 0 || newIndex >= _workspaces.length) return;

    final tab = _workspaces.removeAt(oldIndex);
    _workspaces.insert(newIndex, tab);
    _activeWorkspaceIndex = newIndex;
    notifyListeners();
  }

  /// Sets dirty unsaved changes indicator flag for active workspace.
  void markActiveWorkspaceDirty(bool isDirty) {
    final cur = activeWorkspace;
    if (cur != null) {
      _workspaces[_activeWorkspaceIndex] = cur.copyWith(isDirty: isDirty);
      notifyListeners();
    }
  }
}
