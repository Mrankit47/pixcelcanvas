# Application Shell & Workspace Foundation — Technical Documentation

> **Phase**: 7 – Step 1  
> **Version**: 1.0.0  
> **Status**: Production-Ready  

---

## 1. Overview

The Application Shell and Workspace Foundation forms the surrounding desktop-class UI framework enclosing the core `CanvasEngine`.

### Key Layout Structure

```
+-------------------------------------------------------+
| Top Toolbar & Workspace Tabs Bar                     |
+----------+--------------------------------------------+
| Sidebar  |                                            |
|          |           Workspace View                   |
|          |                                            |
+----------+--------------------------------------------+
| Status Bar                                             |
+-------------------------------------------------------+
```

---

## 2. Core Modules

1. **`ApplicationShell`**: Main responsive scaffold integrating Top Toolbar, Sidebar, active Workspace viewport, and Status Bar.
2. **`TopToolbarView`**: Provides file actions (`New`, `Open`, `Save`, `Export`), history controls (`Undo`, `Redo`), workspace tab bar, and command palette search trigger.
3. **`SidebarView`**: Collapsible sidebar displaying section panels (`Layers`, `Animation`, `Projects`, `History`, `Inspector`).
4. **`StatusBarView`**: Bottom bar rendering real-time metrics (`Canvas Size`, `Zoom`, `Current Tool`, `FPS`, `Memory Footprint`, `Cursor X/Y`).
5. **`CommandPalette`**: Quick command search modal overlay (`Ctrl+K` / `Cmd+K`).

---

## 3. Architecture Rules

- **Engine Isolation**: The Application Shell communicates with `CanvasEngine` strictly through public API contracts.
- **Zero Engine Contamination**: The application shell code is isolated under `lib/features/app_shell/` and does NOT modify core drawing or rendering logic.
