import 'package:equatable/equatable.dart';
import 'package:pixelcanvas/features/templates/domain/entities/template.dart';

/// Immutable State object for Templates Browser per Blueprint §6.3.
class TemplatesState extends Equatable {
  /// Creates a [TemplatesState].
  const TemplatesState({
    this.templates = const [],
    this.selectedTemplate,
    this.isLoading = false,
    this.errorMessage,
  });

  /// Templates list.
  final List<Template> templates;

  /// Selected template entity or null.
  final Template? selectedTemplate;

  /// Loading status flag.
  final bool isLoading;

  /// Error message string or null.
  final String? errorMessage;

  /// Copy with support.
  TemplatesState copyWith({
    List<Template>? templates,
    Template? Function()? selectedTemplate,
    bool? isLoading,
    String? Function()? errorMessage,
  }) =>
      TemplatesState(
        templates: templates ?? this.templates,
        selectedTemplate: selectedTemplate != null ? selectedTemplate() : this.selectedTemplate,
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
      );

  @override
  List<Object?> get props => [templates, selectedTemplate, isLoading, errorMessage];
}
