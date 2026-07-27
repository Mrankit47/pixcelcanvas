# Animation Timeline & Playback Engine — Technical Documentation

> **Phase**: 5 – Step 7  
> **Version**: 1.0.0  
> **Status**: Production-Ready  

---

## 1. Overview

The Animation Timeline & Playback Engine provides editor-driven animation clip management, multi-track timeline organization, tick-driven playback control, onion skin translucent frame overlays, and animation metadata export.

### Key Architecture Principles

1. **Clean Architecture & Pure Engine Logic**: The animation engine has zero dependencies on Riverpod, Isar, Supabase, Repositories, or UI Widgets.
2. **Editor-Driven Tick Playback**: Uses an explicit `tick(deltaMs)` controller without game engine assumptions or widget timers.
3. **Loop Modes**: Supports standard `loop` (infinite repeat), `pingPong` (forward then reverse), and `playOnce` (stop on end frame).
4. **Onion Skinning**: Renders translucent previous and next frame overlays with red/green color tints, configurable opacity, and frame counts.
5. **Single-Step History Integrity**: Clip creation, deletion, renaming, duplicating, and playback settings changes collapse into **ONE** `HistoryCommand` step in `HistoryManager`.

---

## 2. Animation Data Models

### 1. `AnimationClip`
Container representing an animation sequence (e.g. `Idle`, `Walk`, `Run`, `Jump`, `Attack`, `Custom`):
- `id`, `name`: Clip identification.
- `frames`: Ordered `List<AnimationFrame>`.
- `loopMode`: `LoopMode` (`loop`, `pingPong`, `playOnce`).
- `playbackSpeed`: Speed multiplier ($0.1\times$ to $5.0\times$).
- `fps`: Target playback frame rate (1 to 60 FPS).

### 2. `AnimationFrame`
Individual timeline frame definition:
- `id`: Frame instance ID.
- `spriteFrameId`: Optional reference to underlying `SpriteFrame`.
- `durationMs`: Frame duration in milliseconds (default: 100ms = 10 FPS).
- `fpsOverride`: Optional per-frame FPS override.
- `pixels`: Fallback 1D pixel buffer.

### 3. `AnimationSettings`
Global animation & onion skin configuration:
- `fps`: Default playback FPS (12 FPS).
- `loopMode`: Default loop mode (`loop`).
- `onionSkinEnabled`: Boolean toggle.
- `onionSkinPreviousFrames`: Number of previous frame overlays (default: 1).
- `onionSkinNextFrames`: Number of next frame overlays (default: 1).
- `onionSkinOpacity`: Translucent overlay opacity multiplier (default: 0.4).
- `onionSkinPreviousColorHex`: Color tint string for previous frames (`#FF0000` Red).
- `onionSkinNextColorHex`: Color tint string for next frames (`#00FF00` Green).

---

## 3. Playback Controller (`PlaybackController`)

The pure Dart ticker advances frame playhead based on delta time:

- **`play()`**: Sets `isPlaying = true`.
- **`pause()`**: Sets `isPlaying = false`.
- **`stop()`**: Resets playhead `currentFrameIndex = 0` and `elapsedTimeMs = 0`.
- **`seek(index)`**: Seeks playhead directly to `index`.
- **`tick(deltaMs, clip)`**: Accumulates `elapsedTimeMs += deltaMs * playbackSpeed`. Advances to next frame when `elapsedTimeMs >= targetDuration`.

### Loop Mode Advancement Logic

- **`LoopMode.loop`**: Advances sequentially:
  $$\text{frameIndex} = (\text{frameIndex} + 1) \pmod{\text{totalFrames}}$$
- **`LoopMode.pingPong`**: Advances forward to $\text{totalFrames} - 1$, then reverses backward to $0$.
- **`LoopMode.playOnce`**: Advances forward until reaching $\text{totalFrames} - 1$, then sets `isPlaying = false`.

---

## 4. Onion Skin Renderer (`OnionSkinRenderer`)

Static painter drawing translucent previous and next frame overlays onto `Canvas`:

- **Previous Frames Overlay**: Rendered with red tint (`#FF0000`) and decreasing opacity per step:
  $$\text{opacityStep} = \frac{\text{onionSkinOpacity}}{\text{step}}$$
- **Next Frames Overlay**: Rendered with green tint (`#00FF00`) and decreasing opacity per step.

---

## 5. History & Undo Strategy

| Action | Command Class | Undo Behavior |
|--------|---------------|---------------|
| Create Clip | `CreateAnimationCommand` | Deletes created clip |
| Delete Clip | `DeleteAnimationCommand` | Restores deleted clip snapshot |
| Rename Clip | `RenameAnimationCommand` | Restores original clip name |
| Duplicate Clip | `DuplicateAnimationCommand` | Deletes duplicated clip |
| Add Frame | `AddFrameCommand` | Removes added frame |
| Remove Frame | `RemoveFrameCommand` | Re-inserts removed frame snapshot |
| Update Duration | `UpdateFrameDurationCommand` | Restores original frame duration |
| Playback Settings | `PlaybackSettingsCommand` | Restores previous settings |

Every completed animation action collapses into **ONE** history command step in `HistoryManager`.

---

## 6. Export Pipeline (`AnimationExporter`)

- **`exportAnimatedSpriteSheetPng()`**: Packs all frames of the clip into a horizontal strip PNG binary payload (`Uint8List`).
- **`exportFrameSequencePngs()`**: Exports each frame as an individual PNG entry in a `Map<String, Uint8List>`.
- **`exportJsonMetadata()`**: Exports clip metadata detailing clip ID, name, FPS, loop mode, playback speed, and frame array.
- **Future Extension Placeholders**: Built-in stub methods for GIF (`exportGifPlaceholder`), APNG (`exportApngPlaceholder`), and Video (`exportVideoPlaceholder`).

---

## 7. File Structure

```
lib/features/editor/engine/
├── animation/
│   ├── models/
│   │   ├── loop_mode.dart             # LoopMode enum (loop, pingPong, playOnce)
│   │   ├── animation_frame.dart       # AnimationFrame model (ID, duration, fpsOverride)
│   │   ├── animation_clip.dart        # AnimationClip model (frames, speed, loopMode, FPS)
│   │   └── animation_settings.dart    # AnimationSettings model (onion skin configs, FPS)
│   ├── timeline/
│   │   ├── timeline_cursor.dart       # Playhead cursor container
│   │   ├── timeline_selection.dart    # Selection state for frames and clips
│   │   ├── animation_track.dart       # AnimationTrack container
│   │   └── animation_timeline.dart    # AnimationTimeline state
│   ├── playback/
│   │   └── playback_controller.dart   # Pure Dart tick-driven playback controller
│   ├── renderers/
│   │   ├── onion_skin_renderer.dart   # Translucent onion skin overlay painter
│   │   └── animation_renderer.dart    # Active frame painter
│   ├── tools/
│   │   ├── animation_exporter.dart    # Packed PNG, frame sequence PNGs, & JSON exporter
│   │   └── animation_importer.dart    # JSON animation metadata importer
│   └── animation_engine.dart          # Central animation engine manager
└── commands/
    ├── create_animation_command.dart  # Reversible create animation clip command
    ├── delete_animation_command.dart  # Reversible delete animation clip command
    ├── rename_animation_command.dart  # Reversible rename animation clip command
    ├── duplicate_animation_command.dart # Reversible duplicate animation clip command
    ├── add_frame_command.dart         # Reversible add frame command
    ├── remove_frame_command.dart      # Reversible remove frame command
    ├── update_frame_duration_command.dart # Reversible frame duration command
    ├── timeline_command.dart          # Reversible playhead seek command
    └── playback_settings_command.dart # Reversible playback settings command
```
