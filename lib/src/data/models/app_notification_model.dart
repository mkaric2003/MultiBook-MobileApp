import 'package:dart_mappable/dart_mappable.dart';

part 'app_notification_model.mapper.dart';

@MappableClass()
class AppNotificationModel with AppNotificationModelMappable {
  const AppNotificationModel({
    required this.id,
    required this.kind,
    required this.title,
    required this.body,
    required this.data,
    required this.createdAt,
    this.readAt,
  });

  final String id;
  final String kind;
  final String title;
  final String body;
  final Map<String, String> data;
  final DateTime createdAt;
  final DateTime? readAt;

  bool get isRead => readAt != null;
}
