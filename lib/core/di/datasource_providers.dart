import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixelcanvas/core/di/database_providers.dart';
import 'package:pixelcanvas/features/auth/data/datasources/user_local_data_source.dart';
import 'package:pixelcanvas/features/community/data/datasources/community_local_data_source.dart';
import 'package:pixelcanvas/features/notifications/data/datasources/notification_local_data_source.dart';
import 'package:pixelcanvas/features/palette/data/datasources/palette_local_data_source.dart';
import 'package:pixelcanvas/features/profile/data/datasources/achievement_local_data_source.dart';
import 'package:pixelcanvas/features/projects/data/datasources/project_local_data_source.dart';
import 'package:pixelcanvas/features/settings/data/datasources/settings_local_data_source.dart';
import 'package:pixelcanvas/features/templates/data/datasources/template_local_data_source.dart';

/// Provider for [UserLocalDataSource].
final userLocalDataSourceProvider = Provider<UserLocalDataSource>((ref) {
  final dbService = ref.watch(databaseServiceProvider);
  return UserLocalDataSourceImpl(dbService);
});

/// Provider for [ProjectLocalDataSource].
final projectLocalDataSourceProvider = Provider<ProjectLocalDataSource>((ref) {
  final dbService = ref.watch(databaseServiceProvider);
  return ProjectLocalDataSourceImpl(dbService);
});

/// Provider for [TemplateLocalDataSource].
final templateLocalDataSourceProvider = Provider<TemplateLocalDataSource>((ref) {
  final dbService = ref.watch(databaseServiceProvider);
  return TemplateLocalDataSourceImpl(dbService);
});

/// Provider for [CommunityLocalDataSource].
final communityLocalDataSourceProvider = Provider<CommunityLocalDataSource>((ref) {
  final dbService = ref.watch(databaseServiceProvider);
  return CommunityLocalDataSourceImpl(dbService);
});

/// Provider for [SettingsLocalDataSource].
final settingsLocalDataSourceProvider = Provider<SettingsLocalDataSource>((ref) {
  final dbService = ref.watch(databaseServiceProvider);
  return SettingsLocalDataSourceImpl(dbService);
});

/// Provider for [NotificationLocalDataSource].
final notificationLocalDataSourceProvider = Provider<NotificationLocalDataSource>((ref) {
  final dbService = ref.watch(databaseServiceProvider);
  return NotificationLocalDataSourceImpl(dbService);
});

/// Provider for [PaletteLocalDataSource].
final paletteLocalDataSourceProvider = Provider<PaletteLocalDataSource>((ref) {
  final dbService = ref.watch(databaseServiceProvider);
  return PaletteLocalDataSourceImpl(dbService);
});

/// Provider for [AchievementLocalDataSource].
final achievementLocalDataSourceProvider = Provider<AchievementLocalDataSource>((ref) {
  final dbService = ref.watch(databaseServiceProvider);
  return AchievementLocalDataSourceImpl(dbService);
});
