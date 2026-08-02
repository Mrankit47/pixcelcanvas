import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pixelcanvas/features/home/presentation/widgets/continue_working_card.dart';
import 'package:pixelcanvas/features/home/presentation/widgets/floating_create_button.dart';
import 'package:pixelcanvas/features/home/presentation/widgets/home_header.dart';
import 'package:pixelcanvas/features/home/presentation/widgets/quick_actions_section.dart';
import 'package:pixelcanvas/features/home/presentation/widgets/templates_preview_section.dart';
import 'package:pixelcanvas/features/projects/presentation/controllers/projects_controller.dart';
import 'package:pixelcanvas/navigation/route_paths.dart';
import 'package:pixelcanvas/shared/widgets/pixel_background.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';

/// Production-ready Home Dashboard Screen for PixelCanvas per Blueprint §5.1 & §6.3.
class HomeScreen extends ConsumerStatefulWidget {
  /// Creates a [HomeScreen].
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(projectsControllerProvider.notifier).loadProjects();
    });
  }

  @override
  Widget build(BuildContext context) {
    final projectsState = ref.watch(projectsControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: PixelBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.base,
              vertical: AppSpacing.md,
            ),
            children: [
              const HomeHeader(
                userName: 'Pixel Creator',
              ),
              const SizedBox(height: AppSpacing.lg),

              QuickActionsSection(
                onNewProject: () => context.push(RoutePaths.editorPath('new')),
                onImportImage: () => context.push(RoutePaths.editorPath('import')),
                onTemplates: () => context.go(RoutePaths.templates),
              ),
              const SizedBox(height: AppSpacing.xl),

              ContinueWorkingCard(
                title: projectsState.projects.isNotEmpty
                    ? projectsState.projects.first.title
                    : 'Cyberpunk Knight 32x32',
                onContinue: () => context.push(RoutePaths.editorPath('active')),
              ),
              const SizedBox(height: AppSpacing.xl),

              TemplatesPreviewSection(
                onViewAll: () => context.go(RoutePaths.templates),
                onTemplateTap: (index) => context.push(RoutePaths.editorPath('template_$index')),
              ),
              const SizedBox(height: AppSpacing.xxl),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingCreateButton(
        onPressed: () => context.push(RoutePaths.editorPath('new')),
      ),
    );
  }
}
