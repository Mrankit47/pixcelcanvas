import 'package:flutter/material.dart';

/// Slide-up animation wrapper template per Blueprint §8.1.
class SlideUp extends StatelessWidget {
  /// Creates a [SlideUp] template.
  const SlideUp({
    required this.child,
    super.key,
  });

  /// Child widget to animate.
  final Widget child;

  @override
  Widget build(BuildContext context) => child;
}
