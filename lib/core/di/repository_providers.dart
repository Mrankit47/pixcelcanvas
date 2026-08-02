import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixelcanvas/core/di/datasource_providers.dart';
import 'package:pixelcanvas/features/projects/data/repositories/project_repository_impl.dart';
import 'package:pixelcanvas/features/projects/domain/repositories/project_repository.dart';
import 'package:pixelcanvas/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:pixelcanvas/features/settings/domain/repositories/settings_repository.dart';
import 'package:pixelcanvas/features/templates/data/repositories/template_repository_impl.dart';
import 'package:pixelcanvas/features/templates/domain/repositories/template_repository.dart';

/// Provider exposing [ProjectRepository] domain contract interface.
final projectRepositoryProvider = Provider<ProjectRepository>((ref) {
  final localDataSource = ref.watch(projectLocalDataSourceProvider);
  return ProjectRepositoryImpl(localDataSource);
});

/// Provider exposing [TemplateRepository] domain contract interface.
final templateRepositoryProvider = Provider<TemplateRepository>((ref) {
  final localDataSource = ref.watch(templateLocalDataSourceProvider);
  return TemplateRepositoryImpl(localDataSource);
});

/// Provider exposing [SettingsRepository] domain contract interface.
final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  final localDataSource = ref.watch(settingsLocalDataSourceProvider);
  return SettingsRepositoryImpl(localDataSource);
});
