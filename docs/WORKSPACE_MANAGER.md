# Workspace Manager Architecture

> **Phase**: 7 – Step 1  
> **Version**: 1.0.0  

---

## 1. Overview

`WorkspaceManager` manages multiple open project workspaces simultaneously in independent workspace tabs.

---

## 2. Key Capabilities

1. **Multiple Open Projects**: Each `ProjectWorkspace` encapsulates an independent `CanvasEngine` instance, project name, dirty state flag (`isDirty`), and file path.
2. **Active Workspace Switching**: Zero-latency switching between open workspace tabs.
3. **Tab Reordering & Closing**: Supports closing workspace tabs and reordering tab index sequence.
4. **Unsaved Indicator**: Automatically tracks dirty state flags when edits occur.
