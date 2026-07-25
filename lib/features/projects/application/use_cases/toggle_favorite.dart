import 'package:pixelcanvas/core/domain/result.dart';
import 'package:pixelcanvas/core/domain/use_case.dart';
import 'package:pixelcanvas/core/domain/value_objects/identifiers.dart';
import 'package:pixelcanvas/features/projects/domain/entities/project.dart';
import 'package:pixelcanvas/features/projects/domain/repositories/project_repository.dart';

/// Concrete Use Case toggling project favorite status per Blueprint §6.1.
class ToggleFavorite implements UseCase<ProjectId, Project> {
  /// Creates a [ToggleFavorite] usecase.
  const ToggleFavorite(this._projectRepository);

  final ProjectRepository _projectRepository;

  @override
  Future<Result<Project>> call(ProjectId params) => _projectRepository.toggleFavorite(params);
}
