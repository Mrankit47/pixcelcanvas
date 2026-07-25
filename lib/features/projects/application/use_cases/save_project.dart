import 'package:pixelcanvas/core/domain/result.dart';
import 'package:pixelcanvas/core/domain/use_case.dart';
import 'package:pixelcanvas/features/projects/domain/entities/project.dart';
import 'package:pixelcanvas/features/projects/domain/repositories/project_repository.dart';

/// Concrete Use Case saving or updating a project per Blueprint §6.1.
class SaveProject implements UseCase<Project, Project> {
  /// Creates a [SaveProject] usecase.
  const SaveProject(this._projectRepository);

  final ProjectRepository _projectRepository;

  @override
  Future<Result<Project>> call(Project params) => _projectRepository.saveProject(params);
}
