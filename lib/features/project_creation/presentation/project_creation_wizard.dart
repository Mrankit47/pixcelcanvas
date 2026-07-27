import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/app_shell/controllers/workspace_manager.dart';
import 'package:pixelcanvas/features/project_creation/controllers/template_manager.dart';
import 'package:pixelcanvas/features/project_creation/models/canvas_preset.dart';
import 'package:pixelcanvas/features/project_creation/models/palette_preset.dart';
import 'package:pixelcanvas/features/project_creation/models/template_preset.dart';
import 'package:pixelcanvas/features/project_creation/presentation/template_library_view.dart';
import 'package:pixelcanvas/features/project_dashboard/controllers/project_manager.dart';

/// 5-Step Project Creation Wizard Dialog per Blueprint §7.3.
class ProjectCreationWizard extends StatefulWidget {
  /// Creates a [ProjectCreationWizard].
  const ProjectCreationWizard({
    super.key,
    required this.projectManager,
    required this.workspaceManager,
    required this.templateManager,
  });

  final ProjectManager projectManager;
  final WorkspaceManager workspaceManager;
  final TemplateManager templateManager;

  @override
  State<ProjectCreationWizard> createState() => _ProjectCreationWizardState();
}

class _ProjectCreationWizardState extends State<ProjectCreationWizard> {
  int _currentStep = 1;

  // Form State
  String _projectName = 'New Project';
  int _startType = 0; // 0: Blank, 1: Template, 2: Import
  TemplatePreset? _selectedTemplate;

  int _width = 32;
  int _height = 32;
  String _bgColorHex = '#00000000';

  bool _showGrid = true;
  int _gridSize = 16;
  PalettePreset _selectedPalette = PalettePreset.defaults[0];

  bool _enableAnimation = false;
  int _defaultFps = 12;
  int _initialFrames = 4;

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
        height: 560,
        child: Column(
          children: [
            // Header Progress Stepper Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              color: const Color(0xFF181825),
              child: Row(
                children: [
                  const Icon(Icons.auto_awesome_rounded, color: Color(0xFF6C5CE7)),
                  const SizedBox(width: 8),
                  Text(
                    'Project Creation Wizard — Step $_currentStep of 5',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close_rounded, color: Colors.white38),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),

            // Main Step Content Body
            Expanded(child: _buildStepBody()),

            // Footer Navigation Controls
            Container(
              padding: const EdgeInsets.all(16),
              color: const Color(0xFF181825),
              child: Row(
                children: [
                  if (_currentStep > 1)
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(foregroundColor: Colors.white70),
                      onPressed: () => setState(() => _currentStep--),
                      child: const Text('Back'),
                    ),
                  const Spacer(),
                  if (_currentStep < 5)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6C5CE7)),
                      onPressed: () => setState(() => _currentStep++),
                      child: const Text('Next Step', style: TextStyle(color: Colors.white)),
                    ),
                  if (_currentStep == 5)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6C5CE7)),
                      onPressed: _createProject,
                      child: const Text('Create Project', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepBody() {
    switch (_currentStep) {
      case 1:
        return _buildStep1StartType();
      case 2:
        return _buildStep2CanvasSettings();
      case 3:
        return _buildStep3EditorDefaults();
      case 4:
        return _buildStep4AnimationOptions();
      case 5:
        return _buildStep5Review();
      default:
        return const SizedBox();
    }
  }

  // Step 1: Start Type Choice
  Widget _buildStep1StartType() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Step 1: Choose Starting Point', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildOptionTile(0, 'Blank Project', Icons.crop_free_rounded, 'Start with a clean empty canvas.')),
              const SizedBox(width: 16),
              Expanded(child: _buildOptionTile(1, 'Template Library', Icons.grid_view_rounded, 'Choose from built-in sprite templates.')),
            ],
          ),
          const SizedBox(height: 16),
          if (_startType == 1)
            Expanded(
              child: TemplateLibraryView(
                templateManager: widget.templateManager,
                onSelectTemplate: (tmpl) {
                  setState(() {
                    _selectedTemplate = tmpl;
                    _width = tmpl.metadata.width;
                    _height = tmpl.metadata.height;
                    _selectedPalette = tmpl.palette;
                    _enableAnimation = tmpl.enableAnimation;
                  });
                },
              ),
            ),
        ],
      ),
    );
  }

  // Step 2: Canvas Settings
  Widget _buildStep2CanvasSettings() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Step 2: Canvas Resolution & Background', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          const Text('Presets:', style: TextStyle(color: Colors.white70, fontSize: 12)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: CanvasPreset.defaults.map((p) {
              return ChoiceChip(
                label: Text(p.name, style: TextStyle(color: _width == p.width ? Colors.white : Colors.white60, fontSize: 11)),
                selected: _width == p.width && _height == p.height,
                selectedColor: const Color(0xFF6C5CE7),
                backgroundColor: const Color(0xFF181825),
                onSelected: (selected) {
                  if (selected) {
                    setState(() {
                      _width = p.width;
                      _height = p.height;
                    });
                  }
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: TextEditingController(text: '$_width'),
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(labelText: 'Width (px)', labelStyle: TextStyle(color: Colors.white60), filled: true, fillColor: Color(0xFF181825)),
                  onChanged: (val) => _width = int.tryParse(val) ?? 32,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextField(
                  controller: TextEditingController(text: '$_height'),
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(labelText: 'Height (px)', labelStyle: TextStyle(color: Colors.white60), filled: true, fillColor: Color(0xFF181825)),
                  onChanged: (val) => _height = int.tryParse(val) ?? 32,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Step 3: Editor Defaults
  Widget _buildStep3EditorDefaults() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Step 3: Editor Defaults & Palette', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          SwitchListTile(
            title: const Text('Show Grid Overlay by Default', style: TextStyle(color: Colors.white, fontSize: 13)),
            value: _showGrid,
            onChanged: (val) => setState(() => _showGrid = val),
          ),
          const SizedBox(height: 16),
          const Text('Select Palette Preset:', style: TextStyle(color: Colors.white70, fontSize: 12)),
          const SizedBox(height: 8),
          ...PalettePreset.defaults.map((pal) {
            final isSelected = _selectedPalette == pal;
            return RadioListTile<PalettePreset>(
              title: Text(pal.name, style: TextStyle(color: isSelected ? Colors.white : Colors.white70, fontSize: 13)),
              subtitle: Text(pal.description, style: const TextStyle(color: Colors.white38, fontSize: 11)),
              value: pal,
              groupValue: _selectedPalette,
              onChanged: (val) => setState(() => _selectedPalette = val!),
            );
          }),
        ],
      ),
    );
  }

  // Step 4: Animation Options
  Widget _buildStep4AnimationOptions() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Step 4: Animation Configurations', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          SwitchListTile(
            title: const Text('Enable Animation Timeline', style: TextStyle(color: Colors.white, fontSize: 13)),
            subtitle: const Text('Pre-configures timeline playback and onion skinning.', style: TextStyle(color: Colors.white38, fontSize: 11)),
            value: _enableAnimation,
            onChanged: (val) => setState(() => _enableAnimation = val),
          ),
        ],
      ),
    );
  }

  // Step 5: Review & Summary
  Widget _buildStep5Review() {
    final bytesEst = (_width * _height * 4) / 1024;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Step 5: Review Project Configuration', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF181825),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                _buildSummaryRow('Canvas Resolution:', '$_width × $_height pixels'),
                const Divider(color: Color(0xFF313244)),
                _buildSummaryRow('Palette:', _selectedPalette.name),
                const Divider(color: Color(0xFF313244)),
                _buildSummaryRow('Animation Support:', _enableAnimation ? 'Enabled' : 'Disabled'),
                const Divider(color: Color(0xFF313244)),
                _buildSummaryRow('Estimated RAM Memory:', '${bytesEst.toStringAsFixed(1)} KB'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionTile(int type, String title, IconData icon, String subtitle) {
    final isSelected = _startType == type;
    return GestureDetector(
      onTap: () => setState(() => _startType = type),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2A2A3D) : const Color(0xFF181825),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: isSelected ? const Color(0xFF6C5CE7) : Colors.transparent),
        ),
        child: Column(
          children: [
            Icon(icon, size: 32, color: isSelected ? const Color(0xFF6C5CE7) : Colors.white60),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
            const SizedBox(height: 4),
            Text(subtitle, style: const TextStyle(color: Colors.white38, fontSize: 10), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      children: [
        Text(label, style: const TextStyle(color: Colors.white60, fontSize: 12)),
        const Spacer(),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
      ],
    );
  }

  void _createProject() {
    widget.projectManager.createProject(
      name: _projectName,
      width: _width,
      height: _height,
      workspaceManager: widget.workspaceManager,
      backgroundColorHex: _bgColorHex,
    );
    Navigator.of(context).pop();
  }
}
