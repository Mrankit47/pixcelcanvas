# Shape Drawing Engine — Technical Documentation

> **Phase**: 5 – Step 3  
> **Version**: 1.0.0  
> **Status**: Production-Ready  

---

## 1. Overview

The Shape Drawing Engine provides pixel-perfect raster shape point generation and preview rendering for Line, Rectangle, Circle, and Ellipse shapes. It seamlessly integrates with `CanvasEngine`, `HistoryManager` command stack, `LayerBuffer` system, and `SelectionEngine` clipping bounds.

### Key Architecture Principles

1. **Clean Architecture & Pure Engine Logic**: The shape engine has zero dependencies on Riverpod, Isar, Supabase, Repositories, or UI Widgets.
2. **Integer Coordinate Math**: All shape algorithms use strict integer math. No anti-aliasing, no smoothing, and no sub-pixel interpolation.
3. **Single-Step History Integrity**: Each completed shape (from pointer drag start to release) commits to `HistoryManager` as **ONE** history command containing `PixelDelta` changes.
4. **Independent Preview System**: During pointer drag, shape preview points are calculated dynamically and rendered directly to `Canvas` via `ShapePreviewRenderer` without mutating `LayerBuffer` pixels.
5. **Selection Clipping**: Shape plotting is automatically clipped to the active `SelectionRegion`. Points outside selection bounds are skipped.
6. **Strict Layer Rules**: Shape drawing respects layer lock (`isLocked`) and visibility (`isVisible`) states. Locked or hidden active layers reject shape operations.

---

## 2. Supported Shape Algorithms

### 1. Line (`LineTool`)
- **Algorithm**: Bresenham's Integer Line Algorithm.
- **Characteristics**: Fast $O(N)$ integer step loop calculating contiguous 1-pixel steps from `(x0, y0)` to `(x1, y1)`. Zero floating-point arithmetic.

### 2. Rectangle (`RectangleTool`)
- **Modes**:
  - `Outline`: Perimeter lines only (top, bottom, left, right edges).
  - `Filled`: Solid scanline fill covering bounding area `[minX..maxX] × [minY..maxY]`.
- **Coordinates**: Normalised min/max calculation ensures valid rendering regardless of drag direction.

### 3. Circle (`CircleTool`)
- **Algorithm**: Midpoint Circle Algorithm (Bresenham Circle).
- **Modes**:
  - `Outline`: 8-way symmetry plotting `(cx ± x, cy ± y)` and `(cx ± y, cy ± x)`.
  - `Filled`: Horizontal scanline fill connecting symmetric perimeter pairs `[cx - x .. cx + x]` at `cy ± y` and `[cx - y .. cx + y]` at `cy ± x`.
- **Deduplication**: Uses integer spatial hash set to eliminate duplicate pixel generation at symmetric boundaries.

### 4. Ellipse (`EllipseTool`)
- **Algorithm**: Midpoint Ellipse Algorithm with Region 1 ($dx < dy$) and Region 2 ($dy \ge dx$) decision parameters.
- **Modes**:
  - `Outline`: 4-way symmetry plotting `(cx ± x, cy ± y)`.
  - `Filled`: Horizontal scanline fill connecting `[cx - x .. cx + x]` at `cy ± y`.
- **Degenerate handling**: Handles 1D degenerate lines when radius $rx = 0$ or $ry = 0$.

---

## 3. Preview System & Lifecycle

```
    ┌────────────────┐
    │  beginShape()  │ ───► Initializes ShapePreview at start (x0, y0)
    └───────┬────────┘
            │
            ▼
    ┌────────────────┐
    │  updateShape() │ ───► Updates preview end (x1, y1) during pointer drag
    └───────┬────────┘      (Renders via ShapePreviewRenderer without layer mutation)
            │
            ├──────────────────────────┐
            ▼                          ▼
    ┌────────────────┐         ┌───────────────┐
    │  commitShape() │         │ cancelShape() │
    └───────┬────────┘         └───────────────┘
            │                          │
            ▼                          ▼
(Plots to LayerBuffer with     (Discards preview)
 selection clipping & pushes
 HistoryCommand)
```

1. **`beginShape(x, y)`**: Validates active layer, initializes `ShapePreview(startX: x, startY: y, endX: x, endY: y)`.
2. **`updateShape(x, y)`**: Updates `endX, endY`. Triggers UI repaint. `ShapePreviewRenderer` draws preview cells onto `Canvas`.
3. **`commitShape()`**: Generates final shape points, applies selection clipping via `ShapeRenderer.drawShapePoints()`, creates the matching `HistoryCommand`, executes history, and clears preview.
4. **`cancelShape()`**: Discards `ShapePreview` without altering canvas state.

---

## 4. Selection Clipping

```
┌──────────────────────────────────────┐
│ Canvas                               │
│       ┌──────────────────┐           │
│       │ Selection Bounds │           │
│       │                  │           │
│       │   ┌──────────────┼──────┐    │
│       │   │ Shape Points │      │    │
│       │   │ (Plotted)    │ (Clipped) │
│       └───┴──────────────┘      │    │
│           └─────────────────────┘    │
└──────────────────────────────────────┘
```

When `selectionEngine.hasSelection` is true:
- `ShapeRenderer.drawShapePoints()` checks `selectionRegion.containsPoint(x, y)` for every generated point.
- Points outside the active selection region are discarded.
- `ShapePreviewRenderer.paintPreview()` applies the same visual check for consistency during preview drag.

---

## 5. History & Undo Strategy

| Shape Type | Command Class | Undo/Redo Action |
|------------|---------------|------------------|
| Line | `LineCommand` | Reverts / re-applies `PixelDelta` list |
| Rectangle | `RectangleCommand` | Reverts / re-applies `PixelDelta` list |
| Circle | `CircleCommand` | Reverts / re-applies `PixelDelta` list |
| Ellipse | `EllipseCommand` | Reverts / re-applies `PixelDelta` list |

Each completed shape is stored as **ONE** entry in `HistoryManager._undoStack`. Undoing the command restores the original pixel values prior to shape plotting.

---

## 6. Performance Considerations

- **Memory Efficiency**: Spatial integer hash sets (`(px & 0xFFFF) | ((py & 0xFFFF) << 16)`) prevent duplicate allocations during scanline generation.
- **Zero Heap Churn**: Points are computed lazily on drag update and immediately discarded after commit/cancel.
- **Fast Boundary Checking**: Selection containment uses $O(1)$ integer range tests.

---

## 7. Future Expansion Architecture

- **Future Polygon Tool**: Will extend `ShapeTool` and add a multi-vertex point collector stack in `ShapeEngine`.
- **Future Bézier Curve Tool**: Will implement integer de Casteljau / Midpoint Subdivision curve algorithms generating control point paths.

---

## 8. File Structure

```
lib/features/editor/engine/
├── shapes/
│   ├── models/
│   │   ├── shape_settings.dart      # ShapeType & ShapeFillMode enums + config
│   │   └── shape_preview.dart       # Drag coordinate container
│   ├── tools/
│   │   ├── shape_tool.dart          # Base interface
│   │   ├── line_tool.dart           # Bresenham Line algorithm
│   │   ├── rectangle_tool.dart      # Perimeter / scanline rectangle generator
│   │   ├── circle_tool.dart         # Midpoint Circle algorithm
│   │   └── ellipse_tool.dart        # Midpoint Ellipse algorithm
│   ├── shape_engine.dart            # Drag state manager
│   ├── shape_renderer.dart          # Layer buffer plotter with selection clipping
│   └── shape_preview_renderer.dart  # Independent overlay canvas painter
└── commands/
    ├── line_command.dart            # Reversible line history command
    ├── rectangle_command.dart       # Reversible rectangle history command
    ├── circle_command.dart          # Reversible circle history command
    └── ellipse_command.dart         # Reversible ellipse history command
```
