# Thumbnail Cache Architecture

> **Phase**: 7 – Step 2  
> **Version**: 1.0.0  

---

## 1. Overview

`ThumbnailCache` optimizes RAM memory usage when displaying project cards on the dashboard grid:

1. **Lazy Base64 Decoding**: Base64 preview PNG strings are decoded into raw `Uint8List` image byte arrays only when a project card comes into view.
2. **RAM Map Caching**: Decoded byte arrays are cached in a static memory map keyed by project ID to prevent redundant decoding overhead.
3. **Invalidation**: `ThumbnailCache.invalidate(id)` purges cached thumbnail memory whenever a project is edited or deleted.
