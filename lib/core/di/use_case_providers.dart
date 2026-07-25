import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixelcanvas/core/di/repository_providers.dart';
import 'package:pixelcanvas/features/auth/application/use_cases/get_current_user.dart';
import 'package:pixelcanvas/features/auth/application/use_cases/sign_in_as_guest.dart';
import 'package:pixelcanvas/features/auth/application/use_cases/sign_out.dart';
import 'package:pixelcanvas/features/community/application/use_cases/get_feed.dart';
import 'package:pixelcanvas/features/community/application/use_cases/publish_artwork.dart';
import 'package:pixelcanvas/features/community/application/use_cases/toggle_like.dart';
import 'package:pixelcanvas/features/projects/application/use_cases/delete_project.dart';
import 'package:pixelcanvas/features/projects/application/use_cases/get_project_by_id.dart';
import 'package:pixelcanvas/features/projects/application/use_cases/get_projects.dart';
import 'package:pixelcanvas/features/projects/application/use_cases/save_project.dart';
import 'package:pixelcanvas/features/projects/application/use_cases/toggle_favorite.dart';
import 'package:pixelcanvas/features/settings/application/use_cases/get_settings.dart';
import 'package:pixelcanvas/features/settings/application/use_cases/save_settings.dart';
import 'package:pixelcanvas/features/templates/application/use_cases/get_template_by_id.dart';
import 'package:pixelcanvas/features/templates/application/use_cases/get_templates.dart';

// ── Auth Use Cases ──
final getCurrentUserProvider = Provider<GetCurrentUser>((ref) {
  return GetCurrentUser(ref.watch(userRepositoryProvider));
});

final signInAsGuestProvider = Provider<SignInAsGuest>((ref) {
  return SignInAsGuest(ref.watch(userRepositoryProvider));
});

final signOutProvider = Provider<SignOut>((ref) {
  return SignOut(ref.watch(userRepositoryProvider));
});

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

// ── Community Use Cases ──
final getFeedProvider = Provider<GetFeed>((ref) {
  return GetFeed(ref.watch(communityRepositoryProvider));
});

final publishArtworkProvider = Provider<PublishArtwork>((ref) {
  return PublishArtwork(ref.watch(communityRepositoryProvider));
});

final toggleLikeProvider = Provider<ToggleLike>((ref) {
  return ToggleLike(ref.watch(communityRepositoryProvider));
});

// ── Settings Use Cases ──
final getSettingsProvider = Provider<GetSettings>((ref) {
  return GetSettings(ref.watch(settingsRepositoryProvider));
});

final saveSettingsProvider = Provider<SaveSettings>((ref) {
  return SaveSettings(ref.watch(settingsRepositoryProvider));
});
