import 'package:pixelcanvas/features/export/models/export_format.dart';

/// File naming strategy parsing tokens for export files.
class FileNamingStrategy {
  /// Resolves filename template string using replacement tokens.
  ///
  /// Supported tokens: `{project}`, `{resolution}`, `{date}`, `{scale}`
  static String formatFileName({
    required String pattern,
    required String projectName,
    required int width,
    required int height,
    required int scale,
    required ExportFormat format,
  }) {
    final now = DateTime.now();
    final dateStr = '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}';
    final resStr = '${width * scale}x${height * scale}';

    var name = pattern
        .replaceAll('{project}', projectName)
        .replaceAll('{resolution}', resStr)
        .replaceAll('{date}', dateStr)
        .replaceAll('{scale}', '${scale}x');

    if (!name.endsWith('.${format.extension}')) {
      name = '$name.${format.extension}';
    }

    return name;
  }
}
