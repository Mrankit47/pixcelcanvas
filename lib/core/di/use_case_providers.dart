import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixelcanvas/core/di/repository_providers.dart';
import 'package:pixelcanvas/features/projects/application/use_cases/delete_project.dart';
import 'package:pixelcanvas/features/projects/application/use_cases/get_project_by_id.dart';
import 'package:pixelcanvas/features/projects/application/use_cases/get_projects.dart';
import 'package:pixelcanvas/features/projects/application/use_cases/save_project.dart';
import 'package:pixelcanvas/features/projects/application/use_cases/toggle_favorite.dart';
import 'package:pixelcanvas/features/settings/application/use_cases/get_settings.dart';
import 'package:pixelcanvas/features/settings/application/use_cases/save_settings.dart';
import 'package:pixelcanvas/features/templates/application/use_cases/get_template_by_id.dart';
import 'package:pixelcanvas/features/templates/application/use_cases/get_templates.dart';

// ── Projects Use Cases ──
final getProjectsProvider = Provider<GetProjects>((ref) {
  return GetProjects(ref.watch(projectRepositoryProvider));
});

final getProjectByIdProvider = Provider<GetProjectById>((ref) {
  return GetProjectById(ref.watch(projectRepositoryProvider));
});

final saveProjectProvider = Provider<SaveProject>((ref) {
  return SaveProject(ref.watch(projectRepositoryProvider));
});

final deleteProjectProvider = Provider<DeleteProject>((ref) {
  return DeleteProject(ref.watch(projectRepositoryProvider));
});

final toggleFavoriteProvider = Provider<ToggleFavorite>((ref) {
  return ToggleFavorite(ref.watch(projectRepositoryProvider));
});

// ── Templates Use Cases ──
final getTemplatesProvider = Provider<GetTemplates>((ref) {
  return GetTemplates(ref.watch(templateRepositoryProvider));
});

final getTemplateByIdProvider = Provider<GetTemplateById>((ref) {
  return GetTemplateById(ref.watch(templateRepositoryProvider));
});

// ── Settings Use Cases ──
final getSettingsProvider = Provider<GetSettings>((ref) {
  return GetSettings(ref.watch(settingsRepositoryProvider));
});

final saveSettingsProvider = Provider<SaveSettings>((ref) {
  return SaveSettings(ref.watch(settingsRepositoryProvider));
});
