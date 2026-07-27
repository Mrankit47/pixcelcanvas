# PNG Import & Image-to-Pixel Pipeline — Technical Documentation

> **Phase**: 5 – Step 5  
> **Version**: 1.0.0  
> **Status**: Production-Ready  

---

## 1. Overview

The PNG Import & Image-to-Pixel Pipeline enables importing external image files (specifically PNG format, with placeholders for JPEG, WebP, and static GIF), converting RGBA image pixels into editable PixelCanvas `PixelBuffer` structures, and placing them into the canvas via flexible layer or project strategies.

### Key Architecture Principles

1. **Clean Architecture & Pure Engine Logic**: The import pipeline has zero dependencies on Riverpod, Isar, Supabase, Repositories, or UI Widgets.
2. **Nearest-Neighbor Scaling**: Image scaling strictly uses integer ratio mapping. Zero anti-aliasing, smoothing, or bilinear interpolation artifacts.
3. **Color Quantization & Dithering**: Built-in 16, 32, 64, 128, and 256 color palette reduction using Euclidean RGB distance matching and optional Floyd–Steinberg error diffusion dithering.
4. **Single-Step History Integrity**: Entire import workflows collapse into **ONE** history command (`ImportCommand`), supporting complete undo and redo.
5. **Alpha Transparency Preservation**: 8-bit RGBA alpha channels are maintained; fully transparent pixels ($A = 0$) map to `Pixel.empty`.
6. **Strict Layer Validation**: Imports targeting an active layer respect layer lock (`isLocked`) states.

---

## 2. Import Workflow Lifecycle

```
    ┌──────────────────────┐
    │     File Selection    │ ───► Raw Uint8List bytes
    └──────────┬───────────┘
               │
               ▼
    ┌──────────────────────┐
    │  ImageDecoder.decode │ ───► Header magic check (89 50 4E 47...) & RGBA extraction
    └──────────┬───────────┘
               │
               ▼
    ┌──────────────────────┐
    │  ImportTool.compute  │ ───► Target dimensions (original, fitCanvas, fillCanvas, stretch, custom)
    └──────────┬───────────┘
               │
               ▼
    ┌──────────────────────┐
    │ PixelConverter.scale │ ───► Nearest-Neighbor 1D Pixel array scaling
    └──────────┬───────────┘
               │
               ▼
    ┌──────────────────────┐
    │ PaletteReducer.reduce│ ───► Color quantization (16-256) & Floyd-Steinberg dithering
    └──────────┬───────────┘
               │
               ▼
    ┌──────────────────────┐
    │    ImportPreview     │ ───► Non-destructive overlay preview rendered via ImportRenderer
    └──────────┬───────────┘
               │
       ┌───────┴───────┐
       ▼               ▼
┌──────────────┐ ┌──────────────┐
│commitImport()│ │cancelImport()│
└──────┬───────┘ └──────────────┘
       │
       ▼
(Writes to layer/canvas &
 pushes single ImportCommand)
```

---

## 3. Image Scaling Strategies

Supported modes in `ImportScaleMode`:

1. **`original`**: Maintains original image pixel dimensions $(W_{src}, H_{src})$.
2. **`fitCanvas`**: Scales image to fit inside canvas dimensions while preserving aspect ratio:
   $\text{scale} = \min(W_{\text{canvas}} / W_{\text{src}}, H_{\text{canvas}} / H_{\text{src}})$.
3. **`fillCanvas`**: Scales image to fill canvas dimensions while preserving aspect ratio:
   $\text{scale} = \max(W_{\text{canvas}} / W_{\text{src}}, H_{\text{canvas}} / H_{\text{src}})$.
4. **`stretch`**: Distorts image to fill exact canvas dimensions $(W_{\text{canvas}}, H_{\text{canvas}})$.
5. **`custom`**: User-defined explicit target width and height.

### Nearest-Neighbor Algorithm

For every pixel coordinate $(x, y)$ in target space:
$$\text{srcX} = \lfloor (x \times W_{\text{src}}) / W_{\text{target}} \rfloor$$
$$\text{srcY} = \lfloor (y \times H_{\text{src}}) / H_{\text{target}} \rfloor$$
Ensures crisp, pixel-perfect output without anti-aliasing blur.

---

## 4. Palette Reduction & Dithering

### Palette Quantization Modes (`ImportPaletteMode`)
- `unlimited`: Retains full original color space.
- `c16`, `c32`, `c64`, `c128`, `c256`: Extracts top $N$ most frequent colors and maps each pixel to the nearest palette color using Euclidean distance in 3D RGB space:
  $$\Delta C = \sqrt{(R_1 - R_2)^2 + (G_1 - G_2)^2 + (B_1 - B_2)^2}$$

### Floyd–Steinberg Dithering (`ImportDitherMode.floydSteinberg`)
Diffuses color quantization error $E = (E_R, E_G, E_B)$ to neighboring unquantized pixels:
- Right $(x+1, y)$: $\frac{7}{16} E$
- Bottom-Left $(x-1, y+1)$: $\frac{3}{16} E$
- Bottom $(x, y+1)$: $\frac{5}{16} E$
- Bottom-Right $(x+1, y+1)$: $\frac{1}{16} E$

---

## 5. Import Destination Strategies

`ImportDestination` options:

1. **`newLayer`**: Spawns a new layer on top of the layer stack and plots imported pixels.
2. **`replaceActive`**: Overwrites pixels on the active layer (requires active layer unlocked).
3. **`newCanvas`**: Resizes canvas grid to match target image dimensions and clears layers.

---

## 6. History & Undo Strategy

All import destinations register as **ONE** `ImportCommand` in `HistoryManager`:

- **`newLayer` Undo**: Deletes the spawned import layer.
- **`replaceActive` Undo**: Restores previous pixel deltas on active layer.
- **`newCanvas` Undo**: Restores previous canvas dimensions and layer stack snapshot.

---

## 7. Future Expansion Architecture

- **JPEG / WebP / Static GIF**: `ImageFormat` enum contains placeholders. The decoding pipeline (`ImageDecoder`) is structured to route additional formats to `package:image` decoders seamlessly.
- **Custom Palettes**: `ImportPaletteMode.customPalette` placeholder for loading palette files (`.pal`, `.act`).

---

## 8. File Structure

```
lib/features/editor/engine/
├── import/
│   ├── models/
│   │   ├── import_settings.dart      # Enums & config container
│   │   └── import_preview.dart       # Preview snapshot & metadata
│   ├── tools/
│   │   ├── image_decoder.dart        # PNG byte validation & RGBA decoding
│   │   ├── pixel_converter.dart      # Nearest-neighbor scale & RGBA conversion
│   │   ├── palette_reducer.dart      # Color quantization & Floyd-Steinberg dithering
│   │   ├── image_importer.dart       # Full pipeline orchestrator
│   │   └── import_tool.dart          # Scaling calculations & memory estimation
│   ├── import_engine.dart            # Session state manager
│   └── import_renderer.dart          # Overlay painter for preview
└── commands/
    └── import_command.dart           # Single-step reversible history command
```
