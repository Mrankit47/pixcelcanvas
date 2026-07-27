import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/settings/controllers/keyboard_shortcut_manager.dart';
import 'package:pixelcanvas/features/settings/controllers/preferences_manager.dart';
import 'package:pixelcanvas/features/settings/controllers/settings_manager.dart';
import 'package:pixelcanvas/features/settings/presentation/keyboard_shortcuts_view.dart';

/// Modal dialog for application settings & preferences per Blueprint §7.4.
class SettingsDialog extends StatefulWidget {
  /// Creates a [SettingsDialog].
  const SettingsDialog({
    super.key,
    required this.settingsManager,
    required this.preferencesManager,
    required this.shortcutManager,
  });

  final SettingsManager settingsManager;
  final PreferencesManager preferencesManager;
  final KeyboardShortcutManager shortcutManager;

  @override
  State<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  int _activeTab = 0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF11111B),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFF313244)),
      ),
      child: SizedBox(
        width: 750,
        height: 520,
        child: Row(
          children: [
            // Left Navigation Sidebar
            Container(
              width: 180,
              decoration: const BoxDecoration(
                color: Color(0xFF181825),
                borderRadius: BorderRadius.horizontal(left: Radius.circular(12)),
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(Icons.settings_rounded, color: Color(0xFF6C5CE7), size: 18),
                        SizedBox(width: 8),
                        Text('Settings', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                      ],
                    ),
                  ),
                  _buildNavTile(0, 'General', Icons.tune_rounded),
                  _buildNavTile(1, 'Appearance', Icons.palette_rounded),
                  _buildNavTile(2, 'Editor Defaults', Icons.border_color_rounded),
                  _buildNavTile(3, 'Performance', Icons.speed_rounded),
                  _buildNavTile(4, 'Autosave', Icons.backup_rounded),
                  _buildNavTile(5, 'Shortcuts', Icons.keyboard_rounded),
                ],
              ),
            ),

            // Right Panel Content
            Expanded(
              child: Column(
                children: [
                  Expanded(child: _buildActiveTabContent()),
                  Container(
                    padding: const EdgeInsets.all(12),
                    color: const Color(0xFF181825),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6C5CE7)),
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Close', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavTile(int index, String title, IconData icon) {
    final isSelected = _activeTab == index;
    return ListTile(
      dense: true,
      selected: isSelected,
      selectedTileColor: const Color(0xFF2A2A3D),
      leading: Icon(icon, size: 16, color: isSelected ? const Color(0xFF6C5CE7) : Colors.white60),
      title: Text(title, style: TextStyle(color: isSelected ? Colors.white : Colors.white70, fontSize: 12)),
      onTap: () => setState(() => _activeTab = index),
    );
  }

  Widget _buildActiveTabContent() {
    switch (_activeTab) {
      case 0:
        return _buildGeneralTab();
      case 1:
        return _buildAppearanceTab();
      case 2:
        return _buildEditorTab();
      case 3:
        return _buildPerformanceTab();
      case 4:
        return _buildAutosaveTab();
      case 5:
        return KeyboardShortcutsView(shortcutManager: widget.shortcutManager);
      default:
        return const SizedBox();
    }
  }

  Widget _buildGeneralTab() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text('General Settings', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        SwitchListTile(
          title: const Text('Confirm Before Exiting', style: TextStyle(color: Colors.white, fontSize: 13)),
          value: widget.settingsManager.general.confirmBeforeExit,
          onChanged: (val) {
            widget.settingsManager.updateGeneral(
              widget.settingsManager.general.copyWith(confirmBeforeExit: val),
            );
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildAppearanceTab() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text('Appearance Preferences', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        SwitchListTile(
          title: const Text('Enable Smooth Animations', style: TextStyle(color: Colors.white, fontSize: 13)),
          value: widget.settingsManager.appearance.enableAnimations,
          onChanged: (val) {
            widget.settingsManager.updateAppearance(
              widget.settingsManager.appearance.copyWith(enableAnimations: val),
            );
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildEditorTab() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text('Editor Defaults', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        SwitchListTile(
          title: const Text('Show Grid by Default', style: TextStyle(color: Colors.white, fontSize: 13)),
          value: widget.settingsManager.editor.showGrid,
          onChanged: (val) {
            widget.settingsManager.updateEditor(
              widget.settingsManager.editor.copyWith(showGrid: val),
            );
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildPerformanceTab() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text('Performance Limits', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        SwitchListTile(
          title: const Text('Enable Hardware Acceleration Placeholder', style: TextStyle(color: Colors.white, fontSize: 13)),
          value: widget.settingsManager.performance.enableHardwareAcceleration,
          onChanged: (val) {
            widget.settingsManager.updatePerformance(
              widget.settingsManager.performance.copyWith(enableHardwareAcceleration: val),
            );
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildAutosaveTab() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text('Autosave & Backup', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        SwitchListTile(
          title: const Text('Enable Autosave', style: TextStyle(color: Colors.white, fontSize: 13)),
          value: widget.settingsManager.autosave.enableAutosave,
          onChanged: (val) {
            widget.settingsManager.updateAutosave(
              widget.settingsManager.autosave.copyWith(enableAutosave: val),
            );
            setState(() {});
          },
        ),
      ],
    );
  }
}
