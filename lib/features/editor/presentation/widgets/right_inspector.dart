import 'package:flutter/material.dart';
import 'package:pixelcanvas/shared/widgets/pc_card.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_radius.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';
import 'package:pixelcanvas/theme/app_typography.dart';

/// Right inspector tabbed sidebar panel per Blueprint §5.1 & §8.2.
///
/// **Purpose**: Tabbed panel for Layers, Color Palette, Tool Properties, and Edit History.
/// **Parameters**: None.
/// **Future Extension Notes**: Integrates `LayersListNotifier` and `PaletteNotifier` in Phase 4.
class RightInspector extends StatefulWidget {
  /// Creates a [RightInspector].
  const RightInspector({super.key});

  @override
  State<RightInspector> createState() => _RightInspectorState();
}

class _RightInspectorState extends State<RightInspector>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

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
  Widget build(BuildContext context) => Container(
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
                  _buildLayersTab(),
                  _buildPaletteTab(),
                  _buildPropertiesTab(),
                  _buildHistoryTab(),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _buildLayersTab() => ListView(
        padding: const EdgeInsets.all(AppSpacing.sm),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Layer Stack (3)',
                style: AppTypography.labelMedium.copyWith(color: AppColors.neutral600),
              ),
              IconButton(
                icon: const Icon(Icons.add_rounded, color: AppColors.primary500, size: 20),
                onPressed: () {},
                tooltip: 'Add Layer',
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          _buildLayerItem('Outline Layer', isVisible: true, isSelected: true),
          _buildLayerItem('Color Fill Layer', isVisible: true, isSelected: false),
          _buildLayerItem('Background Layer', isVisible: false, isSelected: false),
        ],
      );

  Widget _buildLayerItem(String name, {required bool isVisible, required bool isSelected}) =>
      PcCard(
        variant: isSelected ? PcCardVariant.outlined : PcCardVariant.filled,
        margin: const EdgeInsets.only(bottom: AppSpacing.xs),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
        child: Row(
          children: [
            Icon(
              isVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
              size: 18,
              color: AppColors.neutral400,
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
            const Icon(Icons.lock_open_rounded, size: 16, color: AppColors.neutral300),
          ],
        ),
      );

  Widget _buildPaletteTab() => Padding(
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
              spacing: 6,
              runSpacing: 6,
              children: List.generate(
                16,
                (index) => Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: Colors.primaries[index % Colors.primaries.length],
                    borderRadius: AppRadius.borderXs,
                    border: Border.all(color: AppColors.neutral200, width: 0.5),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget _buildPropertiesTab() => Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tool Options: Pencil',
              style: AppTypography.labelMedium.copyWith(color: AppColors.neutral600),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Brush Size: 1 px',
              style: AppTypography.bodySmall.copyWith(color: AppColors.neutral400),
            ),
            Slider(
              value: 1,
              min: 1,
              max: 8,
              divisions: 7,
              activeColor: AppColors.primary500,
              onChanged: (val) {},
            ),
          ],
        ),
      );

  Widget _buildHistoryTab() => ListView(
        padding: const EdgeInsets.all(AppSpacing.sm),
        children: [
          _buildHistoryItem('Pencil Draw', '10:42 AM'),
          _buildHistoryItem('Fill Bucket', '10:41 AM'),
          _buildHistoryItem('New Layer Added', '10:40 AM'),
        ],
      );

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
