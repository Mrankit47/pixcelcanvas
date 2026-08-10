import 'package:flutter/material.dart';

/// Command Palette modal search overlay (`Ctrl+K` / `Cmd+K`).
class CommandPalette extends StatefulWidget {
  /// Creates a [CommandPalette].
  const CommandPalette({
    super.key,
    required this.onClose,
    required this.onNewProject,
    required this.onOpenProject,
    required this.onExport,
  });

  final VoidCallback onClose;
  final VoidCallback onNewProject;
  final VoidCallback onOpenProject;
  final VoidCallback onExport;

  @override
  State<CommandPalette> createState() => _CommandPaletteState();
}

class _CommandPaletteState extends State<CommandPalette> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final commands = [
      _CommandItem(
        icon: Icons.add_rounded,
        title: 'Create New Project',
        shortcut: 'Ctrl+N',
        action: widget.onNewProject,
      ),
      _CommandItem(
        icon: Icons.folder_open_rounded,
        title: 'Open Project File...',
        shortcut: 'Ctrl+O',
        action: widget.onOpenProject,
      ),
      _CommandItem(
        icon: Icons.file_upload_outlined,
        title: 'Export Image / Sprite Sheet',
        shortcut: 'Ctrl+E',
        action: widget.onExport,
      ),
      _CommandItem(
        icon: Icons.settings_rounded,
        title: 'Open Settings',
        shortcut: 'Ctrl+,',
        action: widget.onClose,
      ),
      _CommandItem(
        icon: Icons.help_outline_rounded,
        title: 'Open Help Center',
        shortcut: 'F1',
        action: widget.onClose,
      ),
    ];

    final filtered = commands.where((cmd) {
      return cmd.title.toLowerCase().contains(_query.toLowerCase());
    }).toList();

    return Material(
      color: Colors.black54,
      child: Center(
        child: Container(
          width: 550,
          constraints: const BoxConstraints(maxHeight: 400),
          margin: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E2E),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF313244)),
            boxShadow: [
              const BoxShadow(color: Colors.black45, blurRadius: 24, offset: Offset(0, 8)),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Search Input Field
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextField(
                  controller: _searchController,
                  autofocus: true,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'Type a command or search...',
                    hintStyle: const TextStyle(color: Colors.white38),
                    prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFF6C5CE7)),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.close_rounded, color: Colors.white38),
                      onPressed: widget.onClose,
                    ),
                    filled: true,
                    fillColor: const Color(0xFF181825),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (val) => setState(() => _query = val),
                ),
              ),

              // Filtered Commands List
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final item = filtered[index];
                    return ListTile(
                      leading: Icon(item.icon, color: const Color(0xFF89B4FA), size: 20),
                      title: Text(item.title, style: const TextStyle(color: Colors.white, fontSize: 13)),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFF313244),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(item.shortcut, style: const TextStyle(color: Colors.white60, fontSize: 10)),
                      ),
                      onTap: () {
                        widget.onClose();
                        item.action();
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CommandItem {
  const _CommandItem({
    required this.icon,
    required this.title,
    required this.shortcut,
    required this.action,
  });

  final IconData icon;
  final String title;
  final String shortcut;
  final VoidCallback action;
}
