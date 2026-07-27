import 'package:pixelcanvas/features/export/models/export_format.dart';

/// Diagnostic report for export validation.
class ExportValidationReport {
  const ExportValidationReport({
    required this.isValid,
    this.errorMessage,
    required this.estimatedFileSizeBytes,
  });

  final bool isValid;
  final String? errorMessage;
  final int estimatedFileSizeBytes;

  String get formattedEstimatedSize {
    final kb = estimatedFileSizeBytes / 1024;
    return '${kb.toStringAsFixed(1)} KB';
  }
}

/// Service validating export parameters and estimating output sizes.
class ExportValidator {
  /// Validates export parameters for canvas dimensions and format.
  static ExportValidationReport validate({
    required String fileName,
    required int width,
    required int height,
    required int scaleFactor,
    required ExportFormat format,
  }) {
    if (fileName.trim().isEmpty) {
      return const ExportValidationReport(
        isValid: false,
        errorMessage: 'File name cannot be empty',
        estimatedFileSizeBytes: 0,
      );
    }

    final totalPx = width * height * scaleFactor * scaleFactor;
    // Estimate bytes (4 bytes per ARGB pixel)
    final estimatedBytes = (totalPx * 4 * 0.35).round();

    return ExportValidationReport(
      isValid: true,
      estimatedFileSizeBytes: estimatedBytes,
    );
  }
}
