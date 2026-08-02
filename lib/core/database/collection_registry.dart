import 'package:isar/isar.dart';
import 'package:pixelcanvas/features/notifications/data/models/notification_model.dart';
import 'package:pixelcanvas/features/palette/data/models/palette_model.dart';
import 'package:pixelcanvas/features/projects/data/models/project_model.dart';
import 'package:pixelcanvas/features/settings/data/models/settings_model.dart';
import 'package:pixelcanvas/features/templates/data/models/template_model.dart';

/// Central collection registry exposing all Isar schemas per Blueprint §11.2.
abstract final class CollectionRegistry {
  /// Complete list of Isar collection schemas.
  static final List<CollectionSchema<dynamic>> schemas = [
    ProjectModelSchema,
    PaletteModelSchema,
    TemplateModelSchema,
    NotificationModelSchema,
    SettingsModelSchema,
  ];
}
