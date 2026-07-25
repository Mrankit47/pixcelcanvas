import 'package:pixelcanvas/core/domain/result.dart';
import 'package:pixelcanvas/core/domain/use_case.dart';
import 'package:pixelcanvas/features/projects/domain/entities/project.dart';
import 'package:pixelcanvas/features/projects/domain/repositories/project_repository.dart';

/// Concrete Use Case retrieving user projects per Blueprint §6.1.
class GetProjects implements UseCase<NoParams, List<Project>> {
  /// Creates a [GetProjects] usecase.
  const GetProjects(this._projectRepository);

  final ProjectRepository _projectRepository;

  @override
  Future<Result<List<Project>>> call(NoParams params) => _projectRepository.getProjects();
}
