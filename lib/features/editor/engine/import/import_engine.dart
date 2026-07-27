import 'dart:typed_data';

import 'package:pixelcanvas/features/editor/engine/import/models/import_preview.dart';
import 'package:pixelcanvas/features/editor/engine/import/models/import_settings.dart';
import 'package:pixelcanvas/features/editor/engine/import/tools/image_importer.dart';

/// Stateful manager coordinating live import preview and commit lifecycle.
///
/// **Purpose**: Maintains active PNG import raw bytes, settings, and preview state.
/// **Architecture**: Pure Dart — no Riverpod, Widgets, or framework dependencies.
class ImportEngine {
  /// Current import settings configuration.
  ImportSettings settings = const ImportSettings();

  /// Raw byte payload of the active image being imported.
  Uint8List? _rawBytes;

  /// Active import preview state container, or null if idle.
  ImportPreview? _preview;

  /// Active import preview state getter.
  ImportPreview? get preview => _preview;

  /// True if an import session is currently active with a valid preview.
  bool get hasActiveImport =>
      _preview != null && !_preview!.isCorrupted && _preview!.isVisible;

  /// Starts an import session for [bytes] with [settings] and canvas dimensions.
  ImportPreview importImage({
    required Uint8List bytes,
    required int canvasWidth,
    required int canvasHeight,
    ImportSettings? settings,
  }) {
    _rawBytes = bytes;
    if (settings != null) {
      this.settings = settings;
    }

    _preview = ImageImporter.processImport(
      bytes: bytes,
      settings: this.settings,
      canvasWidth: canvasWidth,
      canvasHeight: canvasHeight,
    );

    return _preview!;
  }

  /// Re-processes current import with updated [settings].
  ImportPreview? updateSettings({
    required ImportSettings settings,
    required int canvasWidth,
    required int canvasHeight,
  }) {
    this.settings = settings;
    if (_rawBytes == null) return null;

    _preview = ImageImporter.processImport(
      bytes: _rawBytes!,
      settings: settings,
      canvasWidth: canvasWidth,
      canvasHeight: canvasHeight,
    );

    return _preview;
  }

  /// Commits current import preview and clears engine state.
  ImportPreview? commitImport() {
    final active = _preview;
    _preview = null;
    _rawBytes = null;
    return active;
  }

  /// Cancels active import session and clears preview state.
  void cancelImport() {
    _preview = null;
    _rawBytes = null;
  }
}
