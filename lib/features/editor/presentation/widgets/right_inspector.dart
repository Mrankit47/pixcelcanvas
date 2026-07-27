import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixelcanvas/features/editor/engine/canvas_engine.dart';
import 'package:pixelcanvas/features/editor/presentation/controllers/editor_controller.dart';
import 'package:pixelcanvas/features/editor/presentation/state/editor_state.dart';
import 'package:pixelcanvas/features/editor/presentation/widgets/canvas_viewport.dart';
import 'package:pixelcanvas/shared/widgets/pc_card.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_radius.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';
import 'package:pixelcanvas/theme/app_typography.dart';

/// Right inspector tabbed sidebar panel per Blueprint §5.1 & §8.2.
///
/// **Purpose**: Tabbed panel for Layers, Color Palette, Tool Properties, and Edit History.
class RightInspector extends ConsumerStatefulWidget {
  /// Creates a [RightInspector].
  const RightInspector({super.key});

  @override
  ConsumerState<RightInspector> createState() => _RightInspectorState();
}

class _RightInspectorState extends ConsumerState<RightInspector>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  static const List<String> _paletteColors = [
    '#000000', '#FFFFFF', '#888888', '#A8A8A8',
    '#FFAAD4', '#E43B44', '#F77622', '#FEE761',
    '#63C74D', '#3E8948', '#265C42', '#193C3E',
    '#124E89', '#0099DB', '#2CE8F5', '#C0CBDC',
    '#8B9BB4', '#4B692F', '#45107E', '#8F563B',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final editorState = ref.watch(editorControllerProvider);
    final controller = ref.read(editorControllerProvider.notifier);
    final engine = ref.watch(canvasEngineProvider);

    return Container(
      width: 280,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(left: BorderSide(color: AppColors.neutral200)),
      ),
      child: Column(
        children: [
          // Inspector Tabs Header
          TabBar(
            controller: _tabController,
            isScrollable: true,
            labelColor: AppColors.primary500,
            unselectedLabelColor: AppColors.neutral400,
            indicatorColor: AppColors.primary500,
            labelStyle: AppTypography.labelSmall,
            tabs: const [
              Tab(text: 'Layers'),
              Tab(text: 'Palette'),
              Tab(text: 'Properties'),
              Tab(text: 'History'),
            ],
          ),

          // Tab Body Container
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildLayersTab(editorState, engine, controller),
                _buildPaletteTab(editorState, engine, controller),
                _buildPropertiesTab(editorState, engine, controller),
                _buildHistoryTab(editorState, engine, controller),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLayersTab(
    EditorState state,
    CanvasEngine engine,
    EditorController controller,
  ) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.sm),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Layer Stack (${state.layers.length})',
              style: AppTypography.labelMedium.copyWith(color: AppColors.neutral600),
            ),
            IconButton(
              icon: const Icon(Icons.add_rounded, color: AppColors.primary500, size: 20),
              onPressed: () {
                engine.createLayer();
                controller.syncEngineState(engine);
              },
              tooltip: 'Add Layer',
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        if (state.layers.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
            child: Center(
              child: Text(
                'No layers available',
                style: AppTypography.bodySmall.copyWith(color: AppColors.neutral400),
              ),
            ),
          )
        else
          ...List.generate(state.layers.length, (index) {
            // Render from top of stack to bottom
            final layerIndex = state.layers.length - 1 - index;
            final layer = state.layers[layerIndex];
            final isSelected = layerIndex == state.selectedLayerIndex;

            return _buildLayerItem(
              layer.name,
              isVisible: layer.isVisible,
              isLocked: layer.isLocked,
              isSelected: isSelected,
              onTap: () {
                engine.selectLayer(layerIndex);
                controller.syncEngineState(engine);
              },
              onToggleVisibility: () {
                engine.toggleLayerVisibility(layerIndex);
                controller.syncEngineState(engine);
              },
              onToggleLock: () {
                engine.toggleLayerLock(layerIndex);
                controller.syncEngineState(engine);
              },
            );
          }),
      ],
    );
  }

  Widget _buildLayerItem(
    String name, {
    required bool isVisible,
    required bool isLocked,
    required bool isSelected,
    required VoidCallback onTap,
    required VoidCallback onToggleVisibility,
    required VoidCallback onToggleLock,
  }) =>
      GestureDetector(
        onTap: onTap,
        child: PcCard(
          variant: isSelected ? PcCardVariant.outlined : PcCardVariant.filled,
          margin: const EdgeInsets.only(bottom: AppSpacing.xs),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
          child: Row(
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Icon(
                  isVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  size: 18,
                  color: isVisible ? AppColors.primary500 : AppColors.neutral400,
                ),
                onPressed: onToggleVisibility,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  name,
                  style: AppTypography.bodySmall.copyWith(
                    color: isSelected ? AppColors.primary500 : AppColors.neutral600,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Icon(
                  isLocked ? Icons.lock_outline_rounded : Icons.lock_open_rounded,
                  size: 16,
                  color: isLocked ? AppColors.primary500 : AppColors.neutral300,
                ),
                onPressed: onToggleLock,
              ),
            ],
          ),
        ),
      );

  Widget _buildPaletteTab(
    EditorState state,
    CanvasEngine engine,
    EditorController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Active Swatch (DB32)',
            style: AppTypography.labelMedium.copyWith(color: AppColors.neutral600),
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _paletteColors.map((hex) {
              final colorHex = hex.replaceFirst('#', '');
              final color = Color(
                int.parse(colorHex, radix: 16) | 0xFF000000,
              );
              final isSelected = state.activeColorHex.toLowerCase() == hex.toLowerCase();

              return GestureDetector(
                onTap: () {
                  controller.setActiveColor(hex);
                  controller.syncEngineState(engine);
                },
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: AppRadius.borderXs,
                    border: Border.all(
                      color: isSelected ? AppColors.primary500 : AppColors.neutral200,
                      width: isSelected ? 2.5 : 0.5,
                    ),
                    boxShadow: isSelected ? [const BoxShadow(color: Colors.black26, blurRadius: 2)] : null,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertiesTab(
    EditorState state,
    CanvasEngine engine,
    EditorController controller,
  ) {
    final isEraser = state.selectedTool == PixelTool.eraser;
    final size = isEraser ? state.eraserSettings.size : state.brushSettings.size;

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tool Options: ${state.selectedTool.name.toUpperCase()}',
            style: AppTypography.labelMedium.copyWith(color: AppColors.neutral600),
          ),
          const SizedBox(height: AppSpacing.sm),
          if (state.selectedTool == PixelTool.pencil ||
              state.selectedTool == PixelTool.brush ||
              state.selectedTool == PixelTool.eraser) ...[
            Text(
              'Brush Size: $size px',
              style: AppTypography.bodySmall.copyWith(color: AppColors.neutral600),
            ),
            Slider(
              value: size.toDouble(),
              min: 1,
              max: 8,
              divisions: 7,
              activeColor: AppColors.primary500,
              onChanged: (val) {
                if (isEraser) {
                  controller.setEraserSize(val.toInt());
                } else {
                  controller.setBrushSize(val.toInt());
                }
                controller.syncEngineState(engine);
              },
            ),
          ] else
            Text(
              'No adjustable properties for this tool',
              style: AppTypography.bodySmall.copyWith(color: AppColors.neutral400),
            ),
        ],
      ),
    );
  }

  Widget _buildHistoryTab(
    EditorState state,
    CanvasEngine engine,
    EditorController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.sm),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: state.canUndo
                    ? () {
                        engine.undo();
                        controller.syncEngineState(engine);
                      }
                    : null,
                icon: const Icon(Icons.undo_rounded, size: 16),
                label: const Text('Undo'),
              ),
              ElevatedButton.icon(
                onPressed: state.canRedo
                    ? () {
                        engine.redo();
                        controller.syncEngineState(engine);
                      }
                    : null,
                icon: const Icon(Icons.redo_rounded, size: 16),
                label: const Text('Redo'),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: ListView(
              children: [
                _buildHistoryItem('Canvas Initialized', 'Start'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(String title, String time) => Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
        child: Row(
          children: [
            const Icon(Icons.history_rounded, size: 16, color: AppColors.neutral400),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(title, style: AppTypography.bodySmall),
            ),
            Text(time, style: AppTypography.labelSmall.copyWith(color: AppColors.neutral300)),
          ],
        ),
      );
}
