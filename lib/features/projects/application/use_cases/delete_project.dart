import 'package:pixelcanvas/core/domain/result.dart';
import 'package:pixelcanvas/core/domain/use_case.dart';
import 'package:pixelcanvas/core/domain/value_objects/identifiers.dart';
import 'package:pixelcanvas/features/projects/domain/repositories/project_repository.dart';

/// Concrete Use Case deleting a project per Blueprint §6.1.
class DeleteProject implements UseCase<ProjectId, void> {
  /// Creates a [DeleteProject] usecase.
  const DeleteProject(this._projectRepository);

  final ProjectRepository _projectRepository;

  @override
  Future<Result<void>> call(ProjectId params) => _projectRepository.deleteProject(params);
}
