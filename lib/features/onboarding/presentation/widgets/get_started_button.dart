import 'package:flutter/material.dart';
import 'package:pixelcanvas/shared/widgets/pc_button.dart';

/// Hero action CTA button displayed on final onboarding page per Blueprint §5.1.
///
/// **Purpose**: Triggers onboarding completion.
/// **Parameters**:
/// - [onPressed]: Callback when tapped.
///
/// **Future Extension Notes**: Exposes callback only; zero navigation logic.
class GetStartedButton extends StatelessWidget {
  /// Creates a [GetStartedButton].
  const GetStartedButton({
    required this.onPressed,
    super.key,
  });

  /// Tap callback.
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => PcButton(
        label: 'Get Started',
        variant: PcButtonVariant.primary,
        size: PcButtonSize.large,
        trailingIcon: Icons.rocket_launch_rounded,
        fullWidth: true,
        onPressed: onPressed,
      );
}
