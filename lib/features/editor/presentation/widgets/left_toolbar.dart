import 'package:flutter/material.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_durations.dart';
import 'package:pixelcanvas/theme/app_radius.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';

/// Left vertical drawing tools palette for Pixel Editor workspace per Blueprint §5.1 & §8.2.
///
/// **Purpose**: Tool selector palette for Selection, Pencil, Eraser, Fill, Line, Shape, Move, Text, Eyedropper.
/// **Parameters**:
/// - [selectedTool]: Currently active tool name string (default: "Pencil").
/// - [onToolSelected]: Callback emitting selected tool name.
///
/// **Future Extension Notes**: Selected tool binds to `EditorToolNotifier` in Phase 4.
class LeftToolbar extends StatelessWidget {
  /// Creates a [LeftToolbar].
  const LeftToolbar({
    this.selectedTool = 'Pencil',
    this.onToolSelected,
    super.key,
  });

  /// Selected tool name.
  final String selectedTool;

  /// Tool selection callback.
  final ValueChanged<String>? onToolSelected;

  static const List<Map<String, dynamic>> _tools = [
    {'name': 'Selection', 'icon': Icons.select_all_rounded, 'shortcut': 'S'},
    {'name': 'Pencil', 'icon': Icons.edit_rounded, 'shortcut': 'P'},
    {'name': 'Eraser', 'icon': Icons.cleaning_services_rounded, 'shortcut': 'E'},
    {'name': 'Fill', 'icon': Icons.format_color_fill_rounded, 'shortcut': 'F'},
    {'name': 'Line', 'icon': Icons.horizontal_rule_rounded, 'shortcut': 'L'},
    {'name': 'Rectangle', 'icon': Icons.crop_square_rounded, 'shortcut': 'R'},
    {'name': 'Circle', 'icon': Icons.circle_outlined, 'shortcut': 'C'},
    {'name': 'Move', 'icon': Icons.open_with_rounded, 'shortcut': 'M'},
    {'name': 'Text', 'icon': Icons.text_fields_rounded, 'shortcut': 'T'},
    {'name': 'Eyedropper', 'icon': Icons.colorize_rounded, 'shortcut': 'I'},
  ];

  @override
  Widget build(BuildContext context) => Container(
        width: 52,
        decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(right: BorderSide(color: AppColors.neutral200)),
        ),
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Column(
          children: _tools.map((item) {
            final toolName = item['name'] as String;
            final toolIcon = item['icon'] as IconData;
            final shortcut = item['shortcut'] as String;
            final isSelected = toolName == selectedTool;

            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xs),
              child: AnimatedContainer(
                duration: AppDurations.fast,
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary100 : Colors.transparent,
                  borderRadius: AppRadius.borderSm,
                  border: isSelected
                      ? Border.all(color: AppColors.primary500, width: 1.5)
                      : null,
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    toolIcon,
                    size: 20,
                    color: isSelected ? AppColors.primary500 : AppColors.neutral400,
                  ),
                  onPressed: () => onToolSelected?.call(toolName),
                  tooltip: '$toolName ($shortcut)',
                ),
              ),
            );
          }).toList(),
        ),
      );
}
