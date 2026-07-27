# Transform Engine — Technical Documentation

> **Phase**: 5 – Step 4  
> **Version**: 1.0.0  
> **Status**: Production-Ready  

---

## 1. Overview

The Transform Engine provides a non-destructive transformation workspace operating on top of the Selection Engine, Floating Selection, Layer System, and HistoryManager.

### Key Architecture Principles

1. **Clean Architecture & Pure Engine Logic**: The transform engine has zero dependencies on Riverpod, Isar, Supabase, Repositories, or UI Widgets.
2. **Nearest-Neighbor Scaling & Integer Math**: All transformations (rotation, scaling, flip, mirror) use pure integer coordinate math and nearest-neighbor sampling. Zero anti-aliasing, smoothing, or interpolation.
3. **Non-Destructive Live Preview**: During transformation, modifications are applied strictly to the `FloatingSelection` buffer. Layer pixels are never mutated until explicit confirmation via `commitTransform()`.
4. **Single-Step History Integrity**: Entire transformation sequences (including rotation, scaling, and position shifts) collapse into **ONE** history command when committed.
5. **Selection Auto-Sync**: Selection bounds automatically track the transformed floating selection bounds upon commit.
6. **Strict Layer Validation**: Transformation operations reject locked (`isLocked`) or hidden (`!isVisible`) active layers.

---

## 2. Supported Transformations & Algorithms

### 1. Rotation (90° CW, 90° CCW, 180°)
- **90° Clockwise**: Maps original pixel `(x, y)` to `newX = (height - 1) - y`, `newY = x`. Swaps width and height.
- **90° Counter-Clockwise**: Maps original pixel `(x, y)` to `newX = (width - 1) - y`, `newY = x`. Swaps width and height.
- **180° Rotation**: Maps original pixel `(x, y)` to `newX = (width - 1) - x`, `newY = (height - 1) - y`. Preserves dimensions.

### 2. Flip (Horizontal & Vertical)
- **Flip Horizontal**: Left-right mirror mapping `newX = (width - 1) - x`, `newY = y`.
- **Flip Vertical**: Top-bottom mirror mapping `newX = x`, `newY = (height - 1) - y`.

### 3. Mirror (Horizontal & Vertical)
- **Mirror Horizontal**: Duplicates left half onto right half: for `x >= width / 2`, `ox = width - 1 - x`.
- **Mirror Vertical**: Duplicates top half onto bottom half: for `y >= height / 2`, `oy = height - 1 - y`.

### 4. Scale (Nearest-Neighbor)
- **Algorithm**: Integer ratio mapping `ox = (nx * oldWidth) ~/ newWidth`, `oy = (ny * oldHeight) ~/ newHeight`.
- **Characteristics**: Crisp pixel art scaling without blur, bilinear interpolation, or anti-aliasing artifacts.

---

## 3. Transform Preview & Commit Lifecycle

```
    ┌──────────────────┐
    │  beginTransform()│ ───► Lifts selection pixels to FloatingSelection & initializes TransformPreview
    └────────┬─────────┘
             │
             ▼
    ┌────────────────────────────────────────────────────────┐
    │ rotate CW / CCW / 180, flip H/V, mirror H/V, scale()  │ <── Operates non-destructively on FloatingSelection
    └────────┬───────────────────────────────────────────────┘     (Renders preview via TransformRenderer)
             │
             ├──────────────────────────┐
             ▼                          ▼
    ┌─────────────────┐        ┌──────────────────┐
    │ commitTransform │        │ cancelTransform()│
    └────────┬────────┘        └──────────────────┘
             │                          │
             ▼                          ▼
(Writes pixels to layer &      (Restores source pixels &
 pushes single HistoryCommand)  discards floating buffer)
```

1. **`beginTransform()`**: Verifies active selection and layer lock status. Lifts pixels into `FloatingSelection` if not already floating, then initializes `TransformPreview`.
2. **Operation**: `rotateClockwise()`, `flipHorizontal()`, `scaleSelection()`, etc. recomputes the 1D pixel buffer in `FloatingSelection` without altering `LayerBuffer`.
3. **`commitTransform()`**: Writes final floating pixels to the destination canvas layer, pushes a single history command (`RotateCommand`, `ScaleCommand`, `FlipCommand`, `MirrorCommand`, or `TransformCommand`), and updates selection bounds.
4. **`cancelTransform()`**: Restores source pixels to the layer buffer and discards `FloatingSelection`.

---

## 4. Transform Handles & Hit Testing

`TransformRenderer` draws:
- Bounding box stroke around the active floating selection.
- 8 handles: 4 corner handles (`topLeft`, `topRight`, `bottomLeft`, `bottomRight`) + 4 edge handles (`top`, `bottom`, `left`, `right`).
- Rotation handle placeholder above top-center for future free-rotate support.

Hit testing via `TransformHandle.hitTest(...)` prioritizes handles in order:
1. Rotation handle
2. Corner handles
3. Edge handles
4. Interior body (`inside` for translation)

---

## 5. History & Undo Strategy

| Action | Command Class | Undo Behavior |
|--------|---------------|---------------|
| General Transform | `TransformCommand` | Restores source pixels & reverts destination writes |
| Rotate | `RotateCommand` | Restores source pixels & reverts destination writes |
| Scale | `ScaleCommand` | Restores source pixels & reverts destination writes |
| Flip | `FlipCommand` | Restores source pixels & reverts destination writes |
| Mirror | `MirrorCommand` | Restores source pixels & reverts destination writes |

Each committed transform is saved as **ONE** entry in `HistoryManager._undoStack`. Undoing cleanly restores original pixels to their source position.

---

## 6. Performance Considerations

- **Buffer Reuse**: Operates on a single compact 1D `List<Pixel>` within `FloatingSelection` matching selection dimensions.
- **Zero Full-Canvas Copy**: Only selected bounding box pixels are transformed.
- **Immediate Repaint**: UI repaints preview instantly via `TransformRenderer` canvas overlay without recompiling layer buffers during preview.

---

## 7. Future Expansion Architecture

- **Future Arbitrary-Angle Rotation**: `TransformBounds.rotationDegrees` and `TransformRenderer` rotation handle placeholder are ready to receive arbitrary float angles when interpolation policies are configured.

---

## 8. File Structure

```
lib/features/editor/engine/
├── transform/
│   ├── models/
│   │   ├── transform_handle.dart      # Handle types & hit testing helper
│   │   ├── transform_bounds.dart      # Bounding geometry container
│   │   ├── transform_settings.dart    # Config settings
│   │   └── transform_preview.dart     # Preview state container
│   ├── tools/
│   │   └── transform_tool.dart        # Static pixel rotation, flip, mirror, nearest-neighbor scale
│   ├── transform_engine.dart          # Transform session manager
│   └── transform_renderer.dart        # Canvas overlay painter (handles, box, preview)
└── commands/
    ├── transform_command.dart         # Reversible general transform history command
    ├── rotate_command.dart            # Reversible rotate history command
    ├── scale_command.dart             # Reversible scale history command
    ├── flip_command.dart              # Reversible flip history command
    └── mirror_command.dart            # Reversible mirror history command
```
