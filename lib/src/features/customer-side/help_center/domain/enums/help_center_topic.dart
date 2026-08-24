import 'package:dart_mappable/dart_mappable.dart';

part 'help_center_topic.mapper.dart';

@MappableEnum()
enum HelpCenterTopic {
  stays,
  appointments,
  changesAndCancellations,
  payments,
  accountAndPrivacy,
  messagesAndNotifications,
  technicalSupport,
  safetyAndSupport,
}
