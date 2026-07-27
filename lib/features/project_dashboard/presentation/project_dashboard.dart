import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/app_shell/controllers/workspace_manager.dart';
import 'package:pixelcanvas/features/project_dashboard/controllers/project_manager.dart';
import 'package:pixelcanvas/features/project_dashboard/models/project_filter_options.dart';
import 'package:pixelcanvas/features/project_dashboard/models/project_metadata.dart';
import 'package:pixelcanvas/features/project_dashboard/presentation/widgets/create_project_dialog.dart';
import 'package:pixelcanvas/features/project_dashboard/presentation/widgets/project_card.dart';

/// Main Project Dashboard UI view per Blueprint §7.1.
class ProjectDashboard extends StatefulWidget {
  /// Creates a [ProjectDashboard].
  const ProjectDashboard({
    super.key,
    required this.projectManager,
    required this.workspaceManager,
  });

  final ProjectManager projectManager;
  final WorkspaceManager workspaceManager;

  @override
  State<ProjectDashboard> createState() => _ProjectDashboardState();
}

class _ProjectDashboardState extends State<ProjectDashboard> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.projectManager.addListener(_onManagerChanged);
  }

  @override
  void dispose() {
    widget.projectManager.removeListener(_onManagerChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onManagerChanged() {
    if (mounted) setState(() {});
  }

  Future<void> _showCreateDialog() async {
    final result = await showDialog<CreateProjectParams>(
      context: context,
      builder: (context) => const CreateProjectDialog(),
    );

    if (result != null) {
      widget.projectManager.createProject(
        name: result.name,
        width: result.width,
        height: result.height,
        workspaceManager: widget.workspaceManager,
        backgroundColorHex: result.backgroundColorHex,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final projects = widget.projectManager.displayedProjects;

    return Container(
      color: const Color(0xFF11111B),
      child: Column(
        children: [
          // Dashboard Header & Quick Actions Bar
          Container(
            padding: const EdgeInsets.all(20),
            color: const Color(0xFF181825),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Project Dashboard',
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6C5CE7),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      icon: const Icon(Icons.add_rounded, color: Colors.white, size: 18),
                      label: const Text('New Project', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      onPressed: _showCreateDialog,
                    ),
                    const SizedBox(width: 12),

                    // Search & Filter Input
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        style: const TextStyle(color: Colors.white, fontSize: 13),
                        decoration: InputDecoration(
                          hintText: 'Search projects by name, tags, resolution...',
                          hintStyle: const TextStyle(color: Colors.white38),
                          prefixIcon: const Icon(Icons.search_rounded, color: Colors.white38, size: 18),
                          filled: true,
                          fillColor: const Color(0xFF1E1E2E),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                          contentPadding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                        onChanged: (val) {
                          widget.projectManager.updateFilter(
                            widget.projectManager.filterOptions.copyWith(searchQuery: val),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Category Filter Selector
                    DropdownButton<ProjectFilterCategory>(
                      value: widget.projectManager.filterOptions.category,
                      dropdownColor: const Color(0xFF1E1E2E),
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                      underline: const SizedBox(),
                      items: const [
                        DropdownMenuItem(value: ProjectFilterCategory.all, child: Text('All Projects')),
                        DropdownMenuItem(value: ProjectFilterCategory.favorites, child: Text('Favorites')),
                        DropdownMenuItem(value: ProjectFilterCategory.archived, child: Text('Trash Bin')),
                      ],
                      onChanged: (cat) {
                        if (cat != null) {
                          widget.projectManager.updateFilter(
                            widget.projectManager.filterOptions.copyWith(category: cat),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Main Projects Grid Area
          Expanded(
            child: projects.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.folder_open_rounded, size: 48, color: Colors.white24),
                        const SizedBox(height: 12),
                        const Text('No projects found', style: TextStyle(color: Colors.white60, fontSize: 14)),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6C5CE7)),
                          onPressed: _showCreateDialog,
                          child: const Text('Create First Project', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(20),
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 240,
                      childAspectRatio: 0.85,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: projects.length,
                    itemBuilder: (context, index) {
                      final item = projects[index];
                      return ProjectCard(
                        metadata: item,
                        onOpen: () => widget.projectManager.openProject(item, widget.workspaceManager),
                        onRename: () => _showRenameDialog(item),
                        onDuplicate: () => widget.projectManager.duplicateProject(item.id),
                        onToggleFavorite: () => widget.projectManager.toggleFavorite(item.id),
                        onTogglePin: () => widget.projectManager.togglePin(item.id),
                        onArchive: () => widget.projectManager.archiveProject(item.id),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _showRenameDialog(ProjectMetadata project) {
    final controller = TextEditingController(text: project.name);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E2E),
        title: const Text('Rename Project', style: TextStyle(color: Colors.white, fontSize: 15)),
        content: TextField(
          controller: controller,
          autofocus: true,
          style: const TextStyle(color: Colors.white, fontSize: 13),
          decoration: const InputDecoration(filled: true, fillColor: Color(0xFF181825)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel', style: TextStyle(color: Colors.white60)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6C5CE7)),
            onPressed: () {
              final newName = controller.text.trim();
              if (newName.isNotEmpty) {
                widget.projectManager.renameProject(project.id, newName);
              }
              Navigator.of(context).pop();
            },
            child: const Text('Rename', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
