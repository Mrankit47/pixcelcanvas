# PixelCanvas Changelog

All notable changes to PixelCanvas will be documented in this file.

---

## [1.0.0-RC1] - 2026-07-27

### Added
- **Phase 5 Step 1**: Selection Engine Foundation (`SelectionEngine`, `SelectionRegion`, `SelectionBounds`, `SelectionMask`, `SelectionRenderer`, `SelectionTool`).
- **Phase 5 Step 2**: Move / Copy / Cut / Paste Engine (`ClipboardManager`, `FloatingSelection`, `MoveSelectionCommand`, `CopySelectionCommand`, `CutSelectionCommand`, `PasteSelectionCommand`).
- **Phase 5 Step 3**: Shape Drawing Engine (`ShapeEngine`, `ShapeRenderer`, `ShapeTool`, `LineTool`, `RectangleTool`, `CircleTool`, `EllipseTool`).
- **Phase 5 Step 4**: Transform Engine (`TransformEngine`, `TransformRenderer`, `TransformTool`, rotations, flips, mirrors, scale).
- **Phase 5 Step 5**: PNG Import & Image-to-Pixel Pipeline (`ImportEngine`, `ImageDecoder`, `PixelConverter`, `PaletteReducer`, `ImportTool`).
- **Phase 5 Step 6**: Sprite Sheet Engine & Frame Management (`SpriteSheetEngine`, `FrameGridSlicer`, `FrameManualSlicer`, `FrameExporter`, `FrameImporter`).
- **Phase 5 Step 7**: Animation Timeline & Playback Engine (`AnimationEngine`, `AnimationTimeline`, `PlaybackController`, `OnionSkinRenderer`, `AnimationRenderer`, `AnimationExporter`).
- **Phase 6**: Editor Quality Gate & Production Hardening (`ProjectSerializer`, `ProjectDeserializer`, 10 automated unit test files, memory caps, quality audit).
- **Phase 7 Step 1**: Application Shell & Workspace Foundation (`ApplicationShell`, `WorkspaceManager`, `NavigationManager`, `TopToolbarView`, `SidebarView`, `StatusBarView`, `CommandPalette`).
- **Phase 7 Step 2**: Project Dashboard & Project Lifecycle (`ProjectDashboard`, `ProjectManager`, `ProjectIndex`, `ProjectCard`, `ProjectSearchEngine`, `ProjectSorter`, `ThumbnailCache`).
- **Phase 7 Step 3**: Project Creation Wizard & Template Library (`ProjectCreationWizard`, `TemplateLibraryView`, `TemplateManager`, `BuiltInTemplates`, `TemplateCard`).
- **Phase 7 Step 4**: Settings, Preferences & Keyboard Shortcut System (`SettingsDialog`, `KeyboardShortcutsView`, `SettingsManager`, `KeyboardShortcutManager`, `ShortcutConflictResolver`).
- **Phase 7 Step 5**: Onboarding, Help Center & Interactive Tutorial System (`OnboardingScreen`, `HelpCenterDialog`, `TutorialManager`, `TutorialOverlayWidget`, `BuiltInTutorials`, `BuiltInDocumentation`).
- **Phase 7 Step 6**: Export Center, Project Packaging & Distribution (`ExportCenterDialog`, `ExportManager`, `ExportQueue`, `BatchExportManager`, `ProjectPackager`).
- **Phase 7 Step 7**: Product Integration, Accessibility, Performance Audit & Release Readiness (`ApplicationIntegrator`, `ModuleValidator`, `ReleaseValidator`, `AccessibilityManager`, `PerformanceProfiler`, `ErrorRecoveryManager`, `ReleaseChecklist`, Release Docs).
