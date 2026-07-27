import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/export/models/export_format.dart';
import 'package:pixelcanvas/features/export/models/export_preset.dart';

/// Preset selector card widget for quick export presets.
class ExportPresetCard extends StatelessWidget {
  /// Creates an [ExportPresetCard].
  const ExportPresetCard({
    super.key,
    required this.preset,
    required this.isSelected,
    required this.onSelect,
  });

  final ExportPreset preset;
  final bool isSelected;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2A2A3D) : const Color(0xFF1E1E2E),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? const Color(0xFF6C5CE7) : const Color(0xFF313244),
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(_getFormatIcon(preset.format), color: const Color(0xFF6C5CE7), size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    preset.name,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.white70,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFF313244),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Scale ${preset.scaleFactor}x',
                    style: const TextStyle(color: Color(0xFF89B4FA), fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
                const Spacer(),
                Text(
                  preset.format.extension.toUpperCase(),
                  style: const TextStyle(color: Colors.white38, fontSize: 10),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconData _getFormatIcon(ExportFormat format) {
    switch (format) {
      case ExportFormat.gif:
      case ExportFormat.apng:
        return Icons.movie_creation_rounded;
      case ExportFormat.spriteSheet:
        return Icons.grid_on_rounded;
      case ExportFormat.zipPackage:
        return Icons.folder_zip_rounded;
      case ExportFormat.jsonManifest:
        return Icons.code_rounded;
      case ExportFormat.png:
      case ExportFormat.jpeg:
      case ExportFormat.webp:
      default:
        return Icons.image_rounded;
    }
  }
}
