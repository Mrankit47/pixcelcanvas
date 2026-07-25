import 'package:pixelcanvas/core/domain/result.dart';
import 'package:pixelcanvas/core/domain/use_case.dart';
import 'package:pixelcanvas/core/domain/value_objects/identifiers.dart';
import 'package:pixelcanvas/features/projects/domain/entities/project.dart';
import 'package:pixelcanvas/features/projects/domain/repositories/project_repository.dart';

/// Concrete Use Case fetching a single project by ID per Blueprint §6.1.
class GetProjectById implements UseCase<ProjectId, Project> {
  /// Creates a [GetProjectById] usecase.
  const GetProjectById(this._projectRepository);

  final ProjectRepository _projectRepository;

  @override
  Future<Result<Project>> call(ProjectId params) => _projectRepository.getProjectById(params);
}
