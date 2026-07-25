import 'package:flutter/material.dart';
import 'package:pixelcanvas/shared/widgets/pc_empty_state.dart';

/// Empty state container for Templates Browser per Blueprint §5.1.
///
/// **Purpose**: Displayed when search yields 0 templates.
/// **Parameters**:
/// - [onBrowseAll]: Callback when Browse All button is tapped.
///
/// **Future Extension Notes**: Triggered dynamically when `TemplateRepository` query returns empty.
class EmptyTemplatesState extends StatelessWidget {
  /// Creates an [EmptyTemplatesState].
  const EmptyTemplatesState({
    this.onBrowseAll,
    super.key,
  });

  /// Browse all callback.
  final VoidCallback? onBrowseAll;

  @override
  Widget build(BuildContext context) => PcEmptyState(
        title: 'No Templates Found',
        message: 'No starter templates match your current query or category filter.',
        icon: Icons.grid_view_rounded,
        actionLabel: 'Browse All Templates',
        onAction: onBrowseAll,
      );
}
