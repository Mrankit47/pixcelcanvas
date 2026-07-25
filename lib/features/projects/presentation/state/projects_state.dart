import 'package:equatable/equatable.dart';
import 'package:pixelcanvas/features/projects/domain/entities/project.dart';

/// Immutable State object for Projects Gallery per Blueprint §6.3.
class ProjectsState extends Equatable {
  /// Creates a [ProjectsState].
  const ProjectsState({
    this.projects = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  /// Projects list.
  final List<Project> projects;

  /// Loading status flag.
  final bool isLoading;

  /// Error message string or null.
  final String? errorMessage;

  /// Copy with support.
  ProjectsState copyWith({
    List<Project>? projects,
    bool? isLoading,
    String? Function()? errorMessage,
  }) =>
      ProjectsState(
        projects: projects ?? this.projects,
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
      );

  @override
  List<Object?> get props => [projects, isLoading, errorMessage];
}
