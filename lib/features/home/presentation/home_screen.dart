import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pixelcanvas/features/auth/presentation/controllers/auth_controller.dart';
import 'package:pixelcanvas/features/home/presentation/widgets/community_preview_section.dart';
import 'package:pixelcanvas/features/home/presentation/widgets/continue_working_card.dart';
import 'package:pixelcanvas/features/home/presentation/widgets/floating_create_button.dart';
import 'package:pixelcanvas/features/home/presentation/widgets/home_header.dart';
import 'package:pixelcanvas/features/home/presentation/widgets/quick_actions_section.dart';
import 'package:pixelcanvas/features/home/presentation/widgets/recent_projects_section.dart';
import 'package:pixelcanvas/features/home/presentation/widgets/templates_preview_section.dart';
import 'package:pixelcanvas/features/projects/presentation/controllers/projects_controller.dart';
import 'package:pixelcanvas/navigation/route_paths.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';

/// Production-ready Home Dashboard Screen for PixelCanvas per Blueprint §5.1 & §6.3.
///
/// **Purpose**: Main entry point dashboard reacting to auth and project state.
/// **Consumed Providers**: [authControllerProvider], [projectsControllerProvider]
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
    final authState = ref.watch(authControllerProvider);
    final projectsState = ref.watch(projectsControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.base,
            vertical: AppSpacing.md,
          ),
          children: [
            HomeHeader(
              userName: authState.user?.displayName.value ?? 'Alex Rivers',
              userAvatarUrl: authState.user?.avatarUrl,
              onAvatarTap: () => context.go(RoutePaths.profile),
              onNotificationTap: () => context.push(RoutePaths.notifications),
              onSettingsTap: () => context.push(RoutePaths.settings),
            ),
            const SizedBox(height: AppSpacing.lg),

            QuickActionsSection(
              onNewCanvasTap: () => context.push(RoutePaths.editorPath('new')),
              onBrowseTemplatesTap: () => context.go(RoutePaths.templates),
              onImportImageTap: () => context.push(RoutePaths.editorPath('import')),
              onJoinCommunityTap: () => context.go(RoutePaths.community),
            ),
            const SizedBox(height: AppSpacing.xl),

            ContinueWorkingCard(
              projectTitle: projectsState.projects.isNotEmpty
                  ? projectsState.projects.first.title
                  : 'Cyberpunk Knight 32x32',
              lastModified: '10 mins ago',
              canvasSize: '32 × 32 px',
              layersCount: 4,
              onContinueTap: () => context.push(RoutePaths.editorPath('active')),
            ),
            const SizedBox(height: AppSpacing.xl),

            RecentProjectsSection(
              onSeeAllTap: () => context.push(RoutePaths.projects),
              onProjectTap: (index) => context.push(RoutePaths.editorPath('project_$index')),
            ),
            const SizedBox(height: AppSpacing.xl),

            TemplatesPreviewSection(
              onSeeAllTap: () => context.go(RoutePaths.templates),
              onTemplateTap: (index) => context.push(RoutePaths.editorPath('template_$index')),
            ),
            const SizedBox(height: AppSpacing.xl),

            CommunityPreviewSection(
              onSeeAllTap: () => context.go(RoutePaths.community),
              onArtworkTap: (index) => context.go(RoutePaths.community),
            ),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
      floatingActionButton: FloatingCreateButton(
        onPressed: () => context.push(RoutePaths.editorPath('new')),
      ),
    );
  }
}
