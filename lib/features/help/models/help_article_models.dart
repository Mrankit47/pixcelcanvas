import 'package:equatable/equatable.dart';

/// Help Center article descriptor.
class HelpArticle extends Equatable {
  const HelpArticle({
    required this.id,
    required this.title,
    required this.category,
    required this.markdownContent,
    this.tags = const [],
  });

  final String id;
  final String title;
  final String category;
  final String markdownContent;
  final List<String> tags;

  @override
  List<Object?> get props => [id, title, category, markdownContent, tags];
}

/// FAQ item descriptor.
class FAQItem extends Equatable {
  const FAQItem({
    required this.question,
    required this.answer,
    required this.category,
  });

  final String question;
  final String answer;
  final String category;

  @override
  List<Object?> get props => [question, answer, category];
}

/// Command reference entry.
class CommandReference extends Equatable {
  const CommandReference({
    required this.commandName,
    required this.category,
    required this.shortcut,
    required this.description,
    required this.usage,
  });

  final String commandName;
  final String category;
  final String shortcut;
  final String description;
  final String usage;

  @override
  List<Object?> get props => [commandName, category, shortcut, description, usage];
}

/// Learning achievement badge descriptor.
class LearningAchievement extends Equatable {
  const LearningAchievement({
    required this.id,
    required this.title,
    required this.description,
    required this.iconName,
    this.isUnlocked = false,
  });

  final String id;
  final String title;
  final String description;
  final String iconName;
  final bool isUnlocked;

  LearningAchievement copyWith({bool? isUnlocked}) => LearningAchievement(
        id: id,
        title: title,
        description: description,
        iconName: iconName,
        isUnlocked: isUnlocked ?? this.isUnlocked,
      );

  @override
  List<Object?> get props => [id, title, description, iconName, isUnlocked];
}

/// Release note entry for What's New screen.
class ReleaseNote extends Equatable {
  const ReleaseNote({
    required this.version,
    required this.releaseDate,
    required this.highlights,
  });

  final String version;
  final String releaseDate;
  final List<String> highlights;

  @override
  List<Object?> get props => [version, releaseDate, highlights];
}
