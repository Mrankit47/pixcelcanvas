import 'package:pixelcanvas/features/help/documentation/built_in_documentation.dart';
import 'package:pixelcanvas/features/help/models/help_article_models.dart';
import 'package:pixelcanvas/features/help/models/tutorial_models.dart';
import 'package:pixelcanvas/features/help/tutorials/built_in_tutorials.dart';

/// Search results container for unified search queries.
class HelpSearchResults {
  const HelpSearchResults({
    required this.articles,
    required this.faqs,
    required this.tutorials,
    required this.commands,
  });

  final List<HelpArticle> articles;
  final List<FAQItem> faqs;
  final List<Tutorial> tutorials;
  final List<CommandReference> commands;

  bool get isEmpty => articles.isEmpty && faqs.isEmpty && tutorials.isEmpty && commands.isEmpty;
}

/// Unified Help Center Search Engine.
class HelpSearchEngine {
  /// Performs unified search across articles, FAQs, tutorials, and command references for [query].
  static HelpSearchResults search(String query) {
    if (query.trim().isEmpty) {
      return HelpSearchResults(
        articles: BuiltInDocumentation.articles,
        faqs: BuiltInDocumentation.faqs,
        tutorials: BuiltInTutorials.all,
        commands: BuiltInDocumentation.commands,
      );
    }

    final q = query.toLowerCase();

    final matchedArticles = BuiltInDocumentation.articles.where((a) {
      return a.title.toLowerCase().contains(q) ||
          a.markdownContent.toLowerCase().contains(q) ||
          a.tags.any((t) => t.toLowerCase().contains(q));
    }).toList();

    final matchedFaqs = BuiltInDocumentation.faqs.where((f) {
      return f.question.toLowerCase().contains(q) || f.answer.toLowerCase().contains(q);
    }).toList();

    final matchedTutorials = BuiltInTutorials.all.where((t) {
      return t.title.toLowerCase().contains(q) || t.description.toLowerCase().contains(q);
    }).toList();

    final matchedCommands = BuiltInDocumentation.commands.where((c) {
      return c.commandName.toLowerCase().contains(q) ||
          c.shortcut.toLowerCase().contains(q) ||
          c.description.toLowerCase().contains(q);
    }).toList();

    return HelpSearchResults(
      articles: matchedArticles,
      faqs: matchedFaqs,
      tutorials: matchedTutorials,
      commands: matchedCommands,
    );
  }
}
