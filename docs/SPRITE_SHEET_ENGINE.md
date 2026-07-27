# Sprite Sheet Engine & Frame Management — Technical Documentation

> **Phase**: 5 – Step 6  
> **Version**: 1.0.0  
> **Status**: Production-Ready  

---

## 1. Overview

The Sprite Sheet Engine & Frame Management system provides comprehensive sprite sheet importing, grid/manual slicing, frame organization, tagging, metadata tracking, thumbnail rendering/caching, and export options (PNG sprite sheet, individual frame PNGs, JSON metadata).

### Key Architecture Principles

1. **Clean Architecture & Pure Engine Logic**: The sprite sheet engine has zero dependencies on Riverpod, Isar, Supabase, Repositories, or UI Widgets.
2. **Grid & Manual Slicing**: Automatic grid slicing by cell size, padding, margins, and offsets, plus manual slicing via rectangle selection bounds.
3. **Single-Step History Integrity**: Every frame action (import, slice, create, duplicate, delete, rename, reorder) records as **ONE** history command in `HistoryManager`.
4. **Lazy Thumbnail Caching**: Thumbnails are generated lazily and cached as RAM PNG byte buffers (`Uint8List`) for 60 FPS preview strip rendering.
5. **Flexible Exporting**: Supports packed PNG sprite sheets, individual frame PNG bundles, and JSON metadata specifications.

---

## 2. Sprite Sheet Data Models

### 1. `SpriteSheet`
Container representing the complete sprite sheet asset:
- `id`, `name`: Asset identification.
- `width`, `height`: Total sheet matrix dimensions.
- `frames`: Ordered `List<SpriteFrame>`.
- `activeFrameIndex`: Currently selected frame index.
- `settings`: `SpriteSheetSettings`.

### 2. `SpriteFrame`
Individual frame container:
- `metadata`: `FrameMetadata` (ID, name, width, height, originX, originY, durationMs, tags, layerIds).
- `bounds`: `SelectionBounds` (Position in sheet/canvas).
- `pixels`: `List<Pixel>` (1D row-major pixel buffer).
- `thumbnailBytes`: `Uint8List?` (Lazy PNG preview cache).

### 3. `FrameTag`
Animation category tag classifications:
- Presets: `Idle`, `Walk`, `Run`, `Jump`, `Attack`.
- Custom: `FrameTag.custom('Special')`.

---

## 3. Slicing Algorithms & Workflows

### 1. Automatic Grid Slicer (`FrameGridSlicer`)

Iterates through sheet coordinates:
- $Y$ loop: Starts at $\text{offsetY} + \text{marginY}$, steps by $\text{cellHeight} + \text{paddingY}$.
- $X$ loop: Starts at $\text{offsetX} + \text{marginX}$, steps by $\text{cellWidth} + \text{paddingX}$.
- Extracts $\text{cellWidth} \times \text{cellHeight}$ pixels per frame.
- Auto-assigns sequential labels: `Frame_0`, `Frame_1`, `Frame_2`, etc.

### 2. Manual Selection Slicer (`FrameManualSlicer`)

- Takes active `SelectionBounds` from `SelectionEngine`.
- Extracts bounding box sub-region into a standalone `SpriteFrame`.

---

## 4. Import & Export Architecture

### Importer (`FrameImporter`)
- `importFromPngBytes()`: Decodes PNG bytes, extracts sheet dimensions, and auto-slices frames according to grid settings.
- `parseJsonMetadata()`: Parses standard JSON frame descriptors into `FrameMetadata` objects.

### Exporter (`FrameExporter`)
- `exportSpriteSheetPng()`: Re-packs frames into a single unified PNG binary data payload (`Uint8List`).
- `exportIndividualFramePngs()`: Generates a map of frame names to individual PNG byte buffers (`Map<String, Uint8List>`).
- `exportJsonMetadata()`: Exports standard JSON metadata detailing frame filenames, coordinates $(x, y, w, h)$, durations, and animation tags.

---

## 5. History & Undo Strategy

| Action | Command Class | Undo Behavior |
|--------|---------------|---------------|
| Import Sheet | `ImportSpriteSheetCommand` | Restores previous frame list |
| Create Frame | `CreateFrameCommand` | Deletes created frame |
| Delete Frame | `DeleteFrameCommand` | Re-inserts deleted frame snapshot |
| Duplicate Frame | `DuplicateFrameCommand` | Deletes duplicated frame |
| Rename Frame | `RenameFrameCommand` | Restores original frame name |
| Reorder Frame | `ReorderFrameCommand` | Reverts frame index order |

Every completed frame action collapses into **ONE** history command in `HistoryManager`.

---

## 6. Performance & Memory Strategy

- **Lazy Thumbnail Generation**: Thumbnails are generated on-demand when rendered in UI strips and cached in memory.
- **Cache Invalidation**: Any pixel modification to a frame invalidates `thumbnailBytes = null`.
- **Zero Double-Allocation**: Frame slicing copies pixels directly into 1D arrays without intermediate canvas objects.

---

## 7. Future Expansion Architecture

- **Animation Timeline**: Frame timing (`durationMs`) and tags (`FrameTag`) are already stored in `FrameMetadata`, ready for Timeline playback integration.
- **Aseprite & TexturePacker Compatibility**: Exporter is structured to support Aseprite JSON and TexturePacker formats.

---

## 8. File Structure

```
lib/features/editor/engine/
├── sprite_sheet/
│   ├── models/
│   │   ├── frame_tag.dart             # FrameTag classification enum/class
│   │   ├── frame_metadata.dart        # FrameMetadata model (ID, name, origin, duration, tags)
│   │   ├── sprite_frame.dart          # SpriteFrame container & thumbnail cache
│   │   ├── sprite_sheet_settings.dart # Grid slice settings (cell size, padding, margin, offset)
│   │   ├── sprite_sheet.dart          # SpriteSheet container asset
│   │   └── frame_selection.dart       # Active frame selection state
│   ├── tools/
│   │   ├── frame_grid_slicer.dart     # Automatic grid slicer algorithm
│   │   ├── frame_manual_slicer.dart   # Manual selection bounds slicer algorithm
│   │   ├── frame_importer.dart        # PNG + JSON importer
│   │   └── frame_exporter.dart        # Packed PNG, individual PNGs, and JSON metadata exporter
│   ├── frame_renderer.dart            # Lazy thumbnail generator and cache manager
│   └── sprite_sheet_engine.dart       # Central sprite sheet engine manager
└── commands/
    ├── import_sprite_sheet_command.dart # Reversible sprite sheet import history command
    ├── create_frame_command.dart        # Reversible create frame history command
    ├── delete_frame_command.dart        # Reversible delete frame history command
    ├── duplicate_frame_command.dart     # Reversible duplicate frame history command
    ├── rename_frame_command.dart        # Reversible rename frame history command
    └── reorder_frame_command.dart       # Reversible reorder frame history command
```
