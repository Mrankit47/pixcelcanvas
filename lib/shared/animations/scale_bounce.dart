import 'package:flutter/material.dart';

/// Scale-bounce micro-animation wrapper template per Blueprint §8.1.
class ScaleBounce extends StatelessWidget {
  /// Creates a [ScaleBounce] template.
  const ScaleBounce({
    required this.child,
    super.key,
  });

  /// Child widget to animate.
  final Widget child;

  @override
  Widget build(BuildContext context) => child;
}
