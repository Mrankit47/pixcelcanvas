import 'package:flutter/material.dart';
import 'package:pixelcanvas/shared/widgets/pc_text_field.dart';

/// Templates search bar component per Blueprint §5.1.
///
/// **Purpose**: Search input field for filtering starter templates.
/// **Parameters**:
/// - [onSearch]: Callback emitting search query text.
///
/// **Future Extension Notes**: Search query will filter `TemplateRepository` items.
class TemplatesSearchBar extends StatelessWidget {
  /// Creates a [TemplatesSearchBar].
  const TemplatesSearchBar({
    this.onSearch,
    super.key,
  });

  /// Search query callback.
  final ValueChanged<String>? onSearch;

  @override
  Widget build(BuildContext context) => PcTextField(
        variant: PcTextFieldVariant.search,
        hintText: 'Search templates by name, size or tag...',
        onChanged: onSearch,
      );
}
