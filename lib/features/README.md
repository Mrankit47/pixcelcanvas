# Features Module

Feature modules for PixelCanvas, organized using Feature-First architecture per Blueprint §8.1.

Every feature directory is isolated and contains three layers:

- **`data/`**: Models, data sources (local Isar & remote Supabase), repository implementations.
- **`domain/`**: Entities, repository interfaces, use cases, business logic.
- **`presentation/`**: Screen widgets, feature widgets, Riverpod state notifiers.

## Feature Inventory

1. **`splash/`**: Brand splash screen and initialization loading.
2. **`onboarding/`**: 3-page interactive onboarding flow.
3. **`auth/`**: Registration, login, Google OAuth, guest mode.
4. **`home/`**: Main dashboard, recent projects, quick actions.
5. **`projects/`**: Project CRUD, sorting, searching, list/grid views.
6. **`editor/`**: Core pixel canvas editor, tools, undo/redo, auto-save.
7. **`layers/`**: Multi-layer management, opacity, visibility, z-order.
8. **`palette/`**: Built-in and custom color palettes, color picker, eyedropper.
9. **`templates/`**: Starter templates library and category filtering.
10. **`community/`**: Gallery feed, publishing, artwork detail, likes.
11. **`notifications/`**: Notification center and preference settings.
12. **`profile/`**: User profile, published artworks, user statistics.
13. **`settings/`**: Application preferences, account management, legal.
14. **`export/`**: PNG export options, scale selection, sharing.
