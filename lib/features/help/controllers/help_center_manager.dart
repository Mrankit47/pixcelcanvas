import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/help/documentation/built_in_documentation.dart';
import 'package:pixelcanvas/features/help/models/help_article_models.dart';

/// Central Help Center Manager coordinating documentation, FAQs, and commands.
class HelpCenterManager extends ChangeNotifier {
  final List<HelpArticle> articles = List.from(BuiltInDocumentation.articles);
  final List<FAQItem> faqs = List.from(BuiltInDocumentation.faqs);
  final List<CommandReference> commands = List.from(BuiltInDocumentation.commands);

  HelpArticle? _selectedArticle;

  /// Currently selected documentation article.
  HelpArticle? get selectedArticle => _selectedArticle;

  /// Selects [article] to view in documentation viewer.
  void selectArticle(HelpArticle article) {
    _selectedArticle = article;
    notifyListeners();
  }
}
