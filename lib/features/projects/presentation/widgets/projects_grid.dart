import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/projects/presentation/widgets/project_card.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';

/// Responsive GridView displaying project cards per Blueprint §5.1 & §6.2.
///
/// **Purpose**: Responsive 2-column (mobile), 3-column (tablet), or 4-column (desktop) project grid.
/// **Parameters**:
/// - [itemCount]: Number of project items (default: 12).
/// - [onProjectTap]: Callback when a project is tapped.
///
/// **Future Extension Notes**: Will consume `List<ProjectEntity>` stream in Phase 2 Step 6.
class ProjectsGrid extends StatelessWidget {
  /// Creates a [ProjectsGrid].
  const ProjectsGrid({
    this.itemCount = 12,
    this.onProjectTap,
    super.key,
  });

  /// Item count.
  final int itemCount;

  /// Project tap callback.
  final ValueChanged<int>? onProjectTap;

  static const List<Map<String, dynamic>> _placeholders = [
    {'title': 'Dragon Sprite', 'size': '32 × 32', 'time': '2m ago', 'fav': true, 'sync': true},
    {'title': 'Cyber Knight', 'size': '16 × 16', 'time': '1h ago', 'fav': false, 'sync': true},
    {'title': 'Health Potion', 'size': '32 × 32', 'time': '3h ago', 'fav': true, 'sync': true},
    {'title': 'Space Station', 'size': '64 × 64', 'time': '1d ago', 'fav': false, 'sync': false},
    {'title': 'Retro Coin', 'size': '16 × 16', 'time': '2d ago', 'fav': false, 'sync': true},
    {'title': 'Forest Tilemap', 'size': '32 × 32', 'time': '3d ago', 'fav': true, 'sync': true},
    {'title': 'Magic Wand', 'size': '16 × 16', 'time': '4d ago', 'fav': false, 'sync': true},
    {'title': 'Boss Monster', 'size': '64 × 64', 'time': '5d ago', 'fav': true, 'sync': true},
    {'title': 'Pixel Heart', 'size': '16 × 16', 'time': '6d ago', 'fav': false, 'sync': false},
    {'title': 'Treasure Chest', 'size': '32 × 32', 'time': '1w ago', 'fav': false, 'sync': true},
    {'title': 'Sci-Fi Portal', 'size': '64 × 64', 'time': '1w ago', 'fav': true, 'sync': true},
    {'title': 'Dungeon Key', 'size': '16 × 16', 'time': '2w ago', 'fav': false, 'sync': true},
  ];

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          final crossAxisCount = constraints.maxWidth > 900
              ? 4
              : constraints.maxWidth > 600
                  ? 3
                  : 2;

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: itemCount,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: AppSpacing.sm,
              mainAxisSpacing: AppSpacing.sm,
              childAspectRatio: 0.85,
            ),
            itemBuilder: (context, index) {
              final item = _placeholders[index % _placeholders.length];
              return ProjectCard(
                title: item['title'] as String,
                gridSize: item['size'] as String,
                lastEdited: item['time'] as String,
                isFavorite: item['fav'] as bool,
                isSynced: item['sync'] as bool,
                onTap: () => onProjectTap?.call(index),
              );
            },
          );
        },
      );
}
