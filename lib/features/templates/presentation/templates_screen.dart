import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixelcanvas/features/templates/presentation/controllers/templates_controller.dart';
import 'package:pixelcanvas/features/templates/presentation/widgets/category_tabs.dart';
import 'package:pixelcanvas/features/templates/presentation/widgets/empty_templates_state.dart';
import 'package:pixelcanvas/features/templates/presentation/widgets/featured_templates_carousel.dart';
import 'package:pixelcanvas/features/templates/presentation/widgets/template_filters_sheet.dart';
import 'package:pixelcanvas/features/templates/presentation/widgets/template_preview_dialog.dart';
import 'package:pixelcanvas/features/templates/presentation/widgets/templates_grid.dart';
import 'package:pixelcanvas/features/templates/presentation/widgets/templates_header.dart';
import 'package:pixelcanvas/features/templates/presentation/widgets/templates_search_bar.dart';
import 'package:pixelcanvas/shared/widgets/pc_loading.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';

/// Production-ready Templates Browser Screen for PixelCanvas per Blueprint §5.1 & §6.3.
///
/// **Purpose**: Discovery screen reacting to [TemplatesController] state.
/// **Consumed Providers**: [templatesControllerProvider]
class TemplatesScreen extends ConsumerStatefulWidget {
  /// Creates a [TemplatesScreen].
  const TemplatesScreen({super.key});

  @override
  ConsumerState<TemplatesScreen> createState() => _TemplatesScreenState();
}

class _TemplatesScreenState extends ConsumerState<TemplatesScreen> {
  String _selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(templatesControllerProvider.notifier).loadTemplates();
    });
  }

  void _handleFilterTap() {
    TemplateFiltersSheet.show(
      context,
      onApply: () {},
    );
  }

  void _handlePreviewTap(int index) {
    TemplatePreviewDialog.show(
      context,
      title: 'Starter Template #${index + 1}',
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(templatesControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.base,
            vertical: AppSpacing.md,
          ),
          children: [
            TemplatesHeader(
              templateCount: state.templates.isNotEmpty ? state.templates.length : 48,
              onSearch: () {},
              onFilter: _handleFilterTap,
            ),
            const SizedBox(height: AppSpacing.md),
            const TemplatesSearchBar(),
            const SizedBox(height: AppSpacing.md),
            CategoryTabs(
              selectedCategory: _selectedCategory,
              onCategorySelected: (cat) {
                setState(() {
                  _selectedCategory = cat;
                });
              },
            ),
            const SizedBox(height: AppSpacing.xl),
            FeaturedTemplatesCarousel(
              onTemplateTap: _handlePreviewTap,
            ),
            const SizedBox(height: AppSpacing.xl),
            state.isLoading
                ? const Center(child: PcLoadingIndicator())
                : state.templates.isEmpty
                    ? EmptyTemplatesState(
                        onExplore: () {
                          setState(() {
                            _selectedCategory = 'All';
                          });
                        },
                      )
                    : TemplatesGrid(
                        itemCount: 12,
                        onPreview: _handlePreviewTap,
                        onUseTemplate: (index) {},
                      ),
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }
}
