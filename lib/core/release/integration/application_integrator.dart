import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/app_shell/controllers/sidebar_manager.dart';
import 'package:pixelcanvas/features/app_shell/controllers/status_bar_manager.dart';
import 'package:pixelcanvas/features/app_shell/controllers/workspace_manager.dart';

/// Main Application Integrator wiring app shell, controllers, and managers per Blueprint §9.1.
class ApplicationIntegrator extends ChangeNotifier {
  final WorkspaceManager workspaceManager = WorkspaceManager();
  final SidebarManager sidebarManager = SidebarManager();
  final StatusBarManager statusBarManager = StatusBarManager();

  bool _isInitialized = false;

  /// True if application dependencies are fully initialized.
  bool get isInitialized => _isInitialized;

  /// Initializes core managers.
  Future<void> initialize() async {
    _isInitialized = true;
    notifyListeners();
  }
}
