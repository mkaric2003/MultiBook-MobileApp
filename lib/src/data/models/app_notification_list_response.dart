import 'package:dart_mappable/dart_mappable.dart';
import 'package:multibook/src/data/models/app_notification_model.dart';

part 'app_notification_list_response.mapper.dart';

@MappableClass()
class AppNotificationListResponse with AppNotificationListResponseMappable {
  const AppNotificationListResponse({required this.items, this.nextCursor});

  final List<AppNotificationModel> items;
  final String? nextCursor;
}
