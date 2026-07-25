import 'package:flutter/material.dart';
import 'package:pixelcanvas/shared/widgets/pc_button.dart';

/// Skip button for onboarding flow per Blueprint §5.1.
///
/// **Purpose**: Allows user to skip remaining onboarding pages.
/// **Parameters**:
/// - [onPressed]: Callback when tapped.
///
/// **Future Extension Notes**: Exposes callback only; zero navigation logic.
class SkipButton extends StatelessWidget {
  /// Creates a [SkipButton].
  const SkipButton({
    required this.onPressed,
    super.key,
  });

  /// Tap callback.
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => PcButton(
        label: 'Skip',
        variant: PcButtonVariant.ghost,
        size: PcButtonSize.small,
        onPressed: onPressed,
      );
}
