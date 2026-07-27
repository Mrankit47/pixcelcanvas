# Project Lifecycle Management Architecture

> **Phase**: 7 – Step 2  
> **Version**: 1.0.0  

---

## 1. Lifecycle Operations

| Operation | Trigger | Effect |
|-----------|---------|--------|
| **Create** | `ProjectManager.createProject()` | Initializes new `ProjectMetadata` and opens a new `CanvasEngine` workspace tab |
| **Open** | `ProjectManager.openProject()` | Updates `lastOpened` timestamp and opens project workspace tab |
| **Rename** | `ProjectManager.renameProject()` | Updates project title and `.pixelcanvas` file path |
| **Duplicate** | `ProjectManager.duplicateProject()` | Clones project metadata and spawns `_Copy` entry |
| **Archive (Soft Delete)** | `ProjectManager.archiveProject()` | Sets `isArchived = true` and moves entry to Trash Bin |
| **Restore** | `ProjectManager.restoreProject()` | Reverts `isArchived = false` and moves project back to active grid |
| **Permanent Delete** | `ProjectManager.deletePermanently()` | Removes project from index and invalidates thumbnail cache |
