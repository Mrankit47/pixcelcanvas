import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/project_creation/controllers/template_manager.dart';
import 'package:pixelcanvas/features/project_creation/models/template_category.dart';
import 'package:pixelcanvas/features/project_creation/models/template_preset.dart';
import 'package:pixelcanvas/features/project_creation/presentation/widgets/template_card.dart';
import 'package:pixelcanvas/features/project_creation/presentation/widgets/template_preview_dialog.dart';

/// Template chooser library gallery view.
class TemplateLibraryView extends StatefulWidget {
  /// Creates a [TemplateLibraryView].
  const TemplateLibraryView({
    super.key,
    required this.templateManager,
    required this.onSelectTemplate,
  });

  final TemplateManager templateManager;
  final ValueChanged<TemplatePreset> onSelectTemplate;

  @override
  State<TemplateLibraryView> createState() => _TemplateLibraryViewState();
}

class _TemplateLibraryViewState extends State<TemplateLibraryView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.templateManager.addListener(_onChanged);
  }

  @override
  void dispose() {
    widget.templateManager.removeListener(_onChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onChanged() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final templates = widget.templateManager.displayedTemplates;

    return Column(
      children: [
        // Category Filter Chips Bar
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              _buildCategoryChip(null, 'All Templates'),
              ...TemplateCategory.values.map(
                (cat) => _buildCategoryChip(cat, cat.name.toUpperCase()),
              ),
            ],
          ),
        ),

        // Grid Area
        Expanded(
          child: templates.isEmpty
              ? const Center(
                  child: Text('No templates found', style: TextStyle(color: Colors.white38, fontSize: 13)),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 220,
                    childAspectRatio: 0.85,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                  ),
                  itemCount: templates.length,
                  itemBuilder: (context, index) {
                    final item = templates[index];
                    return TemplateCard(
                      template: item,
                      onSelect: () => widget.onSelectTemplate(item),
                      onPreview: () => _showPreview(item),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildCategoryChip(TemplateCategory? cat, String label) {
    final isSelected = widget.templateManager.filterOptions.selectedCategory == cat;
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: ChoiceChip(
        label: Text(label, style: TextStyle(color: isSelected ? Colors.white : Colors.white60, fontSize: 10)),
        selected: isSelected,
        selectedColor: const Color(0xFF6C5CE7),
        backgroundColor: const Color(0xFF181825),
        onSelected: (val) {
          widget.templateManager.updateFilter(
            widget.templateManager.filterOptions.copyWith(selectedCategory: val ? cat : null),
          );
        },
      ),
    );
  }

  void _showPreview(TemplatePreset preset) {
    showDialog(
      context: context,
      builder: (context) => TemplatePreviewDialog(
        template: preset,
        onSelect: () => widget.onSelectTemplate(preset),
      ),
    );
  }
}
