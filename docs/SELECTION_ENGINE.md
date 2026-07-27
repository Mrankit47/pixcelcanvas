# Selection Engine — Technical Documentation

> **Phase**: 5 – Step 1  
> **Version**: 1.0.0  
> **Status**: Rectangle selection implemented  

---

## 1. Overview

The Selection Engine provides a geometry-only selection system for the PixelCanvas editor. It supports creating, resizing, and clearing rectangular selections with an independent overlay renderer.

### Architecture Principles

- **Geometry-only storage** — no pixel data is ever copied or stored by the selection engine
- **Framework-independent** — the engine core has zero dependencies on Riverpod, Isar, Supabase, or Flutter widgets
- **Separate rendering** — selection overlay renders independently of the pixel canvas drawing pipeline
- **Performance** — O(1) rectangle containment; supports canvases up to 4096×4096

---

## 2. Selection Lifecycle

```
┌──────────────┐    ┌──────────────────┐    ┌────────────────┐    ┌──────────────────┐
│ beginSelection│───►│ updateSelection  │───►│ endSelection   │───►│ Active Selection  │
│   (x, y)     │    │   (x, y) × N     │    │                │    │  (committed)      │
└──────────────┘    └──────────────────┘    └────────────────┘    └──────────────────┘
                                                                          │
                                                              ┌───────────┴───────────┐
                                                              │                       │
                                                        clearSelection()     resizeSelection()
                                                              │                       │
                                                              ▼                       ▼
                                                        No Selection          Modified Bounds
```

### States

| State | `isSelecting` | `_pendingBounds` | `_activeRegion` |
|-------|---------------|------------------|-----------------|
| Idle (no selection) | `false` | `null` | `null` |
| Dragging (rubber-band) | `true` | non-null | `null` |
| Committed selection | `false` | `null` | non-null |

### Methods

| Method | Description |
|--------|-------------|
| `beginSelection(x, y)` | Starts rubber-band at origin, clears any existing selection |
| `updateSelection(x, y)` | Updates pending bounds — normalises regardless of drag direction |
| `endSelection()` | Commits pending bounds as active region |
| `endSelectionWithValidation(w, h)` | Commits with canvas boundary clamping |
| `clearSelection()` | Removes active region and any pending drag |
| `replaceSelection(region)` | Programmatically sets a selection |
| `validateSelection(w, h)` | Clamps active selection to canvas bounds |

---

## 3. Selection Geometry

### SelectionBounds

Axis-aligned bounding rectangle using inclusive integer pixel coordinates:

```
SelectionBounds(left: 2, top: 3, right: 10, bottom: 8)
```

- `width` = `|right - left| + 1` (pixel count)
- `height` = `|bottom - top| + 1` (pixel count)
- `contains(x, y)` — O(1) bounds check: `x >= left && x < right && y >= top && y < bottom`
- `toRect(cellSize)` — converts to Flutter `Rect` for rendering

### SelectionRegion

Combines `SelectionBounds` with a `SelectionType` enum:

- `rectangle` — implemented ✓
- `freehand` — future placeholder
- `magicWand` — future placeholder
- `colorSelect` — future placeholder
- `polygon` — future placeholder

### SelectionMask (Placeholder)

For non-rectangular selections, a pixel-level bitmap mask will be needed. The `SelectionMask` class is present as a structural placeholder that delegates to `SelectionRegion.containsPoint`.

---

## 4. Hit Testing

The selection engine supports hit testing with 8 resize handles plus interior detection.

### Hit Zones

```
  TL ──── T ──── TR
  │                │
  L    INSIDE      R
  │                │
  BL ──── B ──── BR
```

| Zone | Priority | Description |
|------|----------|-------------|
| `topLeft` | 1 (highest) | Corner handle |
| `topRight` | 1 | Corner handle |
| `bottomLeft` | 1 | Corner handle |
| `bottomRight` | 1 | Corner handle |
| `top` | 2 | Edge handle |
| `right` | 2 | Edge handle |
| `bottom` | 2 | Edge handle |
| `left` | 2 | Edge handle |
| `inside` | 3 | Interior body |
| `none` | 4 (lowest) | Outside selection |

### Algorithm

1. Check corner handles (tolerance: `handleSize` pixels from corner)
2. Check edge handles (tolerance: `handleSize` pixels from edge)
3. Check interior (`contains(x, y)`)
4. Return `none`

Corners take precedence over edges. Edges take precedence over interior. This prevents ambiguous zones at corners.

---

## 5. Rendering Pipeline

Selection rendering is performed by `SelectionRenderer` — a stateless, static class that paints onto a Flutter `Canvas`.

### Render Layers (bottom to top)

1. **Dimming overlay** — semi-transparent black fill outside the selection (uses `clipRect` with `ClipOp.difference`)
2. **Marching ants border** — dashed line around selection rectangle
   - White background line for contrast
   - Blue foreground dashed line
3. **Resize handles** — white-filled squares with blue border at 8 positions

### Integration Point

The `PixelCanvasPainter` should call `SelectionRenderer.paintSelectionOverlay()` after rendering pixels and grid lines. The selection overlay renders on top of all pixel content.

---

## 6. Future: Marching Ants Animation

The rendering infrastructure is ready for animation:

```dart
// In a StatefulWidget with TickerProviderStateMixin:
late final AnimationController _marchingAnts;

@override
void initState() {
  super.initState();
  _marchingAnts = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  )..repeat();
}

// In the painter:
SelectionRenderer.paintSelectionOverlay(
  canvas: canvas,
  size: size,
  bounds: selectionBounds,
  cellSize: cellSize,
  settings: settings,
  dashOffset: _marchingAnts.value * 8.0, // Animate dash offset
);
```

The `dashOffset` parameter shifts the dash pattern along the border perimeter, creating the classic marching ants effect when driven by a ticker.

---

## 7. Future: Pixel Mask Support

When non-rectangular selections (freehand, magic wand, polygon) are implemented:

1. `SelectionMask` will maintain a `Uint8List` bitmap of canvas dimensions
2. `isSelected(x, y)` will read from the bitmap instead of delegating to bounds
3. `SelectionRegion.containsPoint()` will use the mask for non-rectangle types
4. Memory budget: 4096×4096 = ~16 MB (or ~2 MB with bit packing)

---

## 8. File Structure

```
lib/features/editor/engine/selection/
├── models/
│   ├── selection_bounds.dart      # Bounding rectangle geometry
│   ├── selection_mask.dart        # Pixel mask placeholder
│   ├── selection_region.dart      # Region + type enum
│   └── selection_settings.dart    # Tool configuration
├── tools/
│   └── selection_tool.dart        # Static coordinate utilities
├── selection_engine.dart          # Core state manager
└── selection_renderer.dart        # Overlay painting
```

---

## 9. CanvasEngine Integration

The `CanvasEngine` exposes selection through delegation:

| CanvasEngine Method | Delegates to |
|---------------------|-------------|
| `beginSelection(x, y)` | `selectionEngine.beginSelection(x, y)` |
| `updateSelection(x, y)` | `selectionEngine.updateSelection(x, y)` |
| `endSelection()` | `selectionEngine.endSelectionWithValidation(width, height)` |
| `clearSelection()` | `selectionEngine.clearSelection()` |
| `getSelection()` | `selectionEngine.getSelection()` |
| `hasSelection` | `selectionEngine.hasSelection` |

All methods call `notifyListeners()` to trigger repaint via `PixelCanvasPainter`.

---

## 10. EditorController Integration

| EditorState Field | Type | Default |
|-------------------|------|---------|
| `hasSelection` | `bool` | `false` |
| `selectionBounds` | `SelectionBounds?` | `null` |
| `isSelectionVisible` | `bool` | `true` |
| `activeSelectionTool` | `SelectionType` | `rectangle` |

| EditorController Method | Description |
|-------------------------|-------------|
| `setSelectionTool(type)` | Updates active selection type |
| `toggleSelectionVisibility()` | Toggles overlay visibility |
| `syncSelectionState(engine)` | Reads selection state from engine |
| `syncEngineState(engine)` | Now includes selection sync |
