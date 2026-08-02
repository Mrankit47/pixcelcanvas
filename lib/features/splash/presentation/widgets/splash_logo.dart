import 'package:flutter/material.dart';
import 'package:pixelcanvas/shared/widgets/pixel_logo_widget.dart';

/// PixelCanvas branded logo mark widget for the Splash screen per Blueprint §5.1 & Version 1.0 Design System.
class SplashLogo extends StatelessWidget {
  /// Creates a [SplashLogo].
  const SplashLogo({
    this.size = 120.0,
    super.key,
  });

  /// Logo container size.
  final double size;

  @override
  Widget build(BuildContext context) => Semantics(
        label: 'PixelCanvas Brand Logo',
        image: true,
        child: PixelLogoWidget(
          size: size,
          showTagline: true,
        ),
      );
}
