/// Supported export formats per Blueprint §7.6.
enum ExportFormat {
  png,
  jpeg,
  webp,
  gif,
  apng,
  spriteSheet,
  pdfContactSheet,
  zipPackage,
  jsonManifest,
}

/// Helper extension on [ExportFormat].
extension ExportFormatExtension on ExportFormat {
  /// File extension string.
  String get extension {
    switch (this) {
      case ExportFormat.png:
      case ExportFormat.apng:
      case ExportFormat.spriteSheet:
        return 'png';
      case ExportFormat.jpeg:
        return 'jpg';
      case ExportFormat.webp:
        return 'webp';
      case ExportFormat.gif:
        return 'gif';
      case ExportFormat.pdfContactSheet:
        return 'pdf';
      case ExportFormat.zipPackage:
        return 'zip';
      case ExportFormat.jsonManifest:
        return 'json';
    }
  }

  /// Display label.
  String get label {
    switch (this) {
      case ExportFormat.png:
        return 'PNG Image';
      case ExportFormat.jpeg:
        return 'JPEG Image';
      case ExportFormat.webp:
        return 'WebP Image';
      case ExportFormat.gif:
        return 'Animated GIF';
      case ExportFormat.apng:
        return 'Animated PNG (APNG)';
      case ExportFormat.spriteSheet:
        return 'Sprite Sheet Grid';
      case ExportFormat.pdfContactSheet:
        return 'PDF Contact Sheet';
      case ExportFormat.zipPackage:
        return 'ZIP Project Package';
      case ExportFormat.jsonManifest:
        return 'JSON Manifest';
    }
  }
}
