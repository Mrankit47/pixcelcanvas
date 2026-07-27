# Move / Copy / Cut / Paste Engine — Technical Documentation

> **Phase**: 5 – Step 2  
> **Version**: 1.0.0  
> **Status**: Production-Ready  

---

## 1. Overview

The Move / Copy / Cut / Paste Engine expands upon the Selection Engine Foundation (Phase 5 Step 1) by enabling pixel manipulation, clipboard operations, temporary floating selections during drag, and full history integration via the Command Pattern.

### Key Architecture Principles

1. **Clean Architecture & Decoupled Design**: The clipboard and move engines have zero dependencies on Riverpod, Isar, Supabase, Repositories, or UI Widgets.
2. **Pixel-Perfect Operations**: All selection movements operate directly on integer canvas coordinates without sub-pixel interpolation or scaling artifacts.
3. **Single-Step History Integrity**: Entire move sequences (lifting source pixels, dragging, and committing to destination) are committed to `HistoryManager` as **ONE** `MoveSelectionCommand`.
4. **Independent Floating Selection Overlay**: During movement or after pasting, pixels float in a temporary `FloatingSelection` buffer rendered above normal canvas layers until explicitly committed or cancelled.
5. **Strict Layer Validation**: Selection operations respect layer locks (`isLocked`) and visibility (`isVisible`). Attempting to move or edit locked/hidden layers is safely ignored.

---

## 2. Clipboard Lifecycle

```
       ┌───────────────────────────────┐
       │     Active Selection Region    │
       └───────────────┬───────────────┘
                       │
             ┌─────────┴─────────┐
             │                   │
      copySelection()      cutSelection()
             │                   │
             │           (Clears Source Pixels +
             │            Pushes CutSelectionCommand)
             │                   │
             └─────────┬─────────┘
                       ▼
              ┌─────────────────┐
              │  ClipboardData  │
              └────────┬────────┘
                       │
                pasteSelection()
                       │
                       ▼
            ┌─────────────────────┐
            │  FloatingSelection  │
            └─────────────────────┘
```

1. **Copy**: `CanvasEngine.copySelection()` reads pixels within the selection bounds from the active layer and stores them in `ClipboardManager`. Records a `CopySelectionCommand` for history log completeness.
2. **Cut**: `CanvasEngine.cutSelection()` copies pixels to `ClipboardManager`, clears the source pixels from the active layer, and pushes a `CutSelectionCommand` (recording `PixelDelta` items for undo).
3. **Paste**: `CanvasEngine.pasteSelection()` reads `ClipboardData` and instantiates a `FloatingSelection` positioned at the original bounds, allowing the user to reposition it before committing.

---

## 3. Floating Selection Lifecycle & Movement Algorithm

### Lifecycle

```
    ┌─────────────────────┐
    │  beginMoveSelection │   or  pasteSelection()
    └──────────┬──────────┘
               │ (Lifts pixels to FloatingSelection & clears source)
               ▼
    ┌─────────────────────┐
    │ updateMoveSelection │ <── Drag interaction (dx, dy)
    └──────────┬──────────┘
               │
      ┌────────┴────────┐
      │                 │
commitMoveSelection()  cancelMoveSelection()
      │                 │
      ▼                 ▼
(Writes pixels &      (Restores source pixels,
 pushes Command)       discards floating selection)
```

### Movement Algorithm

- Movement is strictly integer-based on the canvas grid (dx, dy).
- `FloatingSelection` tracks `offsetX` and `offsetY` relative to `originalBounds`.
- `currentBounds` is computed dynamically as:
  `SelectionBounds(left: orig.left + offsetX, top: orig.top + offsetY, right: orig.right + offsetX, bottom: orig.bottom + offsetY)`
- During rendering, `FloatingSelectionRenderer` draws pixels at `(bounds.left + localX, bounds.top + localY)`.

---

## 4. History / Undo Strategy

| Action | Command Class | Undo Behavior |
|--------|---------------|---------------|
| Copy | `CopySelectionCommand` | No-op on canvas pixels |
| Cut | `CutSelectionCommand` | Restores cleared source pixels |
| Paste | `PasteSelectionCommand` | Reverts written destination pixels |
| Move | `MoveSelectionCommand` | Reverts destination writes AND restores source pixels |

### Atomic Move Command

When `commitMoveSelection()` is called:
1. Destination pixel writes generate `destDeltas`.
2. Source clearing pixel deltas collected during `beginMoveSelection()` are combined into `sourceDeltas`.
3. A single `MoveSelectionCommand(sourceDeltas, destDeltas)` is executed and added to `HistoryManager`.
4. Reversing this single command cleanly restores the source pixels and removes the destination pixels.

---

## 5. Memory Strategy

- **No Full Canvas Copy**: Only pixels contained within the `SelectionBounds` bounding box are extracted and stored in `ClipboardData` or `FloatingSelection`.
- **Sparse Non-Empty Tracking**: `PixelDelta` records store `oldPixel` and `newPixel` states only for affected coordinates.
- **Buffer Reuse**: Floating selections use single row-major 1D arrays (`List<Pixel>`) matching the selection dimension (`width * height`), maintaining low heap overhead even on canvases up to 4096×4096.

---

## 6. Future Platform Clipboard Integration

`ClipboardSerializer` is provided as a placeholder interface for future integration with OS clipboard APIs:

- **JSON Format**: Web / Desktop platform text copy (e.g. metadata + Base64 RGBA stream).
- **Binary Format**: System native MIME type `application/x-pixelcanvas-selection`.
- When platform clipboard support is introduced, `ClipboardManager` will serialize `ClipboardData` into `ClipboardSerializer` output without breaking internal engine contracts.

---

## 7. File Structure

```
lib/features/editor/engine/
├── clipboard/
│   ├── clipboard_data.dart        # Immutable pixel & bounds snapshot
│   ├── clipboard_manager.dart     # Clipboard state holder & extractor
│   └── clipboard_serializer.dart  # Future binary/JSON serializer placeholder
├── floating_selection/
│   ├── floating_selection.dart    # Temporary moving pixel buffer container
│   └── floating_selection_renderer.dart # Independent overlay renderer
└── commands/
    ├── move_selection_command.dart # Atomic move command (source + dest deltas)
    ├── copy_selection_command.dart # Copy log command
    ├── cut_selection_command.dart  # Undoable cut command
    └── paste_selection_command.dart# Undoable paste command
```
