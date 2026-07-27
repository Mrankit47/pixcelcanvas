import 'package:pixelcanvas/features/project_creation/models/palette_preset.dart';
import 'package:pixelcanvas/features/project_creation/models/template_category.dart';
import 'package0/pixelcanvas/features/project_creation/models/template_metadata.dart';
import 'package:pixelcanvas/features/project_creation/models/template_preset.dart';

/// Catalog of built-in templates per Blueprint §7.3.
class BuiltInTemplates {
  static final now = DateTime.now();

  static final List<TemplatePreset> all = [
    // 1. 16x16 Character Sprite
    TemplatePreset(
      metadata: TemplateMetadata(
        id: 'tmpl_char_16',
        name: '16×16 Character Sprite',
        description: 'Standard 16x16 retro RPG hero character canvas with body outline guidelines.',
        category: TemplateCategory.characters,
        width: 16,
        height: 16,
        layerCount: 3,
        tags: const ['Character', 'Hero', 'RPG', '16x16'],
        createdDate: now,
        modifiedDate: now,
      ),
      palette: PalettePreset.defaults[1], // PICO-8
      layerNames: const ['Background', 'Outline', 'Coloring'],
      showGrid: true,
      gridSize: 16,
    ),

    // 2. 32x32 Game Item Icon
    TemplatePreset(
      metadata: TemplateMetadata(
        id: 'tmpl_item_32',
        name: '32×32 Game Item Icon',
        description: 'Centered 32x32 item icon template ideal for weapons, potions, and inventory grids.',
        category: TemplateCategory.icons,
        width: 32,
        height: 32,
        layerCount: 2,
        tags: const ['Icon', 'Item', 'Inventory', '32x32'],
        createdDate: now,
        modifiedDate: now,
      ),
      palette: PalettePreset.defaults[3], // DB16
      layerNames: const ['Slot Frame', 'Item Art'],
      showGrid: true,
      gridSize: 8,
    ),

    // 3. 64x64 RPG Tileset
    TemplatePreset(
      metadata: TemplateMetadata(
        id: 'tmpl_tileset_64',
        name: '64×64 RPG Tileset Block',
        description: '64x64 terrain tileset grid split into four 32x32 seamless autotile corners.',
        category: TemplateCategory.tilesets,
        width: 64,
        height: 64,
        layerCount: 3,
        tags: const ['Tileset', 'Terrain', 'World', '64x64'],
        createdDate: now,
        modifiedDate: now,
      ),
      palette: PalettePreset.defaults[3], // DB16
      layerNames: const ['Base Ground', 'Detail Props', 'Grid Overlay'],
      showGrid: true,
      gridSize: 32,
    ),

    // 4. 128x128 Animated Walk Cycle
    TemplatePreset(
      metadata: TemplateMetadata(
        id: 'tmpl_walk_128',
        name: '128×128 Animated Walk Cycle',
        description: 'High-res 128x128 animated character canvas pre-configured with 8 timeline frames.',
        category: TemplateCategory.animations,
        width: 128,
        height: 128,
        layerCount: 3,
        hasAnimation: true,
        tags: const ['Animation', 'Walk', 'Run', '128x128'],
        createdDate: now,
        modifiedDate: now,
      ),
      palette: PalettePreset.defaults[0],
      layerNames: const ['Ground Line', 'Shadow', 'Character'],
      enableAnimation: true,
      defaultFps: 12,
      initialFrameCount: 8,
    ),

    // 5. 32x32 Pixel Portrait
    TemplatePreset(
      metadata: TemplateMetadata(
        id: 'tmpl_portrait_32',
        name: '32×32 Pixel Portrait',
        description: 'Compact 32x32 dialogue avatar portrait canvas.',
        category: TemplateCategory.pixelPortraits,
        width: 32,
        height: 32,
        layerCount: 2,
        tags: const ['Portrait', 'Avatar', 'Dialogue', '32x32'],
        createdDate: now,
        modifiedDate: now,
      ),
      palette: PalettePreset.defaults[1], // PICO-8
      layerNames: const ['Background Frame', 'Face Art'],
    ),

    // 6. 48x48 UI Health Bar Component
    TemplatePreset(
      metadata: TemplateMetadata(
        id: 'tmpl_ui_48',
        name: '48×48 UI Component',
        description: 'UI HUD element canvas for health bars, skill buttons, and status icons.',
        category: TemplateCategory.uiAssets,
        width: 48,
        height: 48,
        layerCount: 3,
        tags: const ['UI', 'HUD', 'Health', '48x48'],
        createdDate: now,
        modifiedDate: now,
      ),
      palette: PalettePreset.defaults[2], // GameBoy
      layerNames: const ['Frame Border', 'Fill Bar', 'Glow Details'],
    ),
  ];
}
