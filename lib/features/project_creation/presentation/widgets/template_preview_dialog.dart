import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/project_creation/models/template_preset.dart';

/// Modal dialog displaying full template specifications and palette preview.
class TemplatePreviewDialog extends StatelessWidget {
  /// Creates a [TemplatePreviewDialog].
  const TemplatePreviewDialog({
    super.key,
    required this.template,
    required this.onSelect,
  });

  final TemplatePreset template;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    final meta = template.metadata;
    final palette = template.palette;

    return AlertDialog(
      backgroundColor: const Color(0xFF1E1E2E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Row(
        children: [
          const Icon(Icons.dashboard_customize_rounded, color: Color(0xFF6C5CE7)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(meta.name, style: const TextStyle(color: Colors.white, fontSize: 16)),
          ),
        ],
      ),
      content: SizedBox(
        width: 420,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(meta.description, style: const TextStyle(color: Colors.white70, fontSize: 12)),
            const SizedBox(height: 16),

            // Specifications Grid
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF181825),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  _buildSpecRow('Resolution:', meta.resolutionString),
                  const Divider(color: Color(0xFF313244)),
                  _buildSpecRow('Category:', meta.category.name),
                  const Divider(color: Color(0xFF313244)),
                  _buildSpecRow('Layer Stack:', '${template.layerNames.length} Layers (${template.layerNames.join(", ")})'),
                  const Divider(color: Color(0xFF313244)),
                  _buildSpecRow('Animation:', meta.hasAnimation ? 'Enabled (${template.defaultFps} FPS)' : 'Disabled'),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Palette Swatches
            Text('Palette: ${palette.name}', style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: palette.colorsHex.map((hex) {
                final color = _parseHexColor(hex);
                return Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.white24),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close', style: TextStyle(color: Colors.white60)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6C5CE7)),
          onPressed: () {
            Navigator.of(context).pop();
            onSelect();
          },
          child: const Text('Create Project from Template', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  Widget _buildSpecRow(String label, String value) {
    return Row(
      children: [
        Text(label, style: const TextStyle(color: Colors.white38, fontSize: 11)),
        const Spacer(),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Color _parseHexColor(String hex) {
    final buffer = StringBuffer();
    if (hex.length == 6 || hex.length == 7) buffer.write('ff');
    buffer.write(hex.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
