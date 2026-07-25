import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/templates/presentation/widgets/template_card.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';

/// Responsive GridView displaying starter template cards per Blueprint §5.1 & §6.2.
///
/// **Purpose**: Responsive 2-column (mobile), 3-column (tablet), or 4-column (desktop) template grid.
/// **Parameters**:
/// - [itemCount]: Item count (default: 12).
/// - [onPreview]: Callback when template card is tapped.
/// - [onUseTemplate]: Callback when Use Template button is tapped.
///
/// **Future Extension Notes**: Consumes `List<TemplateEntity>` in Phase 2 Step 8.
class TemplatesGrid extends StatelessWidget {
  /// Creates a [TemplatesGrid].
  const TemplatesGrid({
    this.itemCount = 12,
    this.onPreview,
    this.onUseTemplate,
    super.key,
  });

  /// Item count.
  final int itemCount;

  /// Preview callback.
  final ValueChanged<int>? onPreview;

  /// Use template callback.
  final ValueChanged<int>? onUseTemplate;

  static const List<Map<String, dynamic>> _placeholders = [
    {'name': 'Knight Sprite', 'cat': 'Characters', 'size': '32 × 32', 'diff': 'Beginner', 'fav': true},
    {'name': 'Grass Tile', 'cat': 'Tilesets', 'size': '16 × 16', 'diff': 'Easy', 'fav': false},
    {'name': 'Potion Icon', 'cat': 'Icons', 'size': '16 × 16', 'diff': 'Beginner', 'fav': true},
    {'name': 'Game HUD', 'cat': 'UI', 'size': '64 × 64', 'diff': 'Medium', 'fav': false},
    {'name': 'Fire FX', 'cat': 'Effects', 'size': '32 × 32', 'diff': 'Advanced', 'fav': true},
    {'name': 'Dungeon Wall', 'cat': 'Tilesets', 'size': '16 × 16', 'diff': 'Easy', 'fav': false},
    {'name': 'Wizard Avatar', 'cat': 'Characters', 'size': '32 × 32', 'diff': 'Medium', 'fav': false},
    {'name': 'Coin Animation', 'cat': 'Icons', 'size': '16 × 16', 'diff': 'Beginner', 'fav': true},
    {'name': 'Health Bar', 'cat': 'UI', 'size': '64 × 16', 'diff': 'Easy', 'fav': false},
    {'name': 'Explosion FX', 'cat': 'Effects', 'size': '32 × 32', 'diff': 'Advanced', 'fav': true},
    {'name': 'Space Stars', 'cat': 'Backgrounds', 'size': '64 × 64', 'diff': 'Beginner', 'fav': false},
    {'name': 'Cyber Dragon', 'cat': 'Characters', 'size': '64 × 64', 'diff': 'Expert', 'fav': true},
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
              childAspectRatio: 0.78,
            ),
            itemBuilder: (context, index) {
              final item = _placeholders[index % _placeholders.length];
              return TemplateCard(
                name: item['name'] as String,
                category: item['cat'] as String,
                gridSize: item['size'] as String,
                difficulty: item['diff'] as String,
                isFavorite: item['fav'] as bool,
                onPreview: () => onPreview?.call(index),
                onUseTemplate: () => onUseTemplate?.call(index),
              );
            },
          );
        },
      );
}
