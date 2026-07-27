import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/help/controllers/help_center_manager.dart';
import 'package:pixelcanvas/features/help/controllers/tutorial_manager.dart';

/// Searchable Help Center modal dialog per Blueprint §7.5.
class HelpCenterDialog extends StatefulWidget {
  /// Creates a [HelpCenterDialog].
  const HelpCenterDialog({
    super.key,
    required this.helpCenterManager,
    required this.tutorialManager,
  });

  final HelpCenterManager helpCenterManager;
  final TutorialManager tutorialManager;

  @override
  State<HelpCenterDialog> createState() => _HelpCenterDialogState();
}

class _HelpCenterDialogState extends State<HelpCenterDialog> {
  int _activeTab = 0;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF11111B),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFF313244)),
      ),
      child: SizedBox(
        width: 780,
        height: 540,
        child: Column(
          children: [
            // Top Bar & Search Input
            Container(
              padding: const EdgeInsets.all(16),
              color: const Color(0xFF181825),
              child: Row(
                children: [
                  const Icon(Icons.help_outline_rounded, color: Color(0xFF6C5CE7)),
                  const SizedBox(width: 8),
                  const Text('Help Center & Documentation', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(width: 24),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                      decoration: InputDecoration(
                        hintText: 'Search documentation, FAQs, commands...',
                        hintStyle: const TextStyle(color: Colors.white38),
                        prefixIcon: const Icon(Icons.search_rounded, color: Colors.white38, size: 18),
                        filled: true,
                        fillColor: const Color(0xFF1E1E2E),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide.none),
                        contentPadding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded, color: Colors.white38),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),

            // Tab Bar Header
            Container(
              color: const Color(0xFF1E1E2E),
              child: Row(
                children: [
                  _buildTab(0, 'Documentation'),
                  _buildTab(1, 'Tutorials'),
                  _buildTab(2, 'FAQs'),
                  _buildTab(3, 'Command Reference'),
                ],
              ),
            ),

            // Main Tab View Body
            Expanded(child: _buildTabBody()),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(int index, String label) {
    final isSelected = _activeTab == index;
    return GestureDetector(
      onTap: () => setState(() => _activeTab = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: isSelected ? const Color(0xFF6C5CE7) : Colors.transparent, width: 2),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white60,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildTabBody() {
    switch (_activeTab) {
      case 0:
        return _buildDocumentationTab();
      case 1:
        return _buildTutorialsTab();
      case 2:
        return _buildFaqsTab();
      case 3:
        return _buildCommandsTab();
      default:
        return const SizedBox();
    }
  }

  Widget _buildDocumentationTab() {
    final articles = widget.helpCenterManager.articles;
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: articles.length,
      separatorBuilder: (context, index) => const Divider(color: Color(0xFF2A2A3D)),
      itemBuilder: (context, index) {
        final item = articles[index];
        return ListTile(
          title: Text(item.title, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
          subtitle: Text(item.markdownContent, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white38, fontSize: 11)),
        );
      },
    );
  }

  Widget _buildTutorialsTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Interactive Tutorials:', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        ListTile(
          tileColor: const Color(0xFF1E1E2E),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          leading: const Icon(Icons.school_rounded, color: Color(0xFF6C5CE7)),
          title: const Text('Drawing Basics Tutorial', style: TextStyle(color: Colors.white, fontSize: 13)),
          subtitle: const Text('Master brush, eraser, and bucket fill tools in 2 minutes.', style: TextStyle(color: Colors.white38, fontSize: 11)),
          trailing: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6C5CE7)),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Start', style: TextStyle(color: Colors.white, fontSize: 11)),
          ),
        ),
      ],
    );
  }

  Widget _buildFaqsTab() {
    final faqs = widget.helpCenterManager.faqs;
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: faqs.length,
      separatorBuilder: (context, index) => const Divider(color: Color(0xFF2A2A3D)),
      itemBuilder: (context, index) {
        final f = faqs[index];
        return ExpansionTile(
          title: Text(f.question, style: const TextStyle(color: Colors.white, fontSize: 13)),
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(f.answer, style: const TextStyle(color: Colors.white60, fontSize: 12)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCommandsTab() {
    final commands = widget.helpCenterManager.commands;
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: commands.length,
      separatorBuilder: (context, index) => const Divider(color: Color(0xFF2A2A3D)),
      itemBuilder: (context, index) {
        final c = commands[index];
        return ListTile(
          title: Text(c.commandName, style: const TextStyle(color: Colors.white, fontSize: 13)),
          subtitle: Text(c.description, style: const TextStyle(color: Colors.white38, fontSize: 11)),
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: const Color(0xFF313244), borderRadius: BorderRadius.circular(4)),
            child: Text(c.shortcut, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
          ),
        );
      },
    );
  }
}
