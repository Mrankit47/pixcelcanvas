import 'dart:convert';
import 'dart:typed_data';

import 'package:pixelcanvas/features/project_creation/models/template_metadata.dart';

/// Memory RAM PNG byte cache for template thumbnails.
class TemplateThumbnailCache {
  static final Map<String, Uint8List> _cache = {};

  /// Returns cached PNG bytes for [metadata], decoding base64 lazily if absent.
  static Uint8List? getThumbnail(TemplateMetadata metadata) {
    if (_cache.containsKey(metadata.id)) {
      return _cache[metadata.id];
    }

    if (metadata.previewPngBase64 != null && metadata.previewPngBase64!.isNotEmpty) {
      try {
        final bytes = base64.decode(metadata.previewPngBase64!);
        _cache[metadata.id] = bytes;
        return bytes;
      } catch (_) {
        return null;
      }
    }

    return null;
  }

  /// Invalidates thumbnail cache entry for [templateId].
  static void invalidate(String templateId) {
    _cache.remove(templateId);
  }

  /// Clears thumbnail cache memory.
  static void clear() {
    _cache.clear();
  }
}
