import 'package:cloud_firestore/cloud_firestore.dart';

class AppNotificationModel {
  const AppNotificationModel({
    required this.id,
    required this.kind,
    required this.title,
    required this.body,
    required this.data,
    required this.createdAt,
    this.readAt,
  });

  factory AppNotificationModel.fromJson(Map<String, dynamic> json) {
    DateTime? parseDate(Object? value) {
      if (value is Timestamp) {
        return value.toDate();
      }
      if (value is DateTime) {
        return value;
      }
      if (value is num) {
        return DateTime.fromMillisecondsSinceEpoch(value.toInt());
      }
      if (value is String) {
        return DateTime.tryParse(value);
      }
      return null;
    }

    return AppNotificationModel(
      id: json['id'] as String? ?? '',
      kind: json['kind'] as String? ?? 'general',
      title: json['title'] as String? ?? 'MultiBook',
      body: json['body'] as String? ?? '',
      data: Map<String, String>.from(
        (json['data'] as Map<Object?, Object?>? ?? const {}).map(
          (key, value) => MapEntry(key.toString(), value.toString()),
        ),
      ),
      createdAt: parseDate(json['createdAt']) ?? DateTime.now(),
      readAt: parseDate(json['readAt']),
    );
  }

  final String id;
  final String kind;
  final String title;
  final String body;
  final Map<String, String> data;
  final DateTime createdAt;
  final DateTime? readAt;

  bool get isRead => readAt != null;
}
