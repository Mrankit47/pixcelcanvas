import 'package:flutter/material.dart';

/// Creation parameters returned from [CreateProjectDialog].
class CreateProjectParams {
  const CreateProjectParams({
    required this.name,
    required this.width,
    required this.height,
    this.backgroundColorHex = '#00000000',
  });

  final String name;
  final int width;
  final int height;
  final String backgroundColorHex;
}

/// Modal dialog for creating a new pixel canvas project.
class CreateProjectDialog extends StatefulWidget {
  /// Creates a [CreateProjectDialog].
  const CreateProjectDialog({super.key});

  @override
  State<CreateProjectDialog> createState() => _CreateProjectDialogState();
}

class _CreateProjectDialogState extends State<CreateProjectDialog> {
  final TextEditingController _nameController = TextEditingController(text: 'New Project');
  int _width = 32;
  int _height = 32;
  String _bgHex = '#00000000';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF1E1E2E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFF313244)),
      ),
      title: const Row(
        children: [
          Icon(Icons.add_box_rounded, color: Color(0xFF6C5CE7)),
          SizedBox(width: 8),
          Text('New Pixel Canvas', style: TextStyle(color: Colors.white, fontSize: 16)),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project Name Field
            const Text('Project Name', style: TextStyle(color: Colors.white70, fontSize: 12)),
            const SizedBox(height: 6),
            TextField(
              controller: _nameController,
              style: const TextStyle(color: Colors.white, fontSize: 13),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF181825),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 16),

            // Canvas Preset Resolution Selector
            const Text('Canvas Presets', style: TextStyle(color: Colors.white70, fontSize: 12)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildPresetChip(16, 16, '16 × 16 (Icon)'),
                _buildPresetChip(32, 32, '32 × 32 (Sprite)'),
                _buildPresetChip(64, 64, '64 × 64 (Tile)'),
                _buildPresetChip(128, 128, '128 × 128 (Large)'),
              ],
            ),
            const SizedBox(height: 16),

            // Custom Dimensions
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Width (px)', style: TextStyle(color: Colors.white70, fontSize: 12)),
                      const SizedBox(height: 4),
                      TextFormField(
                        initialValue: '$_width',
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.white, fontSize: 13),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFF181825),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide.none),
                        ),
                        onChanged: (val) => _width = int.tryParse(val) ?? 32,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Height (px)', style: TextStyle(color: Colors.white70, fontSize: 12)),
                      const SizedBox(height: 4),
                      TextFormField(
                        initialValue: '$_height',
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.white, fontSize: 13),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFF181825),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide.none),
                        ),
                        onChanged: (val) => _height = int.tryParse(val) ?? 32,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(null),
          child: const Text('Cancel', style: TextStyle(color: Colors.white60)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6C5CE7),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          ),
          onPressed: () {
            final name = _nameController.text.trim().isNotEmpty
                ? _nameController.text.trim()
                : 'Untitled';
            Navigator.of(context).pop(
              CreateProjectParams(
                name: name,
                width: _width.clamp(1, 4096),
                height: _height.clamp(1, 4096),
                backgroundColorHex: _bgHex,
              ),
            );
          },
          child: const Text('Create Canvas', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  Widget _buildPresetChip(int w, int h, String label) {
    final isSelected = _width == w && _height == h;
    return ChoiceChip(
      label: Text(label, style: TextStyle(color: isSelected ? Colors.white : Colors.white60, fontSize: 11)),
      selected: isSelected,
      selectedColor: const Color(0xFF6C5CE7),
      backgroundColor: const Color(0xFF181825),
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _width = w;
            _height = h;
          });
        }
      },
    );
  }
}
