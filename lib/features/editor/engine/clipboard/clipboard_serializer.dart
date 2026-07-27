import 'package:pixelcanvas/features/editor/engine/clipboard/clipboard_data.dart';

/// Future-ready serialization utility for clipboard data.
///
/// **Phase 5 Step 2**: Placeholder class with stub implementations.
///
/// **Future**: When platform clipboard integration is added, this class will
/// handle serialization of [ClipboardData] to/from binary or JSON format
/// for cross-app or cross-device clipboard sharing.
///
/// **Planned formats**:
/// - Binary: Compact pixel buffer with header (width, height, bounds, metadata)
/// - JSON: Human-readable format for debugging and web clipboard API
class ClipboardSerializer {
  /// Serializes [data] into a binary byte list.
  ///
  /// **Stub**: Returns empty list. Will be implemented when platform clipboard
  /// integration is added.
  static List<int> serialize(ClipboardData data) {
    // Future: Encode header (width, height, bounds) + pixel RGBA data
    return const [];
  }

  /// Deserializes a binary byte list into [ClipboardData].
  ///
  /// **Stub**: Returns null. Will be implemented when platform clipboard
  /// integration is added.
  static ClipboardData? deserialize(List<int> bytes) {
    // Future: Decode header + pixel data
    return null;
  }
}
