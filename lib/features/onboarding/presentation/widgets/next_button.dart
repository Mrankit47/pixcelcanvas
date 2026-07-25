import 'package:flutter/material.dart';
import 'package:pixelcanvas/shared/widgets/pc_button.dart';

/// Next button for advancing onboarding pages per Blueprint §5.1.
///
/// **Purpose**: Advances to next onboarding page in sequence.
/// **Parameters**:
/// - [onPressed]: Callback when tapped.
///
/// **Future Extension Notes**: Exposes callback only; zero navigation logic.
class NextButton extends StatelessWidget {
  /// Creates a [NextButton].
  const NextButton({
    required this.onPressed,
    super.key,
  });

  /// Tap callback.
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => PcButton(
        label: 'Next',
        variant: PcButtonVariant.primary,
        trailingIcon: Icons.arrow_forward_rounded,
        onPressed: onPressed,
      );
}
