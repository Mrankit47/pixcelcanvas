import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixelcanvas/core/di/use_case_providers.dart';
import 'package:pixelcanvas/core/domain/use_case.dart';
import 'package:pixelcanvas/features/templates/application/use_cases/get_templates.dart';
import 'package:pixelcanvas/features/templates/domain/entities/template.dart';
import 'package:pixelcanvas/features/templates/presentation/state/templates_state.dart';

/// Riverpod Controller managing Templates Browser presentation state per Blueprint §6.3.
class TemplatesController extends StateNotifier<TemplatesState> {
  /// Creates a [TemplatesController].
  TemplatesController({
    required GetTemplates getTemplates,
  })  : _getTemplates = getTemplates,
        super(const TemplatesState());

  final GetTemplates _getTemplates;

  /// Loads starter templates list.
  Future<void> loadTemplates() async {
    state = state.copyWith(isLoading: true, errorMessage: () => null);
    final result = await _getTemplates(const NoParams());
    result.fold(
      (templates) => state = state.copyWith(templates: templates, isLoading: false),
      (failure) => state = state.copyWith(isLoading: false, errorMessage: () => failure.message),
    );
  }

  /// Selects a template.
  void selectTemplate(Template? template) {
    state = state.copyWith(selectedTemplate: () => template);
  }
}

/// Riverpod provider for [TemplatesController].
final templatesControllerProvider = StateNotifierProvider<TemplatesController, TemplatesState>((ref) {
  return TemplatesController(
    getTemplates: ref.watch(getTemplatesProvider),
  );
});
