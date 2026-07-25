import 'package:flutter/material.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';
import 'package:pixelcanvas/theme/app_typography.dart';

/// Bottom status bar metadata container for Pixel Editor per Blueprint §5.1 & §8.2.
///
/// **Purpose**: Displays canvas dimensions, zoom ratio, live cursor coordinates, and active layer count.
/// **Parameters**:
/// - [canvasDimensions]: Canvas size label (default: "32 × 32 px").
/// - [zoomLevel]: Zoom level label (default: "100%").
/// - [cursorCoordinates]: Cursor X/Y position string (default: "X: 16, Y: 16").
/// - [layerCount]: Active layer count string (default: "3 Layers").
///
/// **Future Extension Notes**: Cursor coordinates will update live on hover in Phase 4.
class BottomStatusBar extends StatelessWidget {
  /// Creates a [BottomStatusBar].
  const BottomStatusBar({
    this.canvasDimensions = '32 × 32 px',
    this.zoomLevel = '100%',
    this.cursorCoordinates = 'X: 16, Y: 16',
    this.layerCount = '3 Layers',
    super.key,
  });

  /// Canvas dimensions string.
  final String canvasDimensions;

  /// Zoom ratio string.
  final String zoomLevel;

  /// Cursor position string.
  final String cursorCoordinates;

  /// Layer count string.
  final String layerCount;

  @override
  Widget build(BuildContext context) => Container(
        height: 28,
        decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(top: BorderSide(color: AppColors.neutral200)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        child: Row(
          children: [
            _buildStatusItem(Icons.aspect_ratio_rounded, canvasDimensions),
            const SizedBox(width: AppSpacing.md),
            _buildStatusItem(Icons.zoom_in_rounded, zoomLevel),
            const SizedBox(width: AppSpacing.md),
            _buildStatusItem(Icons.mouse_rounded, cursorCoordinates),
            const Spacer(),
            _buildStatusItem(Icons.layers_outlined, layerCount),
          ],
        ),
      );

  Widget _buildStatusItem(IconData icon, String text) => Row(
        children: [
          Icon(icon, size: 14, color: AppColors.neutral400),
          const SizedBox(width: AppSpacing.xxs),
          Text(
            text,
            style: AppTypography.labelSmall.copyWith(
              color: AppColors.neutral400,
              fontSize: 11,
            ),
          ),
        ],
      );
}
