import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/project_dashboard/models/project_metadata.dart';
import 'package:pixelcanvas/features/project_dashboard/services/thumbnail_cache.dart';

/// Thumbnail widget rendering project preview or checkerboard fallback.
class ProjectThumbnail extends StatelessWidget {
  /// Creates a [ProjectThumbnail].
  const ProjectThumbnail({
    super.key,
    required this.metadata,
    this.height = 120,
  });

  final ProjectMetadata metadata;
  final double height;

  @override
  Widget build(BuildContext context) {
    final bytes = ThumbnailCache.getThumbnail(metadata);

    return Container(
      height: height,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF181825),
        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
        child: bytes != null
            ? Image.memory(
                bytes,
                fit: BoxFit.contain,
                filterQuality: FilterQuality.none, // Pixelated nearest-neighbor
              )
            : CustomPaint(
                painter: _CheckerboardPainter(),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.grid_on_rounded, size: 28, color: Colors.white24),
                      const SizedBox(height: 4),
                      Text(
                        metadata.resolutionString,
                        style: const TextStyle(color: Colors.white38, fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class _CheckerboardPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const cellSize = 12.0;
    final paintLight = Paint()..color = const Color(0xFF1E1E2E);
    final paintDark = Paint()..color = const Color(0xFF181825);

    final cols = (size.width / cellSize).ceil();
    final rows = (size.height / cellSize).ceil();

    for (var r = 0; r < rows; r++) {
      for (var c = 0; c < cols; c++) {
        final paint = (r + c) % 2 == 0 ? paintLight : paintDark;
        canvas.drawRect(
          Rect.fromLTWH(c * cellSize, r * cellSize, cellSize, cellSize),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
