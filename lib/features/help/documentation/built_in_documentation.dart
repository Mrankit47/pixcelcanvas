import 'package:pixelcanvas/features/help/models/help_article_models.dart';

/// Built-in documentation articles, FAQs, and command references.
class BuiltInDocumentation {
  static final List<HelpArticle> articles = [
    const HelpArticle(
      id: 'doc_getting_started',
      title: 'Getting Started with PixelCanvas',
      category: 'Getting Started',
      markdownContent: '''
# Getting Started with PixelCanvas

PixelCanvas is a production-ready pixel art editor supporting non-destructive layer blending, rubber-band selections, floating transformations, sprite sheet slicing, and pure Dart tick-driven animation playback.

## Basic Workflow
1. **Create Canvas**: Click **New Project** on the dashboard or top toolbar.
2. **Select Tools**: Use **Brush (B)**, **Eraser (E)**, or **Bucket Fill (G)** to paint pixels.
3. **Use Layers**: Add layers in the sidebar to separate lineart, colors, and shadows.
4. **Export**: Export as PNG image, animated sprite sheet, or `.pixelcanvas` project files.
''',
      tags: ['start', 'intro', 'basics'],
    ),
    const HelpArticle(
      id: 'doc_animation',
      title: 'Animation Timeline & Onion Skinning',
      category: 'Animation',
      markdownContent: '''
# Animation Timeline & Onion Skinning

PixelCanvas includes an editor-driven animation engine with zero game engine assumptions.

## Features
- **Loop Modes**: `Loop`, `Ping-Pong`, and `Play Once`.
- **Onion Skinning**: Overlays translucent red/green tints of previous and next frames.
- **FPS Control**: Configurable playback speed (1 to 60 FPS).
''',
      tags: ['animation', 'timeline', 'onion skin', 'fps'],
    ),
  ];

  static final List<FAQItem> faqs = [
    const FAQItem(
      question: 'How do I undo a mistake?',
      answer: 'Press `Ctrl+Z` (or `Cmd+Z` on macOS) to undo your last action. Press `Ctrl+Y` to redo.',
      category: 'Editing',
    ),
    const FAQItem(
      question: 'What file format does PixelCanvas use?',
      answer: 'PixelCanvas saves full projects as `.pixelcanvas` JSON project files. You can also export images as standard PNG or sprite sheets.',
      category: 'Projects',
    ),
    const FAQItem(
      question: 'Can I rebind keyboard shortcuts?',
      answer: 'Yes! Open Settings (`Ctrl+,`), navigate to the Shortcuts tab, and click any key combo to record a custom shortcut.',
      category: 'Settings',
    ),
  ];

  static final List<CommandReference> commands = [
    const CommandReference(
      commandName: 'Undo Edit',
      category: 'Drawing',
      shortcut: 'Ctrl+Z',
      description: 'Reverts the most recent pixel edit or layer command.',
      usage: 'Press Ctrl+Z anywhere while editing.',
    ),
    const CommandReference(
      commandName: 'Select Brush Tool',
      category: 'Tools',
      shortcut: 'B',
      description: 'Activates single-pixel brush tool.',
      usage: 'Press B to switch to brush mode.',
    ),
    const CommandReference(
      commandName: 'Command Palette',
      category: 'Navigation',
      shortcut: 'Ctrl+K',
      description: 'Opens searchable quick command modal.',
      usage: 'Press Ctrl+K to search all editor commands.',
    ),
  ];
}
