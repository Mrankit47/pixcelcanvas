# Project Dashboard & Project Lifecycle — Technical Documentation

> **Phase**: 7 – Step 2  
> **Version**: 1.0.0  
> **Status**: Production-Ready  

---

## 1. Overview

The Project Dashboard and Project Lifecycle Management System provides a desktop-class project launcher, search engine, preset resolution generator, and soft-delete recovery manager enclosing the `CanvasEngine`.

---

## 2. Key Modules

1. **`ProjectDashboard`**: Main dashboard interface displaying quick action creation cards, recent projects grid, search input, category filters, and thumbnail previews.
2. **`ProjectCard`**: Card component displaying preview thumbnail, project name, resolution, modified date, last opened date, favorite/pinned badges, and context menu.
3. **`ProjectManager`**: Central controller orchestrating project CRUD lifecycle (Create, Open, Rename, Duplicate, Archive, Restore, Delete).
4. **`ProjectSearchEngine`**: Multi-criteria search and filter engine matching names, resolution strings, and custom tags.
5. **`ThumbnailCache`**: Lazy RAM PNG byte cache for project preview thumbnails.

---

## 3. Architecture Rules

- **Engine Isolation**: Communicates with `CanvasEngine` strictly through public APIs (`CanvasEngine`, `ProjectSerializer`/`Deserializer`, `WorkspaceManager`).
- **Zero Engine Contamination**: All dashboard logic is isolated under `lib/features/project_dashboard/`.
