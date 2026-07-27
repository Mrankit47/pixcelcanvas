# Keyboard Shortcut System Architecture

> **Phase**: 7 – Step 4  
> **Version**: 1.0.0  

---

## 1. Shortcut Categories

1. `application`: System & window actions
2. `project`: New, Open, Save project actions
3. `canvas`: Resize, crop, zoom actions
4. `drawing`: Brush, Eraser, Fill tool selections
5. `selection`: Select All, Clear Selection actions
6. `layers`: New Layer, Delete Layer, Layer Reordering
7. `animation`: Play, Pause, Step Frame actions
8. `export`: Export PNG, GIF, Sprite Sheet
9. `view`: Toggle Grid, Toggle Onion Skin
10. `navigation`: Command Palette, Tab Switching
11. `developer`: Debugger & Inspector placeholders

---

## 2. Conflict Resolution

`ShortcutConflictResolver` scans registered `ShortcutBinding` key combinations and detects overlapping key combos across categories in real time.
