// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'help_center_topic.dart';

class HelpCenterTopicMapper extends EnumMapper<HelpCenterTopic> {
  HelpCenterTopicMapper._();

  static HelpCenterTopicMapper? _instance;
  static HelpCenterTopicMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HelpCenterTopicMapper._());
    }
    return _instance!;
  }

  static HelpCenterTopic fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  HelpCenterTopic decode(dynamic value) {
    switch (value) {
      case r'stays':
        return HelpCenterTopic.stays;
      case r'appointments':
        return HelpCenterTopic.appointments;
      case r'changesAndCancellations':
        return HelpCenterTopic.changesAndCancellations;
      case r'payments':
        return HelpCenterTopic.payments;
      case r'accountAndPrivacy':
        return HelpCenterTopic.accountAndPrivacy;
      case r'messagesAndNotifications':
        return HelpCenterTopic.messagesAndNotifications;
      case r'technicalSupport':
        return HelpCenterTopic.technicalSupport;
      case r'safetyAndSupport':
        return HelpCenterTopic.safetyAndSupport;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(HelpCenterTopic self) {
    switch (self) {
      case HelpCenterTopic.stays:
        return r'stays';
      case HelpCenterTopic.appointments:
        return r'appointments';
      case HelpCenterTopic.changesAndCancellations:
        return r'changesAndCancellations';
      case HelpCenterTopic.payments:
        return r'payments';
      case HelpCenterTopic.accountAndPrivacy:
        return r'accountAndPrivacy';
      case HelpCenterTopic.messagesAndNotifications:
        return r'messagesAndNotifications';
      case HelpCenterTopic.technicalSupport:
        return r'technicalSupport';
      case HelpCenterTopic.safetyAndSupport:
        return r'safetyAndSupport';
    }
  }
}

extension HelpCenterTopicMapperExtension on HelpCenterTopic {
  String toValue() {
    HelpCenterTopicMapper.ensureInitialized();
    return MapperContainer.globals.toValue<HelpCenterTopic>(this) as String;
  }
}

