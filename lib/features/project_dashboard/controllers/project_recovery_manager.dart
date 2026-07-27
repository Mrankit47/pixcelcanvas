import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/project_dashboard/models/project_metadata.dart';

/// Manager handling crash recovery and session restoration.
class ProjectRecoveryManager extends ChangeNotifier {
  final List<ProjectMetadata> _recoverableProjects = [];

  /// Recoverable session projects getter.
  List<ProjectMetadata> get recoverableProjects =>
      List.unmodifiable(_recoverableProjects);

  /// True if session recovery items exist.
  bool get hasRecoverableSession => _recoverableProjects.isNotEmpty;

  /// Registers a session recovery snapshot.
  void registerRecoverySession(ProjectMetadata metadata) {
    _recoverableProjects.removeWhere((p) => p.id == metadata.id);
    _recoverableProjects.add(metadata);
    notifyListeners();
  }

  /// Clears recovery session list.
  void clearRecoverySession() {
    _recoverableProjects.clear();
    notifyListeners();
  }
}
